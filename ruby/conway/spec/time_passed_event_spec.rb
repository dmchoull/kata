require 'spec_helper.rb'

describe TimePassedEvent do
  let(:event) { TimePassedEvent.new }

  describe '#trigger' do
    subject(:cell) { instance_double(Cell, alive?: alive, neighbour_count: neighbour_count) }

    after do
      event.trigger(cell)
    end

    context 'live cell' do
      let(:alive) { true }

      context 'with less than two neighbours' do
        let(:neighbour_count) { 1 }

        it { is_expected.to receive(:die!) }
      end

      context 'with two neighbours' do
        let(:neighbour_count) { 2 }

        it { is_expected.to_not receive(:die!) }
      end

      context 'with three neighbours' do
        let(:neighbour_count) { 3 }

        it { is_expected.to_not receive(:die!) }
      end

      context 'with more than three neighbours' do
        let(:neighbour_count) { 4 }

        it { is_expected.to receive(:die!) }
      end
    end

    context 'dead cell' do
      let(:alive) { false }

      context 'with less than three neighbours' do
        let(:neighbour_count) { 2 }

        it { is_expected.to_not receive(:live!) }
      end

      context 'with three neighbours' do
        let(:neighbour_count) { 3 }

        it { is_expected.to receive(:live!) }
      end

      context 'with more than three neighbours' do
        let(:neighbour_count) { 4 }

        it { is_expected.to_not receive(:live!) }
      end
    end
  end
end
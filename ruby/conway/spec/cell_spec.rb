require 'spec_helper.rb'

describe Cell do
  subject(:cell) { ::Cell.new(Location.new(1, 2), event_queue, alive).tap { |cell| cell.neighbour_count = neighbour_count } }
  let(:alive) { true }
  let(:event_queue) { instance_double(EventQueue, enq: nil) }
  let(:neighbour_count) { 1 }

  describe 'creation' do
    context 'of initially live cell' do
      it { is_expected.to be_alive }
    end

    context 'of initially dead cell' do
      let(:alive) { false }
      it { is_expected.to_not be_alive }
    end
  end

  describe '#live!' do
    context 'live cell' do
      it 'should remain alive' do
        cell.live!
        expect(cell).to be_alive
      end

      it 'should not create any events' do
        expect(event_queue).to_not receive(:enq)
        cell.live!
      end
    end

    context 'dead cell' do
      let(:alive) { false }

      it 'should come to life' do
        cell.live!
        expect(cell).to be_alive
      end

      it 'should send a cell added event to the event queue' do
        expect(event_queue).to receive(:enq).with(an_instance_of(CellAddedEvent)) do |event|
          expect(event.location).to eq(cell.location)
        end

        cell.live!
      end
    end
  end

  describe '#die!' do
    context 'live cell' do
      it 'should die' do
        cell.die!
        expect(cell).to_not be_alive
      end

      it 'should send a cell removed event to the event queue' do
        expect(event_queue).to receive(:enq).with(an_instance_of(CellRemovedEvent)) do |event|
          expect(event.location).to eq(cell.location)
        end

        cell.die!
      end
    end

    context 'dead cell' do
      let(:alive) { false }

      it 'should come to life' do
        cell.live!
        expect(cell).to be_alive
      end

      it 'should not create any events ' do
        expect(event_queue).to receive(:enq)
        cell.live!
      end
    end
  end

  describe '#notify' do
    it 'should trigger the event with itself' do
      event = instance_double(CellAddedEvent)
      expect(event).to receive(:trigger).with(cell)
      cell.notify(event)
    end
  end

  describe '#neighbour?' do
    it 'should return true if the other location is within 1 unit in both directions' do
      expect(cell.neighbour?(Location.new(2, 3))).to be_truthy
    end

    it 'should return false if the other location is not within 1 unit in both directions' do
      expect(cell.neighbour?(Location.new(3, 3))).to be_falsey
    end

    it 'should return false if the other location is this cell`s location' do
      expect(cell.neighbour?(cell.location)).to be_falsey
    end
  end

  describe '#display' do
    context 'when alive' do
      its(:display) { is_expected.to eq '*' }
    end

    context 'when dead' do
      let(:alive) { false }

      its(:display) { is_expected.to eq '.' }
    end
  end
end

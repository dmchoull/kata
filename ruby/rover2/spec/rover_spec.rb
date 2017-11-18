require 'ostruct'

describe Rover do
  subject(:rover) { Rover.new(start_direction, start_x, start_y) }
  let(:start_direction) { 'N' }
  let(:start_x) { 1 }
  let(:start_y) { 2 }

  describe '#execute' do
    it 'should execute the command' do
      command = double(:command)
      expect(command).to receive(:execute).with(rover)
      rover.execute(command)
    end
  end

  describe '#turn_right' do
    [
        {start: 'N', result: 'E'},
        {start: 'E', result: 'S'},
        {start: 'S', result: 'W'},
        {start: 'W', result: 'N'}
    ].each do |data|
      context "from #{data[:start]}" do
        let(:start_direction) { data[:start] }

        before do
          rover.turn_right
        end

        its(:direction) { is_expected.to eq Direction::DIR_NAME_LOOKUP[data[:result]] }
      end
    end
  end

  describe '#turn_left' do
    [
        {start: 'N', result: 'W'},
        {start: 'E', result: 'N'},
        {start: 'S', result: 'E'},
        {start: 'W', result: 'S'}
    ].each do |data|
      context "from #{data[:start]}" do
        let(:start_direction) { data[:start] }

        before do
          rover.turn_left
        end

        its(:direction) { is_expected.to eq Direction::DIR_NAME_LOOKUP[data[:result]] }
      end
    end
  end

  describe '#move_forward' do
    [
        {start: 'N', result: OpenStruct.new(x_delta: 0, y_delta: 1)},
        {start: 'E', result: OpenStruct.new(x_delta: 1, y_delta: 0)},
        {start: 'S', result: OpenStruct.new(x_delta: 0, y_delta: -1)},
        {start: 'W', result: OpenStruct.new(x_delta: -1, y_delta: 0)},
    ].each do |data|
      context "when facing #{data[:start]}" do
        let(:start_direction) { data[:start] }

        before { rover.move_forward }

        its(:x) { is_expected.to eq(start_x + data[:result].x_delta) }
        its(:y) { is_expected.to eq(start_y + data[:result].y_delta) }
      end
    end
  end
end
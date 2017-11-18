describe GameWindow do
  subject(:window) { GameWindow.new }
  let(:lander) { instance_double(Lander, :input= => nil) }

  before do
    allow(Surface).to receive(:create)
    allow(Lander).to receive(:create).and_return(lander)
  end

  describe '#create_game_objects' do
    it 'should create the surface' do
      expect(Surface).to receive(:create)
      window.create_game_objects
    end

    it 'should create the lander' do
      expect(Lander).to receive(:create)
      window.create_game_objects
    end

    describe 'lander input' do
      before do
        expect(lander).to receive(:input=) { |input| @input = input }
      end

      it 'should turn counter-clockwise while left is held' do
        window.create_game_objects

        expect(window.lander).to receive(:execute).with(a_kind_of(RotateCommand)) do |command|
          expect(command.degrees).to eq(-Lander::TURN_RATE)
        end

        @input[:holding_left].call
      end

      it 'should turn clockwise while right is held' do
        window.create_game_objects

        expect(window.lander).to receive(:execute).with(a_kind_of(RotateCommand)) do |command|
          expect(command.degrees).to eq(Lander::TURN_RATE)
        end

        @input[:holding_right].call
      end

      it 'should turn on the engine when up is pressed' do
        window.create_game_objects

        expect(window.lander).to receive(:execute).with(a_kind_of(StartEngineCommand))

        @input[:up].call
      end

      it 'should turn on the engine when up is pressed' do
        window.create_game_objects

        expect(window.lander).to receive(:execute).with(a_kind_of(StopEngineCommand))

        @input[:released_up].call
      end
    end
  end

  describe '#update' do
    it 'should notify the lander of touchdown when it collides with the surface' do
      expect(Lander).to receive(:each_collision).with(Surface).and_yield(lander)
      expect(lander).to receive(:touchdown)
      window.update
    end
  end
end
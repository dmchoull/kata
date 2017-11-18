shared_examples 'a rover command' do |command_method|
  let(:command) { described_class.new }

  describe '#execute' do
    it "should call #{command_method} on the rover" do
      rover = Rover.new('N', 1, 2)
      expect(rover).to receive(command_method)
      command.execute(rover)
    end
  end
end
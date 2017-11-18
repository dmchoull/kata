describe RoverCommands do
  describe '.define' do
    before do
      RoverCommands.define do
        command 'T', ->(arg) { arg.method_name }
      end
    end

    it 'should be able to define a command' do
      expect(RoverCommands['X']).to be_nil
      expect(RoverCommands['T']).not_to be_nil
    end

    it 'should be able to execute a defined command' do
      command_arg = double(:command_arg)
      expect(command_arg).to receive(:method_name)
      RoverCommands['T'].execute(command_arg)
    end
  end
end
describe StopEngineCommand do
  describe '#execute' do
    it 'turn the lander`s engine off' do
      lander = instance_double(Lander)
      expect(lander).to receive(:turn_engine_off)

      subject.execute(lander)
    end
  end
end
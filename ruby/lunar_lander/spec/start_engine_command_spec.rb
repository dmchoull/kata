describe StartEngineCommand do
  describe '#execute' do
    it 'turn the lander`s engine on' do
      lander = instance_double(Lander)
      expect(lander).to receive(:turn_engine_on)

      subject.execute(lander)
    end
  end
end
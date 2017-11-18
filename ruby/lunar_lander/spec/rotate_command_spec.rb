describe RotateCommand do
  subject { RotateCommand.new(degrees) }
  let(:degrees) { 5 }

  describe '#execute' do
    it 'turn rotate the lander' do
      lander = instance_double(Lander)
      expect(lander).to receive(:rotate).with(degrees)

      subject.execute(lander)
    end
  end
end
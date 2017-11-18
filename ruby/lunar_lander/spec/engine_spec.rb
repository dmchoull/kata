describe Engine do
  it { is_expected.not_to be_on }

  describe '#turn_on' do
    before { subject.turn_on }

    it { is_expected.to be_on }
  end

  describe '#turn_off' do
    before { subject.turn_off }

    it { is_expected.not_to be_on }
  end
end
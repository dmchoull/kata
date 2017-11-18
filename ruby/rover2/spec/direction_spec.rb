describe Direction do
  describe '.create' do
    it 'should return a Direction corresponding to the given string' do
      expect(Direction.create('N')).to eq Direction::NORTH
    end

    it 'raise an exception when given an unknown direction' do
      expect { Direction.create('Z').to raise_error 'Unknown direction "Z"'}
    end
  end

  describe '#+' do
    it 'should add to the angle' do
      direction = Direction.new(45)
      direction += 10
      expect(direction.angle).to eq 55
    end

    it 'should wrap around at 360' do
      direction = Direction.new(359)
      direction += 1
      expect(direction.angle).to eq 0
    end
  end

  describe '#-' do
    it 'should subtract from to the angle' do
      direction = Direction.new(45)
      direction -= 10
      expect(direction.angle).to eq 35
    end

    it 'should wrap around at 0' do
      direction = Direction.new(0)
      direction -= 1
      expect(direction.angle).to eq 359
    end
  end

  describe '#==' do
    it 'should equal a direction with the same angle' do
      expect(Direction.new(10)).to eq Direction.new(10)
    end

    it 'should not equal a direction with a different angle' do
      expect(Direction.new(10)).not_to eq Direction.new(50)
    end
  end
end
describe Lander do
  subject(:lander) { Lander.create.tap { |lander| lander.angle = angle } }
  let(:angle) { 0 }

  describe '#update' do
    context 'when engine is off' do
      it 'should decelerate' do
        start_x_vel, start_y_vel = lander.velocity_x, lander.velocity_y

        lander.update

        expect(lander.velocity_x).to eq(start_x_vel + Gosu::offset_x(0, Lander::DECELERATION_RATE))
        expect(lander.velocity_y).to eq(start_y_vel + Gosu::offset_y(0, Lander::DECELERATION_RATE))
      end

      it 'should move' do
        start_x, start_y = lander.x, lander.y

        lander.update

        expect([lander.x, lander.y]).to eq([start_x + lander.velocity_x, start_y + lander.velocity_y])
      end
    end

    context 'when engine is on' do
      before do
        allow(lander.engine).to receive(:on?).and_return(true)
      end

      it 'should accelerate' do
        start_x_vel, start_y_vel = lander.velocity_x, lander.velocity_y

        lander.update

        net_accelation_x = Gosu::offset_x(lander.angle, Lander::ACCELERATION_RATE) + Gosu::offset_x(0, Lander::DECELERATION_RATE)
        net_accelation_y = Gosu::offset_y(lander.angle, Lander::ACCELERATION_RATE) + Gosu::offset_y(0, Lander::DECELERATION_RATE)

        expect(lander.velocity_x).to eq(start_x_vel + net_accelation_x)
        expect(lander.velocity_y).to eq(start_y_vel + net_accelation_y)
      end

      it 'should move' do
        start_x, start_y = lander.x, lander.y

        lander.update

        expect([lander.x, lander.y]).to eq([start_x + lander.velocity_x, start_y + lander.velocity_y])
      end
    end
  end

  describe '#execute' do
    it 'should execute a command' do
      command = double(:command)
      expect(command).to receive(:execute).with(lander)

      lander.execute(command)
    end
  end

  describe '#turn_engine_on' do
    it 'should turn the engine on' do
      expect(lander.engine).to receive(:turn_on)
      lander.turn_engine_on
    end

    it 'should display the engine on image' do
      lander.turn_engine_on
      expect(lander.image).to eq(lander.images[:engine_on])
    end
  end

  describe '#turn_engine_off' do
    it 'should turn the engine off' do
      expect(lander.engine).to receive(:turn_off)
      lander.turn_engine_off
    end

    it 'should display the engine off image' do
      lander.turn_engine_off
      expect(lander.image).to eq(lander.images[:engine_off])
    end
  end

  describe '#has_engine_on?' do
    before { expect(lander.engine).to receive(:on?).and_return engine_on }

    context 'when engine is on' do
      let(:engine_on) { true }

      it { is_expected.to have_engine_on }
    end

    context 'when engine is off' do
      let(:engine_on) { false }

      it { is_expected.not_to have_engine_on }
    end
  end

  describe '#rotate' do
    context 'on ground' do
      before do
        lander.touchdown
      end

      it 'should not turn' do
        expect { lander.rotate(1) }.to change(lander, :angle).by 0
      end
    end

    context 'not on ground' do
      it 'should turn the amount indicated' do
        expect { lander.rotate(1) }.to change(lander, :angle).by 1
      end

      context 'wrapping around' do
        let(:angle) { 359 }

        before { lander.rotate(1) }

        its(:angle) { is_expected.to eq 0 }
      end
    end
  end

  describe '#touchdown' do
    context 'before touchdown' do
      it { is_expected.not_to be_on_ground }
    end
  end

  context 'after touchdown' do
    before do
      lander.turn_engine_on
      lander.update
      lander.touchdown
    end

    it { is_expected.to be_on_ground }
    it { is_expected.not_to have_engine_on }
    its(:velocity_x) { is_expected.to eq(0) }
    its(:velocity_y) { is_expected.to eq(0) }
  end
end

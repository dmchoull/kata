require 'spec_helper.rb'

describe Life do
  subject(:life) { Life.new(3, 2) }

  it 'should start off empty' do
    expect(life.display).to eq(". . .\n. . .\n")
  end

  it 'should subscribe each cell as a listener of the event queue' do
    expect(life.event_queue.listeners).to eq(life.cells)
  end

  describe '#add_cell' do
    it 'should be possible to add a cell to every space' do
      3.times { |x| 2.times { |y| life.add_cell(x + 1, y + 1) } }

      expect(life.display).to eq("* * *\n* * *\n")
    end

    it 'should bring the cell at the given location to life' do
      expect(life.cells[1]).to receive(:live!)
      life.add_cell(2, 1)
    end
  end

  describe '#next_generation' do
    it 'should enqueue a time passed event' do
      expect(life.event_queue).to receive(:enq).with(an_instance_of(TimePassedEvent))
      life.next_generation
    end

    it 'should drain the event queue' do
      expect(life.event_queue).to receive(:drain)
      life.next_generation
    end

    # * * .
    # . . .
    context 'with less than two neighbours' do
      it 'should have dead cells in the next generation' do
        life.add_cell(1, 1)
        life.add_cell(2, 1)

        life.next_generation

        expect(life.display).to eq(". . .\n. . .\n")
      end
    end

    # * . .
    # . * *
    context 'with two or more neighbours' do
      it 'should have living cells in the next generation' do
        life.add_cell(1, 1)
        life.add_cell(2, 2)
        life.add_cell(3, 2)

        life.next_generation

        expect(life.display).to eq(". * .\n. * .\n")
      end
    end


    # * * *
    # * * *
    context 'over-population' do
      it 'should lead to death' do
        3.times { |x| 2.times { |y| life.add_cell(x + 1, y + 1) } }

        life.next_generation

        expect(life.display).to eq("* . *\n* . *\n")
      end
    end

    # * . .
    # . * *
    context 'multiple generations' do
      it 'should die out without enough neighbours' do
        life.add_cell(1, 1)
        life.add_cell(2, 2)
        life.add_cell(3, 2)

        life.next_generation
        life.next_generation

        expect(life.display).to eq(". . .\n. . .\n")
      end
    end
  end
end

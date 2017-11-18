require 'spec_helper.rb'

describe CellRemovedEvent do
  subject(:event) { CellRemovedEvent.new(event_location) }
  let(:cell) { ::Cell.new(Location.new(1, 2), double(:event_queue)).tap { |cell| cell.neighbour_count = 1 } }

  describe '#trigger' do
    context 'inside the cell`s neighbourhood' do
      let(:event_location) { Location.new(2, 1) }

      it 'should decrease the neighbour count of the cell' do
        expect { event.trigger(cell) }.to change(cell, :neighbour_count).by(-1)
      end
    end

    context 'outside the cell`s neighbourhood' do
      let(:event_location) { Location.new(3, 1) }

      it 'should not change the neighbour count of the cell' do
        expect { event.trigger(cell) }.not_to change(cell, :neighbour_count)
      end
    end
  end
end

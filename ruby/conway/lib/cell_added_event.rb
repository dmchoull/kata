require_relative 'cell_event'

class CellAddedEvent < CellEvent
  def trigger(cell)
    cell.neighbour_count += 1 if cell.neighbour?(location)
  end
end
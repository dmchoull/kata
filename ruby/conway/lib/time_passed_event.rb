require_relative 'cell_event'

class TimePassedEvent < CellEvent
  def initialize
  end

  def trigger(cell)
    if cell.alive?
      cell.die! if cell.neighbour_count < 2 || cell.neighbour_count > 3
    else
      cell.live! if cell.neighbour_count == 3
    end
  end
end
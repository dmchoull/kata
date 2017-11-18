class Life
  attr_reader :cells, :event_queue

  def initialize(width, height)
    @width = width
    @event_queue = EventQueue.new

    @cells = Array.new(width * height) do |index|
      cell = ::Cell.new(index_to_location(index), @event_queue, false)
      @event_queue.subscribe(cell)
      cell
    end
  end

  def display
    cells.each_with_index.reduce('') do |display_str, (cell, index)|
      display_str += cell.display
      display_str += ((index + 1) % @width == 0) ? "\n" : ' '
    end
  end

  def add_cell(x, y)
    location = Location.new(x, y)
    cell = cells[location_to_index(location)]
    cell.live!
    cell
  end

  def next_generation
    event_queue.enq(TimePassedEvent.new)
    event_queue.drain
  end

  private

  def index_to_location(index)
    x = (index % @width) + 1
    y = (index / @width) + 1
    Location.new(x, y)
  end

  def location_to_index(location)
    (location.x - 1) + (location.y - 1) * @width
  end
end

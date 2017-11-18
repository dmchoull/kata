class Cell
  attr_accessor :location, :neighbour_count

  def initialize(location, event_queue, alive=true)
    @location = location
    @alive = alive
    @event_queue = event_queue
    @neighbour_count = 0
  end

  def live!
    @event_queue.enq(CellAddedEvent.new(location)) unless alive?
    @alive = true
  end

  def die!
    @event_queue.enq(CellRemovedEvent.new(location)) if alive?
    @alive = false
  end

  def alive?
    @alive
  end

  def notify(event)
    event.trigger(self)
  end

  def neighbour?(other_location)
    location != other_location &&
        (location.x - other_location.x).abs <= 1 && (location.y - other_location.y).abs <= 1
  end

  def display
    alive? ? '*' : '.'
  end

  def to_s
    "(#{location.x}, #{location.y}) | neighbours: #{neighbour_count} | #{alive? ? 'alive' : 'dead'}"
  end
end
require 'forwardable'

class EventQueue
  extend Forwardable
  attr_reader :events, :listeners

  def_delegators :events, :pop, :enq

  def initialize
    @listeners = []
    @events = Queue.new
  end

  def subscribe(listener)
    @listeners << listener
  end

  def drain
    until @events.empty? do
      event = pop
      listeners.each { |listener| listener.notify(event) }
    end
  end
end
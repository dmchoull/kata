require 'forwardable'
require_relative 'direction'
require_relative 'position'

class Rover
  extend Forwardable

  attr_reader :direction
  def_delegators :@position, :x, :y

  TURN_DEGREES = 90

  def initialize(direction_name, x, y)
    @direction = Direction.create(direction_name)
    @position = Position.new(x, y)
  end

  def execute(command)
    command.execute(self)
  end

  def turn_right
    @direction += TURN_DEGREES
  end

  def turn_left
    @direction -= TURN_DEGREES
  end

  def move_forward
    @position.advance(@direction)
  end
end
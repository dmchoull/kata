require 'gosu'
require 'chingu'
require_relative 'surface'
require_relative 'lander'
require_relative 'rotate_command'
require_relative 'start_engine_command'
require_relative 'stop_engine_command'

class GameWindow < Chingu::Window
  attr_accessor :lander, :surface

  X_RES = 1024
  Y_RES = 768

  def initialize
    unless $TEST
      super(X_RES, Y_RES)
      self.caption = 'Lunar Lander'
    end
    create_game_objects
  end

  def create_game_objects
    @surface = Surface.create
    @lander = Lander.create(x: X_RES/2, y: Y_RES/2)
    @lander.input = {
        holding_left: ->() { @lander.execute(RotateCommand.new(-Lander::TURN_RATE)) },
        holding_right: ->() { @lander.execute(RotateCommand.new(Lander::TURN_RATE)) },
        up: ->() { @lander.execute(StartEngineCommand.new) },
        released_up: ->() { @lander.execute(StopEngineCommand.new) }
    }
  end

  def update
    super unless $TEST
    Lander.each_collision(Surface) { |lander| lander.touchdown }
  end
end
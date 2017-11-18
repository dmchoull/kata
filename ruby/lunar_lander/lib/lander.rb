require 'forwardable'
require 'gosu'
require_relative 'engine'

class Lander < Chingu::GameObject
  extend Forwardable
  attr_reader :velocity_x, :velocity_y, :engine, :images

  def_delegator :@engine, :on?, :has_engine_on?

  trait :bounding_box
  trait :collision_detection

  ACCELERATION_RATE = 0.01
  DECELERATION_RATE = -0.005
  TURN_RATE = 2

  def initialize(options={})
    @velocity_x = @velocity_y = 0.0
    @engine = Engine.new
    @images = {engine_on: Gosu::Image['lander_engine_on.png'], engine_off: Gosu::Image['lander_engine_off.png']}

    super(options.merge(image: images[:engine_off]))
    cache_bounding_box unless $TEST
  end

  def update
    if engine.on?
      accelerate
    end

    decelerate
    move
  end

  private

  def accelerate
    @velocity_x += Gosu::offset_x(@angle, ACCELERATION_RATE)
    @velocity_y += Gosu::offset_y(@angle, ACCELERATION_RATE)
  end

  def decelerate
    @velocity_x += Gosu::offset_x(0, DECELERATION_RATE)
    @velocity_y += Gosu::offset_y(0, DECELERATION_RATE)
  end

  def move
    @x += @velocity_x
    @y += @velocity_y
  end

  public

  def to_s
    "Lander at (#{x}, #{y}) with velocity (#{velocity_x}, #{velocity_y})"
  end

  def execute(command)
    command.execute(self)
  end

  def rotate(degrees)
    @angle = (@angle + degrees) % 360 unless on_ground?
  end

  def turn_engine_on
    @image = images[:engine_on]
    engine.turn_on
  end

  def turn_engine_off
    @image = images[:engine_off]
    engine.turn_off
  end

  def touchdown
    turn_engine_off
    @on_ground = true
    @velocity_x = @velocity_y = 0.0
  end

  def on_ground?
    @on_ground
  end
end
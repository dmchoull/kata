class Engine
  def initialize
    @on = false
  end

  def turn_on
    @on = true
  end

  def turn_off
    @on = false
  end

  def on?
    @on
  end
end
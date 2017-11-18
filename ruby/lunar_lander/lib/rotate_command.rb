class RotateCommand
  attr_reader :degrees

  def initialize(degrees)
    @degrees = degrees
  end

  def execute(lander)
    lander.rotate(@degrees)
  end
end
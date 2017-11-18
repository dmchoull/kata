class Direction
  attr_reader :angle

  def initialize(angle)
    @angle = angle
  end

  NORTH = Direction.new(0).freeze
  EAST = Direction.new(90).freeze
  SOUTH = Direction.new(180).freeze
  WEST = Direction.new(270).freeze

  DIR_NAME_LOOKUP = {
      'N' => NORTH,
      'E' => EAST,
      'S' => SOUTH,
      'W' => WEST
  }

  def self.create(direction_name)
    DIR_NAME_LOOKUP[direction_name] or raise "Unknown direction \"#{direction_name}\""
  end

  def +(degrees)
    Direction.new((@angle + degrees) % 360)
  end

  def -(degrees)
    Direction.new((@angle - degrees) % 360)
  end

  def ==(other)
    @angle == other.angle
  end
end
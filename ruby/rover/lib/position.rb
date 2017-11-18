class Position < Struct.new(:x, :y)
  def advance(direction)
    case direction
      when Direction::NORTH
        self.y += 1
      when Direction::EAST
        self.x += 1
      when Direction::SOUTH
        self.y -= 1
      when Direction::WEST
        self.x -= 1
    end
  end
end
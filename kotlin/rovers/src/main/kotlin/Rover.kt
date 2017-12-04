class Rover(initialCoords: Coordinates, initialDir: Direction) {
    var coordinates: Coordinates = initialCoords
        private set(value) {
            field = value
        }

    var direction: Direction = initialDir
        private set(value) {
            field = value
        }

    fun moveForward() {
        coordinates = coordinates.move(direction)
    }

    fun turnLeft() {
        direction = direction.rotateLeft()
    }

    fun turnRight() {
        direction = direction.turnRight()
    }
}

interface Coordinates {
    fun move(direction: Direction): Coordinates
}

data class Coordinates2D(private val x: Int, private val y: Int) : Coordinates {
    override fun move(direction: Direction) = when (direction) {
        Direction.NORTH -> Coordinates2D(x, y + 1)
        Direction.EAST -> Coordinates2D(x + 1, y)
        Direction.SOUTH -> Coordinates2D(x, y - 1)
        Direction.WEST -> Coordinates2D(x - 1, y)
    }
}

enum class Direction {
    NORTH, EAST, SOUTH, WEST;

    fun rotateLeft() = values()[if (ordinal == 0) values().size - 1 else ordinal - 1]

    fun turnRight() = values()[(ordinal + 1) % values().size]
}

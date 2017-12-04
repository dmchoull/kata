import org.amshove.kluent.shouldEqual
import org.jetbrains.spek.api.Spek
import org.jetbrains.spek.api.dsl.describe
import org.jetbrains.spek.api.dsl.it
import org.jetbrains.spek.api.dsl.on

internal class RoverTest : Spek({
    describe("moving forward") {
        listOf(
                Triple(Direction.NORTH, Coordinates2D(1, 2), Coordinates2D(1, 3)),
                Triple(Direction.EAST, Coordinates2D(1, 2), Coordinates2D(2, 2)),
                Triple(Direction.SOUTH, Coordinates2D(1, 2), Coordinates2D(1, 1)),
                Triple(Direction.WEST, Coordinates2D(2, 3), Coordinates2D(1, 3))
        ).forEach { (direction, initial, expected) ->
            on("a rover facing $direction") {
                val rover = Rover(initial, direction)

                it("moves from $initial to $expected") {
                    rover.moveForward()
                    rover.coordinates shouldEqual expected
                }
            }
        }
    }

    describe("turning left") {
        listOf(
                Direction.NORTH to Direction.WEST,
                Direction.WEST to Direction.SOUTH,
                Direction.SOUTH to Direction.EAST,
                Direction.EAST to Direction.NORTH
        ).forEach { (initial, expected) ->
            on("a rover facing $initial") {
                val rover = Rover(Coordinates2D(1, 2), initial)

                it("turns to $expected") {
                    rover.turnLeft()
                    rover.direction shouldEqual expected
                }
            }
        }
    }

    describe("turning right") {
        listOf(
                Direction.NORTH to Direction.EAST,
                Direction.EAST to Direction.SOUTH,
                Direction.SOUTH to Direction.WEST,
                Direction.WEST to Direction.NORTH
        ).forEach { (initial, expected) ->
            on("a rover facing $initial") {
                val rover = Rover(Coordinates2D(1, 2), initial)

                it("turns to $expected") {
                    rover.turnRight()
                    rover.direction shouldEqual expected
                }
            }
        }
    }
})

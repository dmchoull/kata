defmodule RoverTest do
  use ExUnit.Case, async: true
  doctest Rover

  describe "at" do
    test "makes a rover at the position and direction" do
      rover = Rover.at({1, 2}, :N)
      assert rover.position == {1, 2}
      assert rover.direction == :N
    end
  end

  describe "status" do
    test "returns a string with the current position and direction" do
      assert Rover.status(Rover.at({1, 2}, :N)) == "1 2 N"
    end
  end

  test "turning left" do
    assert Rover.turn_left(Rover.at({1, 2}, :N)) == Rover.at({1, 2}, :W)
    assert Rover.turn_left(Rover.at({1, 2}, :W)) == Rover.at({1, 2}, :S)
    assert Rover.turn_left(Rover.at({1, 2}, :S)) == Rover.at({1, 2}, :E)
    assert Rover.turn_left(Rover.at({1, 2}, :E)) == Rover.at({1, 2}, :N)
  end

  test "turning right" do
    assert Rover.turn_right(Rover.at({1, 2}, :N)) == Rover.at({1, 2}, :E)
    assert Rover.turn_right(Rover.at({1, 2}, :W)) == Rover.at({1, 2}, :N)
    assert Rover.turn_right(Rover.at({1, 2}, :S)) == Rover.at({1, 2}, :W)
    assert Rover.turn_right(Rover.at({1, 2}, :E)) == Rover.at({1, 2}, :S)
  end

  test "moving forward" do
    assert Rover.move(Rover.at({1, 2}, :N)) == Rover.at({1, 3}, :N)
    assert Rover.move(Rover.at({1, 2}, :E)) == Rover.at({2, 2}, :E)
    assert Rover.move(Rover.at({1, 2}, :S)) == Rover.at({1, 1}, :S)
    assert Rover.move(Rover.at({1, 2}, :W)) == Rover.at({0, 2}, :W)
  end
end

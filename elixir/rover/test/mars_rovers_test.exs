defmodule MarsRoversTest do
  use ExUnit.Case
  doctest MarsRovers

  import ExUnit.CaptureIO

  test "reads input file and produces correct output" do
    assert capture_io(fn -> MarsRovers.main("./input.txt") end) == "1 3 N\n5 1 E\n"
  end
end

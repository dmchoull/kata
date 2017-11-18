defmodule ParserTest do
  use ExUnit.Case, async: true
  doctest Parser

  test "parsing an empty string" do
    assert Parser.parse("") == %MissionPlan{}
  end

  test "parsing the plateau" do
    assert Parser.parse("5 9\n") == %MissionPlan{
      plateau: %Plateau{width: 5, length: 9, rovers: []},
      rovers: []
    }
  end

  test "parsing rovers" do
    assert Parser.parse("5 9\n1 2 N\nLMLMLMLMM\n3 3 E\nMMRMMRMRRM\n") == %MissionPlan{
      plateau: %Plateau{width: 5, length: 9, rovers: []},
      rovers: [{Rover.at({1, 2}, :N), "LMLMLMLMM"}, {Rover.at({3, 3}, :E), "MMRMMRMRRM"}]
    }
  end
end

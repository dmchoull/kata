defmodule MissionControlTest do
  use ExUnit.Case, async: true
  doctest MissionControl

  test "sends commands to rovers" do
    plateau = %Plateau{rovers: [], length: 5, width: 5}
    rovers = [{Rover.at({1, 3}, :E), "MR"}, {Rover.at({1, 3}, :E), "LM"}]

    assert MissionControl.execute(%MissionPlan{plateau: plateau, rovers: rovers}) ==
      %Plateau{rovers: [Rover.at({2, 3}, :S), Rover.at({1, 4}, :N)], length: 5, width: 5}
  end
end

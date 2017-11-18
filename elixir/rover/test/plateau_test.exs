defmodule PlateauTest do
  use ExUnit.Case, async: true
  doctest Plateau

  test "adding rovers" do
    rover1 = Rover.at({1, 2}, :N)
    rover2 = Rover.at({5, 7}, :S)

    plateau = %Plateau{}
    |> Plateau.add_rover(rover1)
    |> Plateau.add_rover(rover2)

    assert plateau == %Plateau{rovers: [rover1, rover2]}
  end
end

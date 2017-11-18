defmodule MissionPlan do
  @moduledoc """
  Holds the required data for the mission: a Plateau with width/height and a list of tuples
  containing rovers with their initial positions and directions and a string of commands to be executed.

  ## Example
      %MissionPlan{
        plateau: %Plateau{width: 5, length: 9, rovers: []},
        rovers: [{Rover.at({1, 2}, :N), "LMLMLMLMM"}, {Rover.at({3, 3}, :E), "MMRMMRMRRM"}]
      }
  """

  defstruct plateau: %Plateau{}, rovers: []
end

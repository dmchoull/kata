defmodule MissionControl do
  @moduledoc """
  Executes the mission plan, given the Plateau and a list of {Rover, commands} tuples
  """

  def execute(%{plateau: plateau, rovers: rovers}) do
    do_execute(plateau, rovers)
  end

  defp do_execute(plateau, []), do: plateau

  defp do_execute(plateau, [{rover, commands} | rest]) do
    plateau
    |> process_commands(rover, String.codepoints(commands))
    |> do_execute(rest)
  end

  defp process_commands(plateau, rover, []), do: Plateau.add_rover(plateau, rover)

  defp process_commands(plateau, rover, [command | rest]) do
    process_commands(plateau, send_command(rover, command), rest)
  end

  defp send_command(rover, "M"), do: Rover.move(rover)
  defp send_command(rover, "L"), do: Rover.turn_left(rover)
  defp send_command(rover, "R"), do: Rover.turn_right(rover)
end

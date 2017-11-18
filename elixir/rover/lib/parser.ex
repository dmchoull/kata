defmodule Parser do
  @moduledoc """
  Parses input file
  """

  @doc ~S"""
  Parses input and returns a MissionPlan containing the plateau and rovers
  """

  @spec parse(String.t) :: %MissionPlan{}

  def parse(""), do: %MissionPlan{}

  def parse(content) do
    content
    |> String.split("\n", trim: true)
    |> do_parse
  end

  def do_parse([plateau_line | rover_lines]) do
    result = parse_plateau(plateau_line, %MissionPlan{})
    parse_rover_lines(rover_lines, result)
  end

  defp parse_plateau(plateau_line, result) do
    [width, length] = plateau_line
                      |> String.split
                      |> Enum.map(&String.to_integer/1)

    Map.put(result, :plateau, %Plateau{width: width, length: length})
  end

  defp parse_rover_lines([], result) do
    update_in(result.rovers, &Enum.reverse/1)
  end

  defp parse_rover_lines([position_line, command_line | rest], result) do
    parse_rover_lines(rest, parse_rover({position_line, command_line}, result))
  end

  defp parse_rover({position, commands}, result) do
    {position, direction} = parse_position_line(position)

    rover = Rover.at(position, direction)
    update_in(result.rovers, &List.insert_at(&1, 0, {rover, commands}))
  end

  defp parse_position_line(position) do
    {coordinates, [direction]} = position
                                 |> String.split
                                 |> Enum.split_while(&(&1 =~ ~r/\d/))

    {parse_position(coordinates), parse_direction(direction)}
  end

  defp parse_position(coordinates) do
    coordinates
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple
  end

  defp parse_direction(direction), do: String.to_atom(direction)
end

defmodule MarsRovers do
  @moduledoc """
  Handles input and output, using MissionControl to process the input
  """

  def main(input_file_name) do
    input_file_name
    |> read_input_file
    |> Parser.parse
    |> process_input
    |> output_result
  end

  defp read_input_file(filename) do
    case File.read(filename) do
      {:ok, content} -> content
      {:error, error_code} -> raise "Failed to read file: #{error_code}"
    end
  end

  defp process_input(data = %MissionPlan{}) do
    MissionControl.execute(data)
  end

  defp output_result(%Plateau{rovers: rovers}) do
    Enum.each(rovers, &(IO.puts Rover.status(&1)))
  end
end

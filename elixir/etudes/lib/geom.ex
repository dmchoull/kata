defmodule Geom do
  @moduledoc false
  
  @doc """
  Calculates the area of a rectangle with the given length and width

  Examples
  iex> Geom.area({:rectangle, 2, 5})
  10
  iex> Geom.area({:pentagon, 3, 4})
  0
  iex> Geom.area({:ellipse, -1, 5})
  0
  """

  @spec area({atom(), number(), number()}) :: number()

  def area({shape, a, b}), do: area(shape, a, b)

  defp area(shape, a, b) when a >= 0 and b >= 0 do
    case shape do
      :rectangle -> a * b
      :triangle -> a * b / 2.0
      :ellipse -> :math.pi * a * b
      _ -> 0
    end
  end

  defp area(_, _, _), do: 0
end

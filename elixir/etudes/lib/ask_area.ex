defmodule AskArea do
  @moduledoc false

  def ask_area do
    shape = IO.gets(:stdio, "R)ectangle, T)riangle, or E)llipse: ") |> String.strip |> get_shape

    {a, b} = case shape do
      :rectangle -> get_dimensions("length", "width")
      :triangle -> get_dimensions("base", "height")
      :ellipse -> get_dimensions("major radius", "minor radius")
      s -> {s, 0}
    end

    Geom.area({shape, a, b}) |> IO.puts
  end

  defp get_shape(str) do
    case str do
      "R" -> :rectangle
      "T" -> :triangle
      "E" -> :ellipse
      s -> s
    end
  end

  defp get_dimensions(prompt1, prompt2) do
    {a, _} = IO.gets(:stdio, "Enter #{prompt1} > ") |> Integer.parse
    {b, _} = IO.gets(:stdio, "Enter #{prompt2} > ") |> Integer.parse
    {a, b}
  end
end

defmodule Bowling2 do
  @spec score(list(list(integer))) :: integer

  def score(frames) do
    do_score(frames, 0)
  end

  defp do_score([], score), do: score

  defp do_score([[r1, r2] | rest], score) when r1 + r2 == 10 do
    do_score(rest, score + 10 + bonus(rest, 1))
  end

  defp do_score([[10] | rest], score) do
    do_score(rest, score + 10 + bonus(rest, 2))
  end

  defp do_score([frame | rest], score) do
    do_score(rest, score + Enum.sum(frame))
  end

  defp bonus(frames, num_rolls) do
    frames
    |> List.flatten
    |> Enum.take(num_rolls)
    |> Enum.sum
  end
end

defmodule Bowling do
  @spec score(list(list(integer))) :: integer

  def score(frames) do
    do_score(frames, 0)
  end

  defp do_score([], score), do: score

  # spare
  defp do_score([[roll1, roll2], [next_roll, _] = next_frame | rest], score) when roll1 + roll2 == 10 do
    do_score([next_frame | rest], score + 10 + next_roll)
  end

  # strike
  defp do_score([[10], [10], [10] | rest], score) do
    do_score([[10], [10] | rest], score + 30)
  end

  defp do_score([[10], [10], [next_roll, _] = next_frame | rest], score) do
    do_score([[10], next_frame | rest], score + 20 + next_roll)
  end

  defp do_score([[10], next_frame | rest], score) do
    do_score([next_frame | rest], score + 10 + Enum.sum(next_frame))
  end

  # standard frame
  defp do_score([frame | rest], score) do
    do_score(rest, score + Enum.sum(frame))
  end
end

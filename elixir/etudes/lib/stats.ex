defmodule Stats do
  @moduledoc false
  
  @spec minimum(Enum.t) :: number

  def minimum([head | tail]) do
    minimum(tail, head)
  end

  defp minimum([head | tail], current_min) when head < current_min do
    minimum(tail, head)
  end

  defp minimum([head | tail], current_min) when head >= current_min do
    minimum(tail, current_min)
  end

  defp minimum([], current_min) do
    current_min
  end

  @spec maximum(Enum.t) :: number

  def maximum([head | tail]) do
    maximum(tail, head)
  end

  defp maximum([head | tail], current_max) when head > current_max do
    maximum(tail, head)
  end

  defp maximum([head | tail], current_max) when head <= current_max do
    maximum(tail, current_max)
  end

  defp maximum([], current_max) do
    current_max
  end

  @spec range([number]) :: [number]

  def range(list) do
    [maximum(list), minimum(list)]
  end

  @spec mean([number]) :: float

  def mean(numbers) do
    sum = Enum.reduce(numbers, fn (n, acc) -> n + acc end)
    sum / Enum.count(numbers)
  end

  @spec stdv([number]) :: float

  def stdv(numbers) do
    sums = List.foldl numbers, {0, 0}, fn (x, acc) -> {x + elem(acc, 0), x * x + elem(acc, 1)} end

    sum = elem(sums, 0)
    sum_of_squares = elem(sums, 1)
    n = Enum.count(numbers)

    :math.sqrt((n * sum_of_squares - sum * sum) / (n * (n - 1)))
  end
end

defmodule PE.ListsRecursion do
  @moduledoc false

  @doc """
  Write a mapsum function that takes a list and a function. It applies the function to each element of the list and
  then sums the result.

  ## Examples
    iex> PE.ListsRecursion.mapsum [1,2,3,4], &(&1 + 2)
    18
  """

  def mapsum(list, func) do
    _mapsum(list, func, 0)
  end

  defp _mapsum([], _func, acc) do
    acc
  end

  defp _mapsum([head | tail], func, acc) do
    _mapsum(tail, func, func.(head) + acc)
  end

  @doc """
  Returns true if the given function returns true for all items in the list

  ## Examples
    iex> PE.ListsRecursion.all?([1, 2, 3], &(&1 > 0))
    true
    iex> PE.ListsRecursion.all?([1, 2, 3], &(&1 > 2))
    false
  """

  def all?([], _func) do
    true
  end

  def all?([head | tail], func) do
    func.(head) && all?(tail, func)
  end

  @doc """
  Calls the function with each item in the list

  ## Examples
    iex> PE.ListsRecursion.each([1, 2, 3], &(&1))
    :ok
  """

  def each([], _func), do: :ok

  def each([head | tail], func) do
    func.(head)
    each(tail, func)
  end

  @doc """
  Returns a list containing all the items that the function returned true for

  ## Examples
    iex> PE.ListsRecursion.filter([1, 2, 3, 4], &(rem(&1, 2) == 0))
    [2, 4]
  """

  def filter(list, func) do
    _filter(list, func, [])
  end

  defp _filter([], _func, filtered), do: Enum.reverse(filtered)

  defp _filter([head | tail], func, filtered) do
    if func.(head) do
      _filter(tail, func, [head | filtered])
    else
      _filter(tail, func, filtered)
    end
  end

  @doc """
  Splits list into two lists

  ## Examples
    iex> PE.ListsRecursion.split([1,2,3,4], 2)
    {[1, 2], [3, 4]}
    iex> PE.ListsRecursion.split([1,2,3,4], 10)
    {[1, 2, 3, 4], []}
    iex> PE.ListsRecursion.split([1, 2, 3], 0)
    {[], [1, 2, 3]}
    iex> PE.ListsRecursion.split([1, 2, 3, 4, 5], -2)
    {[1, 2, 3], [4, 5]}
  """

  def split(list, count) when count >= 0 do
    _split(list, count, {[], []})
  end

  def split(list, count) when count < 0 do
    {right, left} = _split(Enum.reverse(list), -count, {[], []})
    {Enum.reverse(left), Enum.reverse(right)}
  end

  defp _split([], _count, {left, right}), do: {Enum.reverse(left), Enum.reverse(right)}

  defp _split(list, 0, _), do: {[], list}

  defp _split([head | tail], count, {left, _}) when length(left) < count do
    _split(tail, count, {[head | left], tail})
  end

  defp _split(_list, _count, {left, right}) do
    {Enum.reverse(left), right}
  end

  @doc """
  iex> PE.ListsRecursion.take([1,2,3,4,5], 3)
  [1,2,3]
  iex> PE.ListsRecursion.take([1,2,3,4,5], 10)
  [1,2,3,4,5]
  iex> PE.ListsRecursion.take([1,2,3,4,5], 0)
  []
  """

  def take(list, count) when count >= 0 do
    _take(list, count, [])
  end

  defp _take([head | tail], count, taken) when length(taken) < count do
    _take(tail, count, [head | taken])
  end

  defp _take(list, count, taken) when length(list) == 0 or length(taken) == count do
    Enum.reverse(taken)
  end

  @doc """
  Write a max(list) that returns the element with the maximum value in the list.

  ## Examples

    iex> PE.ListsRecursion.max([1,2,3,4])
    4
    iex> PE.ListsRecursion.max([100,2,3,4])
    100
  """

  def max(list) do
    _max(list, Enum.at(list, 0))
  end

  defp _max([], max) do
    max
  end

  defp _max([head | tail], max) when head > max do
    _max(tail, head)
  end

  defp _max([head | tail], max) when head <= max do
    _max(tail, max)
  end

  @doc"""
  Write a flatten(list) function that takes a list that may contain any number of sublists, which themselves may contain sublists, to any depth.

  It returns the elements of these lists as a flat list.

  iex> PE.ListsRecursion.flatten([[1], 2, 3])
  [1, 2, 3]
  iex> PE.ListsRecursion.flatten([1, [2, 3, [4]], 5, [[[6]]]])
  [1, 2, 3, 4, 5, 6]
  """

  def flatten(list) do
    _flatten(list, [])
  end

  defp _flatten([], flat) do
    Enum.reverse flat
  end

  defp _flatten([[h | []] | tail], flat) do
    _flatten([h | tail], flat)
  end

  defp _flatten([[h | t] | tail], flat) do
    _flatten([h, t | tail], flat)
  end

  defp _flatten([head | tail], flat) do
    _flatten(tail, [head | flat])
  end
end

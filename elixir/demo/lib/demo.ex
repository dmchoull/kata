defmodule Demo do
  @moduledoc "Elixir Demo"

  @doc """
  Returns the number of occurrence of `search_char` in `char_list`

  ## Examples

      iex> Demo.char_count('aeiou', ?z)
      0
      iex> Demo.char_count('hello', ?l)
      2
  """

  def char_count(char_list, search_char) do
    do_char_count(char_list, search_char, 0)
  end

  defp do_char_count([], _char, count), do: count

  defp do_char_count([head | tail], char, count) when head == char do
    do_char_count(tail, char, count + 1)
  end

  defp do_char_count([_head | tail], char, count) do
    do_char_count(tail, char, count)
  end

  @doc """
  Run-length encodes the list

  ## Examples

      iex> Demo.encode([])
      []
      iex> Demo.encode([1])
      [1]
      iex> Demo.encode([1, 1, 2, 3, 3, 3])
      [{1, 2}, 2, {3, 3}]
      iex> Demo.encode(["a", "a", "b", "c", "foo", "foo"])
      [{"a", 2}, "b", "c", {"foo", 2}]
  """

  @spec encode(list(any)) :: list(any)

  def encode(list) do
    do_encode(list, [])
  end

  defp do_encode([], result), do: Enum.reverse(result)

  defp do_encode([a, a | tail], result) do
    do_encode([{a, 2} | tail], result)
  end

  defp do_encode([{a, n}, a | tail], result) do
    do_encode([{a, n + 1} | tail], result)
  end

  defp do_encode([a | tail], result) do
    do_encode(tail, [a | result])
  end
end

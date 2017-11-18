defmodule PE.Functions do
  @moduledoc false

  @doc """
    Write a function that takes three arguments. If the first two are zero, return “FizzBuzz.” If the first is zero,
    return “Fizz.” If the second is zero, return “Buzz.” Otherwise return the third argument.
    Do not use any language features that we haven’t yet covered in this book.

    ## Examples
      iex> PE.Functions.fizz_buzz(0, 0, 3)
      "FizzBuzz"
      iex> PE.Functions.fizz_buzz(0, 2, 3)
      "Fizz"
      iex> PE.Functions.fizz_buzz(1, 0, 3)
      "Buzz"
      iex> PE.Functions.fizz_buzz(1, 2, 3)
      3
  """

  def fizz_buzz(0, 0, _), do: "FizzBuzz"
  def fizz_buzz(0, _, _), do: "Fizz"
  def fizz_buzz(_, 0, _), do: "Buzz"
  def fizz_buzz(_, _, c), do: c

  @doc """
    The operator rem(a, b) returns the remainder after dividing a by b . Write a function that takes a single integer (n)
    and calls the function in the previous exercise, passing it rem(n,3) , rem(n,5) , and n. Call it seven times with the
    arguments 10, 11, 12, and so on. You should get “Buzz, 11, Fizz, 13, 14, FizzBuzz, 16.”

    ## Examples
      iex> PE.Functions.fizz_buzz(0)
      "FizzBuzz"
      iex> PE.Functions.fizz_buzz(1)
      1
      iex> PE.Functions.fizz_buzz(10)
      "Buzz"
      iex> PE.Functions.fizz_buzz(11)
      11
      iex> PE.Functions.fizz_buzz(15)
      "FizzBuzz"
  """
  def fizz_buzz(n) do
    fizz_buzz(rem(n, 3), rem(n, 5), n)
  end

  @doc """
    Write a function prefix that takes a string. It should return a new function that takes a second string. When that
    second function is called, it will return a string containing the first string, a space, and the second string.

    ## Exercises
    iex> PE.Functions.prefix("foo").("bar")
    "foo bar"
  """

  def prefix(pre_string) do
    fn string -> "#{pre_string} #{string}" end
  end
end

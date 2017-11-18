defmodule Calculus do
  @moduledoc false

  @delta 1.0e-10

  @doc """
  The first argument is the function whose derivative you wish to find, and the second argument is the point at which
  you are measuring the derivative.

  ## Examples
    iex> f1 = fn(x) -> x * x end
    iex> Calculus.derivative(f1, 3)
    6.00000049644222599454
    iex> Calculus.derivative(fn(x) -> 3 * x * x + 2 * x + 1 end, 5)
    32.00000264769187197089
    iex> Calculus.derivative(&:math.sin/1, 0)
    1.0
  """

  @spec derivative(((number) -> number), number) :: float

  def derivative(f, x) do
    (f.(x + @delta) - f.(x)) / @delta
  end
end

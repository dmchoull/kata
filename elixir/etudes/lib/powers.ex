defmodule Powers do
  @moduledoc false
  
  import Kernel, except: [raise: 2, raise: 3]

  @spec raise(number, number) :: number

  def raise(number, exponent) when exponent < 0 do
    1.0 / raise(number, -exponent)
  end

  def raise(_number, exponent) when exponent == 0 do
    1
  end

  def raise(number, exponent) when exponent > 0 do
    raise(number, exponent, 1)
  end

  defp raise(number, exponent, acc) when exponent > 0 do
    raise(number, exponent - 1, acc * number)
  end

  defp raise(_number, exponent, acc) when exponent == 0 do
    acc
  end

  @spec nth_root(number, number) :: float

  def nth_root(number, root) do
    nth_root(number, root, number / 2.0)
  end

  defp nth_root(x, n, a) do
    f = :math.pow(a, n) - x
    f_prime = n * :math.pow(a, n - 1)
    next = a - f / f_prime
    change = abs(next - a)

    IO.puts("Current Cahgne is #{change}")
    IO.puts("Current guess is #{a}")

    if change < 1.0e-8 do
      a
    else
      nth_root(x, n, next)
    end
  end
end

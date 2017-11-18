defmodule Dijkstra do
  @moduledoc false
  
  @doc """
  To find the GCD of integers M and N:

  * If M and N are equal, the result is M.
  * If M is greater than N, the result is the GCD of M - N and N
  * Otherwise M must be less than N, and the result is the GCD of M and N - M.
  """
  def gcd(m, n) when m == n, do: m

  def gcd(m, n) when m > n, do: gcd(m - n, n)

  def gcd(m, n), do: gcd(n, n - m)
end

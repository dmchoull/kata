defmodule DijkstraTest do
  use ExUnit.Case, async: true
  doctest Dijkstra

  test "calculates GCD" do
    assert Dijkstra.gcd(1, 1) == 1
    assert Dijkstra.gcd(2, 8) == 2
    assert Dijkstra.gcd(120, 36) == 12
  end
end

defmodule GeomTest do
  use ExUnit.Case, async: true
  doctest Geom

  test "calculates area of a rectangle" do
    assert Geom.area({:rectangle, 12, 7}) == 84
  end

  # test "defaults length and width to 1" do
    # assert Geom.area({:rectangle, 7}) == 7
    # assert Geom.area({:rectangle}) == 1
  # end

  test "calculates area of a triangle" do
    assert Geom.area({:triangle, 3, 5}) == 7.5
  end

  test "calculates area of a circle" do
    assert Geom.area({:ellipse, 2, 4}) == 25.132741228718345
  end

  test "returns zero for unknown shapes" do
    assert Geom.area({:foo, 1, 2}) == 0
  end
end

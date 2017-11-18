defmodule PowersTest do
  use ExUnit.Case, async: true

  test "a number to the power of 0 equals 1" do
    assert Powers.raise(3, 0) == 1
  end

  test "a number to the power of 1 is itself" do
    assert Powers.raise(3, 1) == 3
  end

  test "raising to a positive exponent" do
    assert Powers.raise(3, 3) == 27
    assert Powers.raise(1.2, 3) == 1.728
  end

  test "raising to a negative exponent" do
    assert Powers.raise(2, -3) == 0.125
  end
end

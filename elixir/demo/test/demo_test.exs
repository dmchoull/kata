defmodule DemoTest do
  use ExUnit.Case
  doctest Demo

  test "returns 0 when the character is not present" do
    assert Demo.char_count('', ?e) == 0
    assert Demo.char_count('aiou', ?e) == 0
  end

  test "returns the number of occurrences of the character" do
    assert Demo.char_count('racecar', ?r) == 2
  end
end

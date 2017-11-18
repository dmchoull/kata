defmodule BowlingTest do
  use ExUnit.Case, async: true
  doctest Bowling

  test "scores a single frame" do
    assert Bowling.score([[2, 3]]) == 5
  end

  test "scores multiple frames" do
    assert Bowling.score([[2, 3], [4, 5]]) == 14
  end

  test "awards one-pin bonus for a spare" do
    assert Bowling.score([[7, 3], [4, 2]]) == 20
  end

  test "awards two-pin bonus for a strike" do
    assert Bowling.score([[10], [4, 2]]) == 22
  end

  test "awards two-pin bonus for a strike when there are consecutive strikes" do
    assert Bowling.score([[10], [10], [10], [4, 2]]) == 76
  end

  test "scores 3 rolls in the final frame" do
    assert Bowling.score([[10, 10, 5]]) == 25
  end
end

defmodule StatsTest do
  use ExUnit.Case, async: true
  
  test ".minimum returns the minimum element in the list" do
    assert Stats.minimum([4]) == 4
    assert Stats.minimum([4,3]) == 3
    assert Stats.minimum([4,3,2,1]) == 1
  end

  test ".maximum returns the maximum element in the list" do
    assert Stats.maximum([4]) == 4
    assert Stats.maximum([4,3]) == 4
    assert Stats.maximum([1,2,99,1]) == 99
  end

  test ".range returns the min a max values in the list" do
    assert Stats.range([1, 2, 99, -123, 3, 0]) == [99, -123]
  end

  test ".mean calcuates mean of a list of numbers" do
    assert Stats.mean([7, 2, 9]) == 6.0
  end

  test ".stdv calcuates std deviation of a list of numbers" do
    assert Stats.stdv([7, 2, 9]) == 3.60555127546398912486
  end
end

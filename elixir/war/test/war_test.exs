defmodule WarTest do
  use ExUnit.Case, async: true
  doctest War

  test "high card wins" do
    assert War.check_cards({:spades, 8}, {:spades, 7}) == {:round_won, 1}
    assert War.check_cards({:spades, 8}, {:spades, 9}) == {:round_won, 2}
  end

  test "starts war when cards are same value" do
    assert War.check_cards({:spades, 8}, {:hearts, 8}) == :war
  end

  test "checks the first card" do
    assert War.check_cards([{:spades, 8}, {:spades, 1}], [{:hearts, 7}, {:clubs, 10}]) == {:round_won, 1}
  end
end

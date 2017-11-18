defmodule DeckTest do
  use ExUnit.Case, async: true
  doctest Deck

  test "builds a deck with the given number of cards, defaulting to 52" do
    assert Deck.build(2) == [{:clubs, 14}, {:clubs, 2}]
    assert Enum.count(Deck.build) == 52
  end

  test "shuffles the deck" do
    deck = Deck.build(4)
    assert Deck.shuffle(deck, 1234)  == [clubs: 2, clubs: 4, clubs: 3, clubs: 14]
  end
end

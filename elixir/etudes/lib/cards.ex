defmodule Cards do
  @moduledoc false

  def make_deck do
    for suit <- ["Clubs", "Diamonds", "Hearts", "Spades"], rank <- (1..13),
    do:
      (case rank do
        1  -> {suit, "Ace"}
        11 -> {suit, "Jack"}
        12 -> {suit, "Queen"}
        13 -> {suit, "King"}
        _  -> {suit, rank}
      end)
  end
end

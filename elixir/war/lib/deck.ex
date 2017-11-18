defmodule Deck do
  @moduledoc false

  def build(size \\ 52) do
    deck = for suit <- [:clubs, :diamonds, :hearts, :spades], rank <- (1..13),
           do:
             (case rank do
               1 -> {suit, 14}
               _ -> {suit, rank}
             end)

    Enum.take(deck, size)
  end

  def shuffle(deck, seed \\ :erlang.now()) do
    :random.seed(seed)
    do_shuffle(deck, [])
  end
  
  defp do_shuffle([], acc) do
    acc
  end
  
  defp do_shuffle(deck, acc) do
    {leading, [h | t]} =
      Enum.split(deck, :random.uniform(Enum.count(deck)) - 1)
      do_shuffle(leading ++ t, [h | acc])
  end
end

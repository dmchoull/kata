defmodule DealerTest do
  use ExUnit.Case, async: true
  doctest Dealer

  setup do
    [player1, player2] = [Player.start, Player.start]

    {:ok, player1: player1, player2: player2}
  end

  test "shuffles the deck and gives each player half", context do
    dealer = Dealer.start(Deck.build(4), 1234)
    :ok = Dealer.deal_to(dealer, [context.player1, context.player2])

    assert Enum.count(Player.hand(context.player1)) == 2
    assert Enum.at(Player.hand(context.player1), 0) == {:clubs, 2}

    assert Enum.count(Player.hand(context.player2)) == 2
    assert Enum.at(Player.hand(context.player2), 0) == {:clubs, 3}
  end

  test "tells both players to play a card and gives cards to the winner", context do
    dealer = Dealer.start([{:hearts, 2}, {:clubs, 3}], 1234)
    :ok = Dealer.deal_to(dealer, [context.player1, context.player2])

    :ok = Dealer.play_round(dealer)

    assert Player.hand(context.player1) == [{:clubs, 3}, {:hearts, 2}]
    assert Player.hand(context.player2) == []
  end

  test "when cards are equal starts a war until one player wins", context do
    dealer = Dealer.start([{:hearts, 2}, {:clubs, 2}, {:diamonds, 2}, {:spades, 2}, {:clubs, 3}], 1042)
    :ok = Dealer.deal_to(dealer, [context.player1, context.player2])

    :ok = Dealer.play_round(dealer)

    assert Player.hand(context.player1) == []
    assert Player.hand(context.player2) == [{:clubs, 2}, {:diamonds, 2}, {:clubs, 3}]
  end
end

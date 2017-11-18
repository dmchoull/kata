defmodule PlayerTest do
  use ExUnit.Case, async: true
  doctest Player

  setup do
    player = Player.start
    :ok = Player.receive_cards(player, Deck.build(2))

    {:ok, player: player}
  end

  test "adds cards to current hand", context do
    Player.receive_cards(context.player, [{:hearts, 10}])
    assert Player.hand(context.player) == [{:clubs, 14}, {:clubs, 2}, {:hearts, 10}]
  end

  test "plays a card twice", context do
    assert Player.play_cards(context.player) == [{:clubs, 14}]
    assert Player.play_cards(context.player, 1) == [{:clubs, 2}]
  end

  test "can play multiple cards at once", context do
    assert Player.play_cards(context.player, 2) == [{:clubs, 14}, {:clubs, 2}]
  end

  test "plays remaining cards when asked to play more than currently in hand", context do
    assert Player.play_cards(context.player, 3) == [{:clubs, 14}, {:clubs, 2}]
  end

  test "returns cards currently in hand", context do
    assert Player.hand(context.player) == [{:clubs, 14}, {:clubs, 2}]
  end
end

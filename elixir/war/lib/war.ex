defmodule War do
  def check_cards([p1_top_card | _p1_cards], [p2_top_card | _p2_cards])  do
    check_cards(p1_top_card, p2_top_card)
  end

  def check_cards([], []), do: {:game_over, :draw}
  def check_cards([_ | _], []), do: {:game_over, 1}
  def check_cards([], [_ | _]), do: {:game_over, 2}

  def check_cards({_, rank1}, {_, rank2}) when rank1 > rank2, do: {:round_won, 1}

  def check_cards({_, rank1}, {_, rank2}) when rank1 < rank2, do: {:round_won, 2}

  def check_cards({_, rank1}, {_, rank2}) when rank1 == rank2, do: :war

  def play_game(deck_size \\ 52) do
    players = [player1, player2] = [Player.start, Player.start]

    dealer = Dealer.start(Deck.build(deck_size))

    Dealer.deal_to(dealer, players)

    do_round(dealer, players)
  end

  defp do_round(dealer, players = [player1, player2]) do
    Dealer.play_round(dealer)

    IO.puts "\nplayer 1 has #{Enum.count(Player.hand(player1))} cards, player 2 has #{Enum.count(Player.hand(player2))} cards\n"

    :timer.sleep(50)
    do_round(dealer, players)
  end
end

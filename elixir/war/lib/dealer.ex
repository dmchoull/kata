defmodule Dealer do
  @moduledoc false

  # Client Interface

  def start(deck, seed \\ :erlang.now()) do
    spawn_link(__MODULE__, :deal, [%{deck: Deck.shuffle(deck, seed)}])
  end

  def deal_to(dealer, players) do
    send(dealer, {:deal_to, self, players})

    receive do
      :dealt_cards -> :ok
     after
      1000 -> {:error, :no_response}
    end
  end

  def play_round(dealer) do
    send(dealer, {:play_round, self})

    receive do
      :round_complete -> :ok
     after
      1000 -> {:error, :no_response}
    end
  end

  # Server Interface

  def deal(state = %{deck: deck}) do
    receive do
      {:deal_to, pid, players = [player1, player2]} ->
        with {first_half, second_half} = Enum.split(state.deck, round(Enum.count(state.deck) / 2)) do
          :ok = Player.receive_cards(player1, first_half)
          :ok = Player.receive_cards(player2, second_half)

          send(pid, :dealt_cards)

          deal(%{deck: state.deck, players: players})
        end

      {:play_round, pid} ->
        with %{players: [player1, player2]} = state do
          p1_cards = Player.play_cards(player1, 1)
          p2_cards = Player.play_cards(player2, 1)

          IO.puts "Player 1 played: #{inspect(p1_cards)}"
          IO.puts "Player 2 played: #{inspect(p2_cards)}"

          case War.check_cards(p1_cards, p2_cards) do
            {:round_won, 1} ->
              IO.puts "round_won 1"
              :ok = Player.receive_cards(player1, p1_cards ++ p2_cards)
              send(pid, :round_complete)
            {:round_won, 2} ->
              IO.puts "round_won 2"
              :ok = Player.receive_cards(player2, p1_cards ++ p2_cards)
              send(pid, :round_complete)
            :war ->
              IO.puts "wars starts"
              do_war([player1, player2], p1_cards ++ p2_cards, pid)
          end

          deal(state)
        end
    end
  end

  defp do_war(players = [player1, player2], cards, pid) do
    p1_cards = Player.play_cards(player1, 3)
    p2_cards = Player.play_cards(player2, 3)

    IO.puts "Player 1 played: #{inspect(p1_cards)}"
    IO.puts "Player 2 played: #{inspect(p2_cards)}"

    case War.check_cards(p1_cards, p2_cards) do
      {:round_won, 1} ->
        IO.puts "war won by 1"
        :ok = Player.receive_cards(player1, p1_cards ++ p2_cards)
        send(pid, :round_complete)
      {:round_won, 2} ->
        IO.puts "war won by 2"
        :ok = Player.receive_cards(player2, p1_cards ++ p2_cards)
        send(pid, :round_complete)
      :war ->
        IO.puts "war continues"
        do_war(players, cards ++ p1_cards ++ p2_cards, pid)
    end
  end
end

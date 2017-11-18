defmodule Player do
  @moduledoc false

  # Client Interface

  def start do
    spawn_link(__MODULE__, :play, [[]])
  end

  def receive_cards(player, cards) do
    send(player, {:receive_cards, self, cards})

    receive do
      :received_cards -> :ok
    after
      1000 -> {:error, :no_response}
    end
  end

  def play_cards(player, num_cards \\ 1) do
    send(player, {:play_cards, self, num_cards})

    receive do
       {:played_cards, cards} -> cards
    after
      1000 -> {:error, :no_response}
    end
  end

  def hand(player) do
    send(player, {:hand, self})

    receive do
       {:hand, hand} -> hand
    after
      1000 -> {:error, :no_response}
    end
  end

  # Server Interface

  def play(hand) do
    receive do
      {:receive_cards, pid, cards} ->
        send(pid, :received_cards)
        play(hand ++ cards)
      {:play_cards, pid, num_cards} ->
        with remaining = play_cards(pid, hand, num_cards), do: play(remaining)
      {:hand, pid} ->
        send(pid, {:hand, hand})
        play(hand)
    end
  end

  defp play_cards(pid, hand, num_cards) do
    {cards_to_play, remaining} = Enum.split(hand, num_cards)

    send(pid, {:played_cards, cards_to_play})
    remaining
  end
end

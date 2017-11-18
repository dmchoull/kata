defmodule Rover do
  @moduledoc """
  A Rover that can move around a Martian plateau
  """

  defstruct position: {}, direction: nil

  @spec at({non_neg_integer, non_neg_integer}, atom) :: %Rover{}

  def at({x, y}, direction), do: %Rover{position: {x, y}, direction: direction}

  @spec status(%Rover{}) :: String.t

  def status(%Rover{position: {x, y}, direction: d}), do: "#{x} #{y} #{d}"

  @spec turn_left(%Rover{}) :: %Rover{}

  def turn_left(%Rover{position: p, direction: :N}), do: Rover.at(p, :W)
  def turn_left(%Rover{position: p, direction: :E}), do: Rover.at(p, :N)
  def turn_left(%Rover{position: p, direction: :S}), do: Rover.at(p, :E)
  def turn_left(%Rover{position: p, direction: :W}), do: Rover.at(p, :S)

  @spec turn_right(%Rover{}) :: %Rover{}

  def turn_right(%Rover{position: p, direction: :N}), do: Rover.at(p, :E)
  def turn_right(%Rover{position: p, direction: :E}), do: Rover.at(p, :S)
  def turn_right(%Rover{position: p, direction: :S}), do: Rover.at(p, :W)
  def turn_right(%Rover{position: p, direction: :W}), do: Rover.at(p, :N)

  @spec move(%Rover{}) :: %Rover{}

  def move(%Rover{position: {x, y}, direction: :N}), do: Rover.at({x, y + 1}, :N)
  def move(%Rover{position: {x, y}, direction: :E}), do: Rover.at({x + 1, y}, :E)
  def move(%Rover{position: {x, y}, direction: :S}), do: Rover.at({x, y - 1}, :S)
  def move(%Rover{position: {x, y}, direction: :W}), do: Rover.at({x - 1, y}, :W)
end

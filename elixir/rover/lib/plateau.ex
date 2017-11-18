defmodule Plateau do
  @moduledoc """
  A flat Martian plateau for rovers to rove around on.
  """

  defstruct length: 0, width: 0, rovers: []

  def add_rover(plateau, rover) do
    update_in(plateau.rovers, &List.insert_at(&1, -1, rover))
  end
end

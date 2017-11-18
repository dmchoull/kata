defmodule NonFP do
  @moduledoc false
  
  @spec generate_pockets(list, float) :: list

  def generate_pockets(teeth, p_good) do
    generate_pockets(teeth, p_good, [])
  end

  defp generate_pockets([], _, pockets), do: Enum.reverse(pockets)

  defp generate_pockets([?F | rest], p_good, pockets) do
    generate_pockets(rest, p_good, [[0] | pockets])
  end

  defp generate_pockets([?T | rest], p_good, pockets) do
    generate_pockets(rest, p_good, [generate_tooth(p_good) | pockets])
  end

  defp generate_tooth(p_good) do
    if :random.uniform < p_good do
      generate_tooth(2, 6, [])
    else
      generate_tooth(3, 6, [])
    end
  end

  defp generate_tooth(base_depth, num_pockets, pockets) when num_pockets == 0, do: pockets

  defp generate_tooth(base_depth, num_pockets, pockets) do
    generate_tooth(base_depth, num_pockets - 1, [base_depth + :random.uniform(3) - 2 | pockets])
  end
end

defmodule Example do
  @moduledoc false
  
  def sum(list) do
    do_sum(list, 0)
  end

  defp do_sum([], sum), do: sum

  defp do_sum([head | tail], sum) do
    do_sum(tail, sum + head)
  end
end

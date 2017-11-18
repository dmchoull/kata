defmodule Teeth do
  @moduledoc false
  
  def pocket_depths do
    [[0], [2,2,1,2,2,1], [3,1,2,3,2,3],
    [3,1,3,2,1,2], [3,2,3,2,2,1], [2,3,1,2,1,1],
    [3,1,3,2,3,2], [3,3,2,1,3,1], [4,3,3,2,3,3],
    [3,1,1,3,2,2], [4,3,4,3,2,3], [2,3,1,3,2,2],
    [1,2,1,1,3,2], [1,2,2,3,2,3], [1,3,2,1,3,3], [0],
    [3,2,3,1,1,2], [2,2,1,1,3,2], [2,1,1,1,1,2],
    [3,3,2,1,1,3], [3,1,3,2,3,2], [3,3,1,2,3,3],
    [1,2,2,3,3,3], [2,2,3,2,3,3], [2,2,2,4,3,4],
    [3,4,3,3,3,4], [1,1,2,3,1,2], [2,2,3,2,1,3],
    [3,4,2,4,4,3], [3,3,2,1,2,3], [2,2,2,2,3,3],
    [3,2,3,2,3,2]]
  end

  def alert(depths) do
    find_problem_teeth(depths, 1, [])
  end

  defp find_problem_teeth([current_tooth | rest], tooth_num, problem_teeth) do
    if Stats.maximum(current_tooth) >= 4  do
      find_problem_teeth(rest, tooth_num + 1, [tooth_num | problem_teeth])
    else
      find_problem_teeth(rest, tooth_num + 1, problem_teeth)
    end
  end

  defp find_problem_teeth([], _, problem_teeth), do: Enum.reverse(problem_teeth)
end

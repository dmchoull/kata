defmodule College do
  @moduledoc false
  
  def make_room_list(file_path) do
    {:ok, file} = File.open(file_path, [:read, :utf8])
    make_room_list(file, %{})
  end

  defp make_room_list(file, room_list) do
    case IO.read(file, :line) do
      :eof ->
        File.close(file)
        room_list
      line ->
        make_room_list(file, process_line(line, room_list))
    end
  end

  defp process_line(line, room_list) do
    [_, course, room] = line
                        |> String.split(",")
                        |> Enum.map(&String.strip/1)

    updated_courses = add_course(room_list[room], course)
    Map.put(room_list, room, updated_courses)
  end

  defp add_course(nil, course), do: [course]
  defp add_course(courses, course), do: [course | courses]
end

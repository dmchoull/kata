defmodule CollegeTest do
  use ExUnit.Case, async: true

  test ".make_room_list returns rooms" do
    path = "/Users/dmchoull/code/elixir/exercises/courses.csv"

    assert College.make_room_list(path)["RF141"] == ["BUS 065", "PHIL 065", "HIST 040", "ART 090", "ENGL 033"]
    assert is_nil College.make_room_list(path)["FAKE1"]
  end
end

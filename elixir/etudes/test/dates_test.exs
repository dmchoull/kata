defmodule DatesTest do
  use ExUnit.Case, async: true
  doctest Dates

  test ".date_parts splits the parts of a date string" do
    assert Dates.date_parts("2016-05-06") == [2016, 5, 6]
  end
end

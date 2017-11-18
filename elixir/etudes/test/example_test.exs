defmodule ExampleTest do
  use ExUnit.Case, async: true

  test "sum" do
    assert Example.sum([1, 2, 3]) == 6
  end
end

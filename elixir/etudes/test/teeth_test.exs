defmodule TeethTest do
  use ExUnit.Case, async: true

  test "works" do
    assert Teeth.alert(Teeth.pocket_depths()) == [9,11,25,26,29]
  end
end

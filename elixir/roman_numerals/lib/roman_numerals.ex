defmodule RomanNumerals do
  @moduledoc false

  def to_roman(1), do: "I"
  def to_roman(5), do: "V"
  def to_roman(10), do: "X"
  def to_roman(50), do: "L"
  def to_roman(100), do: "C"
  def to_roman(500), do: "D"
  def to_roman(1000), do: "M"

  def to_roman(n) when n > 0 and n < 4, do: String.duplicate("I", n)
  def to_roman(n) when n == 4, do: "IV"
  def to_roman(n) when n > 5 and n < 9, do: "V" <> to_roman(n - 5)

  def to_roman(n) when n == 9, do: "IX"
  def to_roman(n) when n > 10 and n < 40, do: "X" <> to_roman(n - 10)

  def to_roman(n) when n == 40, do: "XL"
  def to_roman(n) when n > 40 and n < 50, do: "XL" <> to_roman(n - 40)
  def to_roman(n) when n > 50 and n < 90, do: "L" <> to_roman(n - 50)

  def to_roman(n) when n == 90, do: "XC"
  def to_roman(n) when n > 90 and n < 100, do: "XC" <> to_roman(n - 90)
  def to_roman(n) when n > 100 and n < 400, do: "C" <> to_roman(n - 100)

  def to_roman(n) when n == 400, do: "CD"
  def to_roman(n) when n > 400 and n < 500, do: "CD" <> to_roman(n - 400)
  def to_roman(n) when n > 500 and n < 900, do: "D" <> to_roman(n - 500)

  def to_roman(n) when n == 900, do: "CM"
  def to_roman(n) when n > 900 and n < 1000, do: "CM" <> to_roman(n - 900)
  def to_roman(n) when n > 1000, do: "M" <> to_roman(n - 1000)
end

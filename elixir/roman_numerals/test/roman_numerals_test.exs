defmodule RomanNumeralsTest do
  use ExUnit.Case, async: true
  doctest RomanNumerals

  test "simple conversions" do
    assert RomanNumerals.to_roman(1) == "I"
    assert RomanNumerals.to_roman(5) == "V"
    assert RomanNumerals.to_roman(10) == "X"
    assert RomanNumerals.to_roman(50) == "L"
    assert RomanNumerals.to_roman(100) == "C"
    assert RomanNumerals.to_roman(500) == "D"
    assert RomanNumerals.to_roman(1000) == "M"
  end

  test "adding I" do
    assert RomanNumerals.to_roman(3) == "III"
    assert RomanNumerals.to_roman(6) == "VI"
    assert RomanNumerals.to_roman(8) == "VIII"
    assert RomanNumerals.to_roman(13) == "XIII"
  end

  test "subtracting I" do
    assert RomanNumerals.to_roman(4) == "IV"
    assert RomanNumerals.to_roman(9) == "IX"
  end

  test "addition and subtraction" do
    assert RomanNumerals.to_roman(14) == "XIV"
    assert RomanNumerals.to_roman(19) == "XIX"
  end

  test "using X" do
    assert RomanNumerals.to_roman(15) == "XV"
    assert RomanNumerals.to_roman(18) == "XVIII"
    assert RomanNumerals.to_roman(30) == "XXX"
    assert RomanNumerals.to_roman(39) == "XXXIX"
  end

  test "using L" do
    assert RomanNumerals.to_roman(40) == "XL"
    assert RomanNumerals.to_roman(49) == "XLIX"
    assert RomanNumerals.to_roman(54) == "LIV"
    assert RomanNumerals.to_roman(89) == "LXXXIX"
  end

  test "using C" do
    assert RomanNumerals.to_roman(90) == "XC"
    assert RomanNumerals.to_roman(99) == "XCIX"
    assert RomanNumerals.to_roman(149) == "CXLIX"
  end

  test "using D" do
    assert RomanNumerals.to_roman(400) == "CD"
    assert RomanNumerals.to_roman(499) == "CDXCIX"
    assert RomanNumerals.to_roman(899) == "DCCCXCIX"
  end

  test "using M" do
    assert RomanNumerals.to_roman(900) == "CM"
    assert RomanNumerals.to_roman(999) == "CMXCIX"
    assert RomanNumerals.to_roman(1999) == "MCMXCIX"
    assert RomanNumerals.to_roman(4999) == "MMMMCMXCIX"
  end
end

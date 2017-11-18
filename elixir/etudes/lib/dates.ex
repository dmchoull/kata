defmodule Dates do
  @moduledoc false
  
  def date_parts(date_string) do
    date_string
    |> String.split(~r/-/)
    |> Enum.map(fn s -> s |> Integer.parse |> elem(0) end)
  end

  @doc """
  Takes a date in the format YYYY-MM-DD and returns the julian date (day of year)

  ## Examples
  iex> Dates.julian("2013-12-31")
  365
  iex> Dates.julian("2012-12-31")
  366
  iex> Dates.julian("2012-02-05")
  36
  iex> Dates.julian("2013-02-05")
  36
  iex> Dates.julian("1900-03-01")
  60
  iex> Dates.julian("2000-03-01")
  61
  iex> Dates.julian("2013-01-01")
  1
  """

  @spec julian(String.t) :: integer

  def julian(date_string) do
    with [year, month, day_in_month] <- date_parts(date_string) do
      days_per_month = [31, days_in_feb(year), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
      days_up_to_month(days_per_month, month) + day_in_month
    end
  end

  defp days_in_feb(year) do
    if is_leap_year(year), do: 29, else: 28
  end

  defp is_leap_year(year) do
    (rem(year, 4) == 0 and rem(year, 100) != 0) or (rem(year, 400) == 0)
  end

  defp days_up_to_month(_days_per_month, month) when month == 1 do
    0
  end

  defp days_up_to_month(days_per_month, month) when month > 1 do
    days_per_month
    |> Enum.split(month - 1)
    |> elem(0)
    |> Enum.sum
  end
end

# chris@lighthouselabs.ca

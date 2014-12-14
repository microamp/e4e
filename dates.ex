defmodule Dates do
  @moduledoc """
  Étude 5-3: Using String.split
  """
  @vsn 0.1

  @doc """
  Write a module named Dates that contains a function date_parts/1, which takes a string in ISO date format ("yyyy-mm-dd") and returns a list of integers in the form [yyyy, mm, dd]. This function does not need to do any error checking.
  """
  @spec date_parts(String.t) :: [number]

  def date_parts(s) do
    # Enum.map(String.split(s, "-"), String.to_integer)
    # (UndefinedFunctionError) undefined function: String.to_integer/0
    # ^ odd???

    Enum.map(String.split(s, "-"), fn(x) -> String.to_integer(x) end)
  end

  @doc """
  Given a string in ISO format ("yyyy-mm-dd"), it returns the Julian date: the day of the year.
  """
  @spec julian(String.t) :: number

  def julian(s) do
    [year, month, day] = date_parts(s)

    days_in_feb = if is_leap_year(year), do: 29, else: 28
    days_per_month = [31, days_in_feb, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    day + month_total(month, days_per_month, 0)
  end

  @doc """
  """
  @spec month_total(number, [number], number) :: number

  def month_total(1, _, accumulated) do
    accumulated
  end

  def month_total(_, [], accumulated) do
    accumulated
  end

  def month_total(months_left, [days | more_days], accumulated) do
    month_total(months_left - 1, more_days, accumulated + days)
  end

  def is_leap_year(year) do
    (rem(year, 4) == 0 and rem(year, 100) != 0) or (rem(year, 400) == 0)
  end
end

# tests
[2014, 6, 15] = Dates.date_parts("2014-06-15")
[2014, 1, 2] = Dates.date_parts("2014-01-02")

365 = Dates.julian("2013-12-31")
366 = Dates.julian("2012-12-31")
36 = Dates.julian("2012-02-05")
36 = Dates.julian("2013-02-05")
60 = Dates.julian("1900-03-01")
61 = Dates.julian("2000-03-01")
1 = Dates.julian("2013-01-01")

IO.puts("tests passed!")

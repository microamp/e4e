defmodule Stats do
  @moduledoc """
  Étude 6-1: Recursive Iteration through a List
  Étude 8-3: Using lists:foldl/3
  """
  @vsn 0.1

  @doc """
  """
  @spec minimum([number]) :: number

  def minimum(nums) do
    [first | rest] = nums
    minimum(rest, first)
  end

  @doc """
  """
  @spec minimum([number], number) :: number

  def minimum([], min) do
    min
  end

  def minimum([first | rest], min) do
    minimum(rest, (if first < min, do: first, else: min))
  end

  @doc """
  """
  @spec maximum([number]) :: number

  def maximum(nums) do
    [first | rest] = nums
    maximum(rest, first)
  end

  @doc """
  """
  @spec maximum([number], number) :: number

  def maximum([], max) do
    max
  end

  def maximum([first | rest], max) do
    maximum(rest, (if first > max, do: first, else: max))
  end

  @doc """
  """
  @spec range([number]) :: [number]

  def range(nums) do
    [minimum(nums), maximum(nums)]
  end

  def sum([]) do
    0
  end

  def sum([num | nums]) do
    List.foldl(nums, num, &(&1 + &2))
  end

  @doc """
  The formula for the mean is simple; just add up all the numbers and divide by the number of items in the list (which you may find by using the Enum.count/1 function).Use List.foldl/3 to calculate the sum of the items in the list.
  """
  @spec mean(list) :: number

  def mean(nums) do
    sum(nums) / Enum.count(nums)
  end

  @doc """
  The following is the algorithm for calculating the standard deviation. Presume that n is the number of items in the list.
    * Add up all the numbers in the list (call this the sum).
    * Add the squares of the numbers in the list (call this the sum of squares).
    * Multiply n times the sum of squares.
    * Multiply the sum times itself.
    * Subtract the result of step 4 from the result of step 3.
    * Divide the result of step 5 by n * (n - 1).
    * Take the square root of that result.
  """
  @spec stdv(list) :: number

  def stdv(nums) do
    sum = sum(nums)
    sum_of_squares = sum(Enum.map(nums, &(&1 * &1)))
    count = Enum.count(nums)

    :math.sqrt (sum_of_squares * Enum.count(nums) - (sum * sum)) / (count * (count - 1))
  end
end

# tests
nums = [4, 1, 7, -17, 8, 2, 5]

-17 = Stats.minimum(nums)
46 = Stats.minimum([52, 46])
8 = Stats.maximum(nums)
[-17, 8] = Stats.range(nums)

6.0 = Stats.mean([7, 2, 9])
3.60555127546398912486 = Stats.stdv([7, 2, 9])

IO.puts("tests passed!")

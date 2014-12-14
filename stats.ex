defmodule Stats do
  @moduledoc """
  Étude 6-1: Recursive Iteration through a List
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
end

# tests
nums = [4, 1, 7, -17, 8, 2, 5]

-17 = Stats.minimum(nums)
46 = Stats.minimum([52, 46])
8 = Stats.maximum(nums)
[-17, 8] = Stats.range(nums)

IO.puts("tests passed!")

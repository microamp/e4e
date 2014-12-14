defmodule GeomChap2 do
  @moduledoc """
  Étude 2-1: Writing a Function
  """
  @vsn 0.1

  @doc """
  Write a module with a function that takes the length and width of a rectangle and returns (yields) its area. Name the module Geom, and name the function area. Save the module in a file named geom.ex. The function has arity 2, because it needs two pieces of information to make the calculation. In Elixir-speak: write function area/2.
  """
  @spec area(number(), number()) :: number()

  def area(length \\ 1, width \\ 1) do
    length * width
  end
end

defmodule Test do
  @spec sum(number(), number(), number()) :: number()

  def sum( a \\ 3, b, c \\ 7) do
    a + b + c
  end
end

# pattern-matching tests
12 = GeomChap2.area(3, 4)
84 = GeomChap2.area(12, 7)

11 + 22 + 33 = Test.sum(11, 22, 33)
11 + 22 + 7 = Test.sum(11, 22)
3 + 11 + 7 = Test.sum(11)

IO.puts("tests passed!")

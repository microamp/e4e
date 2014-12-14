defmodule GeomChap4 do
  @moduledoc """
  Étude 4-1: Using case
  """
  @vsn 0.1

  @doc """
  Change the area/3 function that you wrote in Étude 3-2 so that it uses a case instead of pattern matching. Use a guard on the function definition to ensure that the numeric arguments are both greater than zero.
  """
  @spec area({atom(), number(), number()}) :: number()

  def area({shape, a, b}) when a > 0 and b > 0 do
    case shape do
      :rectangle -> a * b
      :triangle -> a * b / 2
      :ellipse -> :math.pi * a * b
      _ -> 0
    end
  end

  def area({_, _, _}) do
    0
  end
end

# pattern-matching tests
21 = GeomChap4.area({:rectangle, 7, 3})
10.5 = GeomChap4.area({:triangle, 7, 3})
65.97344572538566 = GeomChap4.area({:ellipse, 7, 3})
0 = GeomChap4.area({:pentagon, 7, 3})
0 = GeomChap4.area({:rectangle, -1, -1})

IO.puts("tests passed!")

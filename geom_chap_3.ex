defmodule GeomChap3 do
  @moduledoc """
  Étude 3-1: Pattern Matching
  """
  @vsn 0.1

  @doc """
  Use atoms and pattern matching to make your area function calculate the area of a rectangle, triangle, or ellipse. If your parameters are shape, a and b, the area for the atom :rectangle is a * b, where a and b represent the length and width. For a :triangle atom, the area is a * b / 2.0, with a and b representing the base and height of the triangle. For an :ellipse atom, the area is :math.pi() * a * b, where a and b represent the major and minor radiuses.
  """
  @spec area(atom(), number(), number()) :: number()

  def area(:rectangle, a, b) when a > 0 and b > 0 do
    a * b
  end

  def area(:triangle, a, b) when a > 0 and b > 0 do
    a * b / 2
  end

  def area(:ellipse, a, b) when a > 0 and b > 0 do
    :math.pi * a * b
  end

  def area(_, _, _) do
    0
  end
end

defmodule GeomChap3Tuple do
  @doc """
  """
  @spec area({atom(), number(), number()}) :: number()

  def area({:rectangle, a, b}) when a > 0 and b > 0 do
    a * b
  end

  def area({:triangle, a, b}) when a > 0 and b > 0 do
    a * b / 2
  end

  def area({:ellipse, a, b}) when a > 0 and b > 0 do
    :math.pi * a * b
  end

  def area({_, _, _}) do
    0
  end
end

# pattern-matching tests
12 = GeomChap3.area(:rectangle, 3, 4)
0 = GeomChap3.area(:pentagon, 3, 4)
0 = GeomChap3.area(:ellipse, -1, 5)
0 = GeomChap3.area(:triangle, 5, -1)

21 = GeomChap3Tuple.area({:rectangle, 7, 3})
10.5 = GeomChap3Tuple.area({:triangle, 7, 3})
65.97344572538566 = GeomChap3Tuple.area({:ellipse, 7, 3})
0 = GeomChap3Tuple.area({:pentagon, 7, 3})

IO.puts("tests passed!")

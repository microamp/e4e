defmodule Calculus do
  @moduledoc """
  Étude 8-1: Simple Higher Order Functions
  """
  @vsn 0.1

  @doc """
  You can calculate the rate of change of a function by calculating: (f(x + delta) - f(x)) / delta, where delta is the interval between measurements. As delta approaches zero, you get closer and closer to the true value of the derivative.
  """

  def derivative(f, x) do
    delta = 1.0e-10
    (f.(x + delta) - f.(x)) / delta
  end
end

# tests
f1 = fn(x) -> x * x end
49 = f1.(7)

6.000000496442226 = Calculus.derivative(f1, 3)
32.00000264769187197089 = Calculus.derivative(fn(x) -> 3 * x * x + 2 * x + 1 end, 5)
1.0 = Calculus.derivative(&:math.sin/1, 0)

IO.puts("tests passed!")

defmodule Dijkstra do
  @moduledoc """
  Étude 4-2: Recursion
  """
  @vsn 0.1

  @doc """
  To find the GCD of integers M and N:
  * If M and N are equal, the result is M.
  * If M is greater than N, the result is the GCD of M - N and N
  * Otherwise M must be less than N, and the result is the GCD of M and N - M.
  """
  @spec gcd(number(), number()) :: number()

  # If M and N are equal, the result is M.
  def gcd(m, n) when m == n do
    m
  end

  # If M is greater than N, the result is the GCD of M - N and N
  def gcd(m, n) when m > n do
    gcd(m - n, n)
  end

  # Otherwise M must be less than N, and the result is the GCD of M and N - M
  def gcd(m, n) do
    gcd(m, n - m)
  end

  @spec gcd_with_cond(number(), number()) :: number()

  def gcd_with_cond(m, n) do
    cond do
      m == n -> m
      m > n -> gcd_with_cond(m - n, n)
      true -> gcd_with_cond(m, n - m)
    end
  end
end

# pattern-matching tests
2 = Dijkstra.gcd(2, 8)
7 = Dijkstra.gcd(14, 21)
1 = Dijkstra.gcd(125, 46)
12 = Dijkstra.gcd(120, 36)

2 = Dijkstra.gcd_with_cond(2, 8)
7 = Dijkstra.gcd_with_cond(14, 21)
1 = Dijkstra.gcd_with_cond(125, 46)
12 = Dijkstra.gcd_with_cond(120, 36)

IO.puts("tests passed!")

defmodule Powers do
  @moduledoc """
  Étude 4-3: Non-Tail Recursive Functions
  """
  @vsn 0.1

  # The Elixir kernel already has a raise/2 function, so your function will cause a conflict unless you add this after the defmodule
  import Kernel, except: [raise: 2]

  @doc """
  Create a module named Powers (no relation to Francis Gary Powers), and write a function named raise/2 which takes parameters x and n and returns the value of x^n.

  Here’s the information you need to know to write the function:

      Any number to the power 0 equals 1.
      Any number to the power 1 is that number itself — that stops the recursion.
      When n is positive, x^n is equal to x times x^(n - 1) —  there’s your recursion.
      When n is negative, x^n is equal to 1.0 / x^-n

  Note that this algorithm is not tail recursive.
  """
  @spec raise(number(), number()) :: number()

  def raise(x, n) when n == 0 do
    1
  end

  def raise(x, n) when n == 1 do
    x
  end

  def raise(x, n) when n > 0 do
    x * raise(x, n - 1)
  end

  def raise(x, n) do
    1.0 / raise(x, -n)
  end

  @spec raise_with_cond(number(), number()) :: number()

  def raise_with_cond(x, n) do
    cond do
      n == 0 -> 1
      n == 1 -> x
      n > 0 -> x * raise(x, n - 1)
      true -> 1.0 / raise(x, -n)
    end
  end
end

defmodule PowersTCO do
  @moduledoc """
  Étude 4-4: Tail Recursion with an Accumulator
  Étude 4-5: Recursion with a Helper Function
  """
  @vsn 0.1
  # The Elixir kernel already has a raise/2 and raise/3 functions, so your function will cause a conflict unless you add this after the defmodule
  import Kernel, except: [raise: 2, raise: 3]

  @doc """
  Practice the "accumulator trick." Rewrite the raise/2 function for n greater than zero so that it calls a helper function raise/3 This new function has x, n, and an accumulator as its parameters.

  * Your raise/2 function will return 1 when n is equal to 0, and will return 1.0 / raise(x, -n) when n is less than zero.
  * When n is greater than zero, raise/2 will call raise/3 with arguments x, n, and 1 as the accumulator.
  * The raise/3 function will return the accumulator when n equals 0 (this will stop the recursion).
  * Otherwise, recursively call raise/3 with x, n - 1, and x times the accumulator as its arguments.

  The raise/3 function is tail recursive.
  """
  @spec raise(number(), number()) :: number()

  def raise(x, n) do
    cond do
      n == 0 -> 1
      n < 0 -> 1.0 / raise(x, -n)
      true -> raise(x, n, 1)
    end
  end

  def raise(x, n, acc) do
    cond do
      n == 0 -> acc
      true -> raise(x, n - 1, acc * x)
    end
  end

  @doc """
In this exercise, you will add a function nth_root/2 to the Powers module. This new function finds the nth root of a number, where n is an integer. For example, nth_root(36, 2) will calculate the square root of 36, and nth_root(1.728, 3) will return the cube root of 1.728.

The algorithm used here is the Newton-Raphson method for calculating roots. (See http://en.wikipedia.org/wiki/Newton%27s_method for details).

You will need a helper function nth_root/3, whose parameters are x, n, and an approximation to the result, which we will call a. nth_root/3 works as follows:

    * Calculate f as (a^n - x)
    * Calculate f_prime as n * a^(n - 1)
    * Calculate your next approximation (call it next) as a - f / f_prime
    * Calculate the change in value (call it change) as the absolute value of next - a
    * If the change is less than some limit (say, 1.0e-8), stop the recursion and return next; that’s as close to the root as you are going to get.
    Otherwise, call the nth_root/3 function again with x, n, and next as its arguments.

For your first approximation, use x / 2.0. Thus, your nth_root/2 function will simply be this:

nth_root(x, n) → nth_root(x, n, x / 2.0)

Use IO.puts to show each new approximation as you calculate it. If your argument name is estimate, you would do something like this:
  """
  @spec nth_root(number(), number()) :: number()

  def nth_root(x, n) do
    nth_root(x, n, x / 2.0)
  end

  @spec nth_root(number(), number(), number()) :: number()

  def nth_root(x, n, a) do
    IO.puts("Current guess is #{a}")

    f = raise(a, n) - x
    f_prime = n * raise(a, n - 1)
    next = a - (f / f_prime)
    change = Kernel.abs(next - a)

    if change < 0.000000009 do
      Float.round(next, 1)
    else
      nth_root(x, n, next)
    end
  end
end

# pattern-matching tests
5 = Powers.raise(5, 1)
8 = Powers.raise(2, 3)
1.728 = Powers.raise(1.2, 3)
1 = Powers.raise(2, 0)
0.125 = Powers.raise(2, -3)

5 = Powers.raise_with_cond(5, 1)
8 = Powers.raise_with_cond(2, 3)
1.728 = Powers.raise_with_cond(1.2, 3)
1 = Powers.raise_with_cond(2, 0)
0.125 = Powers.raise_with_cond(2, -3)

5 = PowersTCO.raise(5, 1)
8 = PowersTCO.raise(2, 3)
1.728 = PowersTCO.raise(1.2, 3)
1 = PowersTCO.raise(2, 0)
0.125 = PowersTCO.raise(2, -3)

3.0 = PowersTCO.nth_root(27, 3)

IO.puts("tests passed!")

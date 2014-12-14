defmodule AskArea do
  @moduledoc """
  Étude 5-1: Validating Input
  Étude 5-2: Better Validation with Regular Expressions
  """
  @vsn 0.1

  def area() do
    in_shape = IO.gets("R)ectangle, T)riangle, or E)llipse: ")
    shape = in_shape |> String.first |> String.upcase |> char_to_shape

    if shape == :unknown do
      IO.puts("Invalid shape #{in_shape}")
    else
      {name_a, name_b} =
      case shape do
        :rectangle -> {"width", "height"}
        :triangle -> {"base", "height"}
        :ellipse -> {"major radius", "minor radius"}
      end

      in_a = IO.gets("Enter #{name_a} > ")
      in_b = IO.gets("Enter #{name_b} > ")
      {num_a, num_b} = get_dimension(in_a, in_b)

      cond do
        num_a == :error -> IO.puts("Not a number #{in_a}")
        num_b == :error -> IO.puts("Not a number #{in_b}")
        true -> IO.puts(calculate(shape, num_a, num_b))
      end
    end
  end

  @doc """
  """
  @spec char_to_shape(char()) :: atom()

  def char_to_shape(c) do
    case c do
      "R" -> :rectangle
      "T" -> :triangle
      "E" -> :ellipse
      _ -> :unknown
    end
  end

  @doc """
  """
  @spec get_number(String.t()) :: number()

  def get_number(s) do
    # regular expression to do validation
    if Regex.match?(~r/^[0-9]+(\.?[0-9]+)$/, s) do
      s |> String.strip |> String.to_float
    else
      :error
    end
  end

  @doc """
  """
  @spec get_dimension(String.t(), String.t()) :: number()

  def get_dimension(s_a, s_b) do
    {get_number(s_a), get_number(s_b)}
  end

  @doc """
  """
  @spec calculate(atom(), number(), number()) :: number()

  def calculate(shape, num_a, num_b) do
    GeomChap4.area({shape, num_a, num_b})
  end
end

AskArea.area()

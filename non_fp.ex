defmodule NonFP do
  @moduledoc """
  Étude 6-4: Random Numbers; Generating Lists of Lists
  """
  @vsn 0.1

  @doc """
  This function has a character list consisting of T and F for its first argument. A T in the list indicates that the tooth is present, and a F indicates a missing tooth. This will be a single quoted character list, so you can treat it just as you would any other list. Remember to refer to individual characters as ?T and ?F.

  The second argument is a floating point number between 0 and 1.0 that indicates the probability that a tooth will be a good tooth.

  The result is a list of lists, one list per tooth. If a tooth is present, the sublist has six entries; if a tooth is absent, the sublist is [0].
  """

  def generate_pockets(char_list, prob) do
    :random.seed(:erlang.now())
    generate_pockets(char_list, prob, [])
  end

  @doc """
  The first two arguments are the same as for generate_pockets/2; the third argument is the accumulated list. When the first argument is an empty list, the function yields the reverse of the accumulated list.

  Hint: use pattern matching to figure out whether a tooth is present or not. For a non-present tooth, add [0] to the accumulated list; for a tooth that is present, create a list of six numbers by calling generate_tooth/1 with the probability of a good tooth as its argument.
  """

  def generate_pockets([], _, accumulated) do
    Enum.reverse(accumulated)
  end

  def generate_pockets([char | chars], prob, accumulated) when char == ?F do
    generate_pockets(chars, prob, [[0] | accumulated])
  end

  def generate_pockets([char | chars], prob, accumulated) when char == ?T do
    generate_pockets(chars, prob, [generate_tooth(prob) | accumulated])
  end

  @doc """
  """

  def generate_tooth(prob) do
    generate_tooth((if prob > :random.uniform(), do: 2, else: 3), 6, [])
  end

  @doc """
  """

  def generate_tooth(base_depth, left, accumulated) do
    case left do
      0 -> accumulated
      _ -> generate_tooth(base_depth,
                          left - 1,
                          [(base_depth + (:random.uniform(3) - 2)) | accumulated])
    end
  end
end

NonFP.generate_pockets('FTTTTTTTTTTTTTTFTTTTTTTTTTTTTTTT', 0.75)

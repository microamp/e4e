defmodule ListComp do
  @moduledoc """
  Étude 8-2: List Comprehensions and Pattern Matching

  In iex (or in a module, if you prefer), write a list comprehension that creates a list consisting of the names of all the people who are male and over 40. Use pattern matching to separate the tuple into three variables, and use two guards to do the tests for age and gender. When you use multiple guards in a list comprehension, you get the moral equivalent of combining the conditions with and.

  Then, write a list comprehension that selects the names of all the people who are male or over 40. You can’t use multiple guards here; you want a single guard that explicitly uses the or operator.

  [{"Federico", "M", 22}, {"Kim", "F", 45}, {"Hansa", "F", 30},
   {"Tran", "M", 47}, {"Cathy", "F", 32}, {"Elias", "M", 50}]
  """
  @vsn 0.1

  def list_comp(list) do
    for {name, sex, age} <- list, sex == "M" and age > 40, do: name
  end
end

# tests
people = [{"Federico", "M", 22}, {"Kim", "F", 45}, {"Hansa", "F", 30},
          {"Tran", "M", 47}, {"Cathy", "F", 32}, {"Elias", "M", 50}]
["Tran", "Elias"] = ListComp.list_comp(people)

IO.puts("tests passed!")

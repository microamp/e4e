defmodule Cards do
  @moduledoc """
  """
  @spec make_deck() :: list

  def make_deck() do
    ranks = ["A", 2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K"]
    suits = ["Clubs", "Diamonds", "Hearts", "Spaces"]

    for r <- ranks, s <- suits, do: {r, s}
  end

  def shuffle(list) do
    :random.seed(:erlang.now())
    shuffle(list, [])
  end

  def shuffle([], acc) do
    acc
  end

  def shuffle(list, acc) do
    {leading, [h | t]} = Enum.split(list, :random.uniform(Enum.count(list)) - 1)

    shuffle(leading ++ t, [h | acc])
  end

end

# tests
[
    {"A", "Clubs"}, {"A", "Diamonds"}, {"A", "Hearts"}, {"A", "Spaces"},
    {2, "Clubs"}, {2, "Diamonds"}, {2, "Hearts"}, {2, "Spaces"},
    {3, "Clubs"}, {3, "Diamonds"}, {3, "Hearts"}, {3, "Spaces"},
    {4, "Clubs"}, {4, "Diamonds"}, {4, "Hearts"}, {4, "Spaces"},
    {5, "Clubs"}, {5, "Diamonds"}, {5, "Hearts"}, {5, "Spaces"},
    {6, "Clubs"}, {6, "Diamonds"}, {6, "Hearts"}, {6, "Spaces"},
    {7, "Clubs"}, {7, "Diamonds"}, {7, "Hearts"}, {7, "Spaces"},
    {8, "Clubs"}, {8, "Diamonds"}, {8, "Hearts"}, {8, "Spaces"},
    {9, "Clubs"}, {9, "Diamonds"}, {9, "Hearts"}, {9, "Spaces"},
    {10, "Clubs"}, {10, "Diamonds"}, {10, "Hearts"}, {10, "Spaces"},
    {"J", "Clubs"}, {"J", "Diamonds"}, {"J", "Hearts"}, {"J", "Spaces"},
    {"Q", "Clubs"}, {"Q", "Diamonds"}, {"Q", "Hearts"}, {"Q", "Spaces"},
    {"K", "Clubs"}, {"K", "Diamonds"}, {"K", "Hearts"}, {"K", "Spaces"},
] = Cards.make_deck()

IO.puts("tests passed!")

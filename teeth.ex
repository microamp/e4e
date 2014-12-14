defmodule Teeth do
  @moduledoc """
  Dentists check the health of your gums by checking the depth of the "pockets" at six different locations around each of your 32 teeth. The depth is measured in millimeters. If any of the depths is greater than or equal to four millimeters, that tooth needs attention.
  """
  @vsn 0.1

  @doc """
  The function takes a list of 32 lists of six numbers as its input. If a tooth isn’t present, it is represented by the list [0] instead of a list of six numbers. The function produces a list of the tooth numbers that require attention. The numbers must be in ascending order.
  """
  @spec alert([[number]]) :: [number]

  def alert(lists) do
    Enum.map(
      Enum.filter(
        Enum.with_index(lists),
        fn({list, _}) -> Stats.maximum(list) >= 4 end
      ),
      fn({_, idx} -> idx + 1) end
    )
  end

  def pocket_depths do
    [[0], [2,2,1,2,2,1], [3,1,2,3,2,3],
     [3,1,3,2,1,2], [3,2,3,2,2,1], [2,3,1,2,1,1],
     [3,1,3,2,3,2], [3,3,2,1,3,1], [4,3,3,2,3,3],
     [3,1,1,3,2,2], [4,3,4,3,2,3], [2,3,1,3,2,2],
     [1,2,1,1,3,2], [1,2,2,3,2,3], [1,3,2,1,3,3], [0],
     [3,2,3,1,1,2], [2,2,1,1,3,2], [2,1,1,1,1,2],
     [3,3,2,1,1,3], [3,1,3,2,3,2], [3,3,1,2,3,3],
     [1,2,2,3,3,3], [2,2,3,2,3,3], [2,2,2,4,3,4],
     [3,4,3,3,3,4], [1,1,2,3,1,2], [2,2,3,2,1,3],
     [3,4,2,4,4,3], [3,3,2,1,2,3], [2,2,2,2,3,3],
     [3,2,3,2,3,2]]
  end
end

# tests
[9, 11, 25, 26, 29] = Teeth.alert(Teeth.pocket_depths())

IO.puts("tests passed!")

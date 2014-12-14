defmodule College do
  @moduledoc """
  Étude 7-1: Creating a HashDict from a File
  """
  @vsn 0.1

  @doc """
  Your job in this étude is to read the file and create a HashDict whose key is the room number and whose value is a list of all the courses taught in that room.

  csv format: course_id,course_name,room_no
  """

  def make_room_list(filename) do
    case File.read(filename) do
      {:ok, body} -> read_body(String.split(body, "\n"))
      {:error, msg} -> IO.puts("failed to read #{filename}: #{msg}")
    end
  end

  def read_body(lines) do
    build_map(Enum.filter(lines, fn(line) -> line != "" end), %{})
  end

  def build_map([], map) do
    map
  end

  def build_map([line | lines], map) do
    [_, course_name, room_no] = String.split(line, ",")
    case Dict.has_key?(map, room_no) do
      true -> build_map(lines, Dict.put(map, room_no, [course_name | map[room_no]]))
      false -> build_map(lines, Dict.put(map, room_no, [course_name]))
    end
  end
end

# tests
map = College.make_room_list("courses.csv")
["CIT 050","CIT 042","CIT 020","PSYCH 018"] = map["RF241"]
["PSYCH 092","HIST 010A"] = map["RE311"]
["MATH 061","CHEM 030B","CHEM 030A","CHEM 001B", "CHEM 001A"] = map["AD211"]
["COMSC 076","CIT 010","BIS 107","ACCTG 030"] = map["RF234"]
["BUS 009","LA 050","ESL 346"] = map["RE301"]
["MATH 311"] = map["C104"]

IO.puts("tests passed!")

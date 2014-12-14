defmodule Country do
  defstruct name: "", language: "", cities: []
end

defmodule City do
  defstruct name: "",  population: 0, latitude: 0.0, longitude: 0.0
end

defmodule Geography do
  @moduledoc """
  Étude 7-2: Creating Structures from a File
  Étude 7-3: Using Structures

  In this étude, you will read a CSV (comma-separated values) file with information about countries and cities, Lines with two entries give a country name and its primary language; lines with four entries give a city name, its population, its latitude, and its longitude.

  [example format]
  Germany,German
  Hamburg,1739117,53.57532,10.01534
  Frankfurt am Main,650000,50.11552,8.68417
  Dresden,486854,51.05089,13.73832
  """
  @vsn 0.1

  def make_geo_list(filename) do
    case File.read(filename) do
      {:ok, body} -> read_body(String.split(body, "\n", trim: true))
      {:error, msg} -> IO.puts("failed to read #{filename}: #{msg}")
    end
  end

  def read_body(lines) do
    build_countries(
      Enum.map(
        Enum.filter(lines, fn(line) -> line != "" end),
        fn(line) -> String.split(line, ",") end
      ),
      []
    )
  end

  def build_countries([], countries) do
    countries
  end

  def build_countries([[name, language] | lines], countries) do
    country = %Country{name: name,
                       language: language}
    build_countries(lines, [country | countries])
  end

  def build_countries([[name, population, latitude, longitude] | lines], [country | countries]) do
    city = %City{name: name,
                 population: String.to_integer(population),
                 latitude: String.to_float(latitude),
                 longitude: String.to_float(longitude)}
    new_cities = [city | country.cities]

    # Struct(existing_struct | update_key: update_val)
    build_countries(lines, [%Country{country | cities: new_cities} | countries])
  end

  def filter_countries(countries, language) do
    Enum.filter(countries, fn(c) -> c.language == language end)
  end

  def add_population(country) do
    Enum.sum(Enum.map(country.cities, fn(c) -> c.population end))
  end

  @doc """
  Add a function total_population/2 to the Geography module. The first argument will be a list as constructed by make_geo_list/1, and the second argument is a string giving the name of a language. The function returns the total population of all the cities in countries whose primary language is the one you specified.
  """
  @spec total_population([Country], String.t) :: number

  def total_population(countries, language) do
    Enum.sum(
      Enum.map(
          filter_countries(countries, language),
          fn(country) -> add_population(country) end
      )
    )
  end
end

defprotocol Valid do
  @doc "Returns true if data is considered valid"
  def valid?(data)
end

defimpl Valid, for: City do
  def valid?(data) do
    data.population >= 0 and
    data.latitude >= -90 and
    data.latitude <= 90 and
    data.longitude >= -180 and
    data.longitude <= 180
  end
end

defimpl Inspect, for: City do
  def inspect(city, _) do
    concat(city.name,
           " (",
           to_string(city.population),
           ") ",
           to_string(Float.round(city.latitude * 1.0, 2)),
           "°N",
           to_string(Float.round(city.longitude * 1.0, 2)),
           "°W")
  end
end

# tests
countries = [%Country{cities: [%City{latitude: -16.39889, longitude: -71.535,
                                     name: "Arequipa", population: 841130},
                               %City{latitude: -12.04318, longitude: -77.02824, name: "Lima",
                                     population: 7737002}], language: "Spanish", name: "Peru"},
             %Country{cities: [%City{latitude: 35.87028, longitude: 128.59111,
                                     name: "Daegu", population: 2566540},
                               %City{latitude: 37.56826, longitude: 126.97783, name: "Seoul",
                                     population: 10349312}], language: "Korean", name: "South Korea"},
             %Country{cities: [%City{latitude: 41.38879, longitude: 2.15899,
                                     name: "Barcelona", population: 1621537},
                               %City{latitude: 40.4165, longitude: -3.70256, name: "Madrid",
                                     population: 3255944}], language: "Spanish", name: "Spain"},
             %Country{cities: [%City{latitude: 51.05089, longitude: 13.73832,
                                     name: "Dresden", population: 486854},
                               %City{latitude: 53.57532, longitude: 10.01534, name: "Hamburg",
                                     population: 1739117}], language: "German", name: "Germany"}]
countries = Geography.make_geo_list("geography.csv")
12915852 = Geography.total_population(countries, "Korean")

good = %City{name: "Hamburg", population: 1739117, latitude: 53.57532,
             longitude: 10.01534}
true = Valid.valid?(good)

bad = %City{name: "Nowhere", population: -1000, latitude: 37.1234,
            longitude: -12.457}
false = Valid.valid?(bad)

bad2 = %City{name: "Impossible", population: 1000, latitude: 135.0,
             longitude: 175}
false = Valid.valid?(bad2)

IO.puts("tests passed!")

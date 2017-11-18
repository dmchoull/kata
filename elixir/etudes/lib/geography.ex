defmodule Geography do
  @moduledoc false
  
  @spec make_geo_list(String.t) :: list(Country.t)

  def make_geo_list(file_path) do
    {:ok, file} = File.open(file_path, [:read, :utf8])
    make_geo_list(file, [])
  end

  defp make_geo_list(file, country_list) do
    case IO.read(file, :line) do
      :eof ->
        File.close(file)
        country_list
      line ->
        make_geo_list(file, process_line(parse(line), country_list))
    end
  end

  defp parse(line) do
    line
    |> String.split(",")
    |> Enum.map(&String.strip/1)
  end

  defp process_line([country_name, language], country_list) do
    [%Country{name: country_name, language: language} | country_list]
  end

  defp process_line([city_name, population, lat, lon], country_list) do
    updated_country = update_in(hd(country_list).cities,
                                fn(cities) ->
                                  [%City{name: city_name, population: String.to_integer(population),
                                        latitude: String.to_float(lat), longitude: String.to_float(lon)} | cities]
                                end)
    [updated_country | tl(country_list)]
  end

  @spec total_population(list, String.t) :: integer

  def total_population(geo_list, language) do
    total_population(geo_list, language, 0)
  end

  defp total_population([], _language, total), do: total

  defp total_population([head | tail], language, total) do
    if head.language == language do
      total_population(tail, language, country_population(head) + total)
    else
      total_population(tail, language, total)
    end
  end

  defp country_population(country) do
    Enum.reduce(country.cities, 0, &(&1.population + &2))
  end
end

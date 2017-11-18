defmodule City do
  defstruct name: "", population: 0, latitude: 0.0, longitude: 0.0
end

defprotocol Valid do
  def valid?(data)
end

defimpl Valid, for: City do
  def valid?(%City{population: pop, latitude: lat, longitude: long}) do
    pop >= 0 && lat >= -90 && lat <= 90 && long >= -180 && long <= 180
  end
end

defimpl Inspect, for: City do
  import Inspect.Algebra

  def inspect(item, _) do
    lat = if item.latitude < 0 do
            to_degree(item.latitude, "S")
          else
            to_degree(item.latitude, "N")
          end

    long = if item.longitude < 0 do
             to_degree(item.latitude, "W")
           else
             to_degree(item.latitude, "E")
           end

    concat [item.name, break, "(", to_string(item.population), ")", break, lat, break, long]
  end

  defp to_degree(lat_lon, dir) do
    concat [lat_lon * 1.0 |> abs |> Float.round(2) |> to_string, "°#{dir}"]
  end
end

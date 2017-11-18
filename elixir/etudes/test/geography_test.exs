defmodule GeographyTest do
  use ExUnit.Case, async: true

  test "it works" do
    geo_list = Geography.make_geo_list("geography.csv")

    assert hd(geo_list).name == "Peru"
    assert hd(hd(geo_list).cities).name == "Arequipa"
    assert length(hd(geo_list).cities) == 2
  end

  test "total population" do
    glist = [%Country{cities: [%City{latitude: -16.39889, longitude: -71.535,
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

    assert Geography.total_population(glist, "Korean") == 12915852
  end
end

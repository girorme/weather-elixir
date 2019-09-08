defmodule App.Weather.Test do
  use ExUnit.Case, async: true

  @api "http://api.openweathermap.org/data/2.5/weather?q="

  test "should return a encoded endpoint when take a location" do
    appid = App.Weather.get_appid()
    endpoint = App.Weather.get_endpoint("São Paulo")

    assert "#{@api}S%C3%A3o%20Paulo&appid=#{appid}" == endpoint
  end

  test "should return Celsius when take Kelvin" do
    kelvin_example = 296.48
    celsius_example = 23.3
    temperature = App.Weather.kelvin_to_celsius(kelvin_example)

    assert temperature == celsius_example
  end

  test "should return temperature when take a valid location" do
    temperature = App.Weather.temperature_of("Sao Paulo")

    assert String.contains?(temperature, "Sao Paulo") == true
  end

  test "should return not found when take an invalid location" do
    result = App.Weather.temperature_of("0000000")

    assert result == "0000000 not found"
  end

end

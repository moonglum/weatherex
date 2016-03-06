defmodule WeatherMapTest do
  use ExUnit.Case

  doctest Weatherex.OpenWeatherMap

  @api_key System.get_env("API_KEY")

  test "get cologne" do
    {:ok, %{ "city" => %{ "id" => id }}} = Weatherex.OpenWeatherMap.fetch(@api_key, "de", "cologne", "metric")
    assert id == 6691073
  end

  test "invalid API key" do
    {:error, response} = Weatherex.OpenWeatherMap.fetch("INVALID", "de", "cologne", "metric")
    assert response == "Invalid API key. Please see http://openweathermap.org/faq#error401 for more info."
  end
end

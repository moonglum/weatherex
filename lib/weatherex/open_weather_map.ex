defmodule Weatherex.OpenWeatherMap do
  @moduledoc """
  Communicate with the OpenWeatherMap API
  """

  @user_agent [ {"User-agent", "weatherex"} ]

  @doc """
  Fetch a city from the OpenWeatherMap API
  """
  def fetch(api_key, country, city) do
    construct_url(api_key, country, city)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  @doc """
  Construct the OpenWeatherMap URL for the parameters

  ## Examples

      iex> Weatherex.OpenWeatherMap.construct_url("API", "de", "munich")
      "http://api.openweathermap.org/data/2.5/forecast?q=munich,de&mode=json&appid=API"
  """
  def construct_url(api_key, country, city) do
    "http://api.openweathermap.org/data/2.5/forecast?q=#{city},#{country}&mode=json&appid=#{api_key}"
  end

  @doc """
  Handle responses from the OpenWeatherMap API
  """
  def handle_response({ :ok, %{ status_code: 200, body: body }}) do
    { :ok, Poison.Parser.parse!(body) }
  end

  def handle_response({ _, %{ status_code: status, body: body}}) do
    { :error, Map.fetch!(Poison.Parser.parse!(body), "message") }
  end
end

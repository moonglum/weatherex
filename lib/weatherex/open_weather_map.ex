defmodule Weatherex.OpenWeatherMap do
  use HTTPoison.Base

  @endpoint "http://api.openweathermap.org"

  @moduledoc """
  Communicate with the OpenWeatherMap API
  """

  @doc """
  Fetch a city from the OpenWeatherMap API
  """
  def fetch(api_key, country, city) do
    construct_url(api_key, country, city)
    |> get
    |> handle_response
  end

  @doc """
  Construct the OpenWeatherMap URL for the parameters

  ## Examples

      iex> Weatherex.OpenWeatherMap.construct_url("API", "de", "munich")
      "/data/2.5/forecast?q=munich,de&mode=json&appid=API"
  """
  def construct_url(api_key, country, city) do
    "/data/2.5/forecast?q=#{city},#{country}&mode=json&appid=#{api_key}"
  end

  @doc """
  Handle responses from the OpenWeatherMap API
  """
  def handle_response({ :ok, %{ status_code: 200, body: body }}) do
    { :ok, body }
  end

  def handle_response({ _, %{ body: body}}) do
    { :error, Map.fetch!(body, "message") }
  end

  defp process_response_body(body), do: Poison.Parser.parse!(body)

  defp process_url(url) do
    @endpoint <> url
  end
end

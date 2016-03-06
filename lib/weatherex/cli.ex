defmodule Weatherex.CLI do
  @target_match ~r/\A(?<country>.+)\/(?<city>.+)\z/

  @doc """
  Entry point to the CLI

  It takes the arguments provided to the CLI as well as
  the environment variable API_KEY for
  [OpenWeatherMap](http://openweathermap.org).
  """
  def main(argv) do
    argv
    |> parse_args(System.get_env("API_KEY"))
    |> process
  end

  @doc """
  Parse the arguments provided to the tool

  The tool takes either -h or --help to provide a help text.
  Otherwise it takes a location from where the weather should
  be displayed. This string is a country code followed by a slash
  followed by the name of a city, e.g. "de/cologne".

  In addition it takes the API key for [OpenWeatherMap](http://openweathermap.org)

  ## Examples

      iex> Weatherex.CLI.parse_args(["-h"], "API_KEY")
      :help

      iex> Weatherex.CLI.parse_args(["--help"], "API_KEY")
      :help

      iex> Weatherex.CLI.parse_args(["de/cologne"], "API_KEY")
      %{ "city" => "cologne", "country" => "de", "api_key" => "API_KEY" }
  """
  def parse_args(argv, api_key) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean],
                                     aliases: [ h: :help ])


    case parse do

    { [ help: true ], _, _ }
      -> :help

    { [], [ target ], [] }
      -> Map.merge(Regex.named_captures(@target_match, target), %{ "api_key" => api_key })

    end
  end

  @doc """
  Process the parsed commandline arguments
  """
  def process(:help) do
    IO.puts """
    usage: weatherex de/cologne
      where de is the country code and cologne is the name of the city
    """
    System.halt(0)
  end

  def process(%{ "api_key" => nil}) do
    IO.puts """
    Please provide your API key via the environment variable API_KEY
    """
    System.halt(1)
  end

  def process(%{ "api_key" => api_key, "city" => city, "country" => country}) do
    Weatherex.OpenWeatherMap.fetch(api_key, country, city)
  end
end

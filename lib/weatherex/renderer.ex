# TODO: Maybe this is an extractor, not a renderer?
defmodule Weatherex.Renderer do
  def render(%{ "list" => list }, format) do
    Enum.map(list, &(extract(&1, format)))
  end

  def extract(item, format) do
    %{
      date: date(item),
      temperature: temperature(item, format),
      description: description(item)
    }
  end

  # TODO: Time Zone (see Chronos)
  def date(%{ "dt" => dt }) do
    dt
    |> Chronos.from_epoch_time
    |> Chronos.Formatter.strftime("%Y-%m-%d %H:%M:%S")
  end

  def temperature(%{ "main" => %{ "temp" => temp }}, "metric") do
    "#{temp} °C"
  end

  def description(%{ "weather" => [%{ "description" => description }]}) do
    description
  end

  # TODO: Also provide the language to the API for better descriptions
end

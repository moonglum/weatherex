defmodule RendererTest do
  use ExUnit.Case

  doctest Weatherex.Renderer

  test "render" do
    IO.inspect Weatherex.Renderer.render(test_data, "metric")
  end

  defp test_data do
    %{
      "list" => [
        %{ "dt" => 1457298000, "main" => %{ "temp" => 0.43 }, "weather" => [%{ "description" => "light snow" }] },
        %{ "dt" => 1457308800, "main" => %{ "temp" => -1.55 }, "weather" => [%{ "description" => "clear sky" }] },
        %{ "dt" => 1457319600, "main" => %{ "temp" => -5.23 }, "weather" => [%{ "description" => "clear sky" }] },
        %{ "dt" => 1457330400, "main" => %{ "temp" => -0.95 }, "weather" => [%{ "description" => "light snow" }] }
      ]
    }
  end
end

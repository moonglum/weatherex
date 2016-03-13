defmodule Weatherex.Mixfile do
  use Mix.Project

  def project do
    [app: :weatherex,
     escript: escript_config,
     version: "0.0.1",
     name: "weatherex",
     source_url: "https://github.com/moonglum/weatherex",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     docs: [
      main: "readme",
      extras: [
        "README.md": [ title: "Introduction" ],
        "CONTRIBUTING.md": [ title: "Contributing" ],
        "CODE_OF_CONDUCT.md": [ title: "Code of Conduct" ]
      ]
     ],
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      { :httpoison, "~> 0.8" },
      { :poison, "~> 1.5" },
      { :ex_doc, "~> 0.11" },
      { :earmark, ">= 0.0.0" },
      { :chronos, github: "nurugger07/chronos" }
    ]
  end

  defp escript_config do
    [ main_module: Weatherex.CLI ]
  end
end

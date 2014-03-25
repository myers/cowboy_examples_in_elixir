defmodule BinaryWebsockets.Mixfile do
  use Mix.Project

  def project do
    [ app: :binary_websockets,
      version: "0.0.1",
      elixir: ">= 0.12.5",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: { BinaryWebsockets, [Mix.env] },
      applications: [:cowboy],
    ]
  end

  defp deps do
    [
      {:excbor, github: "myers/excbor", branch: "elixir-0.13"},
      {:cowboy, github: "extend/cowboy", tag: "0.9.0"},
    ]
  end
end

defmodule SockjsEcho.Mixfile do
  use Mix.Project

  def project do
    [ app: :sockjs_echo,
      version: "0.0.1",
      elixir: "~> 0.15.0",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [ 
      applications: [:xmerl, :sockjs, :cowboy],
      mod: { SockjsEcho, [] }
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  defp deps do
    [ 
      { :sockjs, github: "myers/sockjs-erlang", branch: "cowboy-0.9.0" }
    ]
  end
end

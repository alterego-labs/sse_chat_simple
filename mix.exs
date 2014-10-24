defmodule SseChatSimple.Mixfile do
  use Mix.Project

  def project do
    [app: :sse_chat_simple,
     version: "0.0.1",
     elixir: "~> 1.0.0",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      mod:          {SseChatSimple, []},
      applications: [:logger, :cowboy]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      { :cowboy, github: "extend/cowboy", tag: "1.0.0" },
      { :lasse, github: "inaka/lasse", ref: "ddd135dc4526b162b58c43fb3e25f4c35de264a3" },
      { :timex, "~> 0.13.0" },
      { :jsex, "2.0.0" }
    ]
  end
end

defmodule ElaborateImage.Mixfile do
  use Mix.Project

  def project do
    [
      app: :elaborate_image,
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      deps: deps(),
      elixir: "~> 1.6-dev",
      elixirc_paths: elixirc_paths(Mix.env()),
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      version: "0.0.1"
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {ElaborateImage.Application, []},
      extra_applications: [:sentry, :logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:cowboy, "~> 1.0"},
      {:credo, "~> 0.3", only: [:dev, :test]},
      {:excoveralls, "~> 0.8", only: :test},
      {:gettext, "~> 0.11"},
      {:mix_test_watch, "~> 0.5", only: :dev, runtime: false},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix, "~> 1.3.0"},
      {:sentry, "~> 6.0.0"}
    ]
  end
end

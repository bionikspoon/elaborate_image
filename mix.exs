defmodule ElaborateImage.Mixfile do
  use Mix.Project

  def project do
    [
      app: :elaborate_image,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:gettext, "~> 0.11"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix, "~> 1.3.0"},
      {:sentry, "~> 6.0.0"}
    ]
  end
end

defmodule Booking.MixProject do
  use Mix.Project

  def project do
    [
      app: :booking,
      version: "0.1.0",
      elixir: "~> 1.12-dev",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_machina, "~> 2.7.0"},
      {:elixir_uuid, "~> 1.2"},
      {:timex, "~> 3.6"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
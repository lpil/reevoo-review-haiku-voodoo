defmodule RRHV.Mixfile do
  use Mix.Project

  def project do
    [
      app: :rrhv,
      version: "0.0.1",
      elixir: "~> 1.0",
      deps: deps
   ]
  end

  def application do
    [
      applications: [],
      mod: { RRHV, [] },
    ]
  end

  defp deps do
    [
      {:mariaex, "~> 0.1"},
      {:shouldi, "~> 0.2.2", only: :test},
      {:mix_test_watch, []},
    ]
  end
end

defmodule Prosapient.MixProject do
  use Mix.Project

  def project do
    [
      app: :prosapient,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [
        :logger,
        :inets,
        :ssl,
        :sqlite_ecto2,
        :ecto,
        :poison
      ],
      mod: {Prosapient, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poison, "~> 3.1"},
      {:sqlite_ecto2, "~> 2.2"}
    ]
  end
end

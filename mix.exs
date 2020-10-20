defmodule MtlsElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :mtls_elixir,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.7.0"}
    ]
  end
end

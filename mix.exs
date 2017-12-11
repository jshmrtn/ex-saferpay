defmodule ExSaferpay.Mixfile do
  @moduledoc false
  
  use Mix.Project

  def project do
    [
      app: :ex_saferpay,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      dialyzer: [
        ignore_warnings: "dialyzer.ignore-warnings",
        plt_add_apps: [:ex_unit],
      ],
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
      {:ex_doc, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.4", only: [:dev, :test], runtime: false},
      {:credo, "~> 0.5", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.4", only: [:dev, :test], runtime: false},
    ]
  end
end

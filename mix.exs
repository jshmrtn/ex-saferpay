defmodule ExSaferpay.Mixfile do
  @moduledoc false

  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :ex_saferpay,
      version: @version,
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env),
      test_coverage: [tool: ExCoveralls],
      description: description(),
      package: package(),
      dialyzer: [
        ignore_warnings: "dialyzer.ignore-warnings",
        plt_add_apps: [:ex_unit, :mix],
      ],
      docs: [
        source_ref: "v#{@version}",
        groups_for_modules: groups_for_modules(),
      ],
    ]
  end

  defp description do
    """
    Elixir wrapper for Six Saferpay JSON API.
    """
  end

  defp package do
    [
      name: :ex_saferpay,
      files: ["lib", "mix.exs", "README*", "LICENSE"],
      maintainers: ["airatel Inc.", "Jonatan Männchen"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/jshmrtn/ex-saferpay"}
    ]
  end

  defp groups_for_modules do
    [
      "API Client": [
        ExSaferpay,
        ExSaferpay.SecureAliasStore,
        ExSaferpay.Transaction,
      ],
      "Request Model": [
        ExSaferpay.Request,
        ~r/ExSaferpay\.Request\..+/,
      ],
      "Response Model": [
        ~r/ExSaferpay\.Response\..+/,
      ],
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 0.13"},
      {:poison, "~> 3.1"},
      {:uuid, "~> 1.1"},
      {:ex_money, "~> 2.2"},
      {:mock, "~> 0.2.0", only: :test},
      {:ex_doc, ">= 0.0.0", only: [:dev, :test], runtime: false},
      {:inch_ex, only: :docs, runtime: false},
      {:excoveralls, "~> 0.4", only: [:dev, :test], runtime: false},
      {:credo, "~> 0.5", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.4", only: [:dev, :test], runtime: false},
    ]
  end
end

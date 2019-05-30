defmodule Balance.MixProject do
  use Mix.Project

  def project do
    [
      app: :balance,
      version: "0.0.1",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),

      # Docs
      name: "Balance",
      source_url: "https://gitlab.com/iver14/balance",
      home_url: "http://iver.mx/doc/",
      docs: [
        main: "Balance",
        logo: "assets/balance.png",
        extras: ["README.md"]
      ]
    ]
  end

  def description() do
    """
    Library for solve test backend role
    """
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Iván Jaimes"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://gitlab.com/iver14/balance"}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto, "~> 3.0"},
      {:postgrex, "~> 0.14"},
      {:ex_doc, "~> 0.20.1", only: :dev, runtime: false},
      {:credo, "~> 1.0.5", only: [:dev, :test], runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end

defmodule Balance.MixProject do
  use Mix.Project

  def project do
    [
      app: :balance,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      escript: escript(),

      # Docs
      name: "Balance",
      source_url: "https://gitlab.com/iver14/balance",
      home_url: "http://iver.mx/doc/",
      docs: [
        main: "Balance",
        logo: "assets/logo.png",
        markdown_processor: ExDocMakeup,
        extras: ["README.md"]
      ]
    ]
  end

  def escript do
    [main_module: Screen]
  end

  def description do
    """
    Library for solve test backend role
    """
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Balance.Application, []}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Iván Jaimes"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/iver/balance",
        "Gitlab" => "https://gitlab.com/iver14/balance"
      }
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # code quality dependencies
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.3", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
      {:excoveralls, "~> 0.11", only: :test},
      {:makeup, "~> 1.1.0"},
      {:makeup_elixir, "~> 0.16"},

      # used in production
      {:ecto_sql, "~> 3.0"},
      {:poison, "~> 5.0"},
      {:postgrex, "~> 0.14"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "ecto.reset.test": ["ecto.drop", "ecto.create", "ecto.migrate"],
      test: ["ecto.reset.test --quiet", "ecto.migrate", "run priv/repo/seeds.exs", "test"]
    ]
  end
end

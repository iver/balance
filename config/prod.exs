use Mix.Config

config :balance, Balance.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: System.get_env("POSTGRES_DB") || "balance_prod",
  username: System.get_env("POSTGRES_USER") || "balance_prod",
  password: System.get_env("POSTGRES_PASSWORD") || "balance",
  hostname: System.get_env("POSTGRES_HOST") || "postgres"

# Our Console Backend-specific configuration
config :logger, level: :info

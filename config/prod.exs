use Mix.Config

config :balance, Balance.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "balance_prod",
  username: "balance_prod",
  password: "balance",
  hostname: "localhost"

# Our Console Backend-specific configuration
config :logger, level: :info

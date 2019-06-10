use Mix.Config

config :balance, Balance.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "balance",
  username: "balance",
  password: "balance",
  hostname: "localhost"

# Our Logger general configuration
config :logger,
  backends: [:console],
  compile_time_purge_level: :info

# Our Console Backend-specific configuration
config :logger, level: :info

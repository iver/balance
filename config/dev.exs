use Mix.Config

config :balance, Balance.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "balance_dev",
  username: "balance_dev",
  password: "balance",
  hostname: "localhost"

# Our Logger general configuration
config :logger,
  backends: [:console],
  compile_time_purge_level: :debug

# Our Console Backend-specific configuration
config :logger, :console,
  format: "\n##### $time $metadata[$level] $levelpad$message\n",
  metadata: :all

import Config

config :balance, Balance.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: System.get_env("POSTGRES_DB") || "balance_dev",
  username: System.get_env("POSTGRES_USER") || "balance_dev",
  password: System.get_env("POSTGRES_PASSWORD") || "balance",
  hostname: System.get_env("POSTGRES_HOST") || "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Our Logger general configuration
config :logger,
  backends: [:console],
  level: :debug

# Our Console Backend-specific configuration
config :logger, :console,
  format: "\n##### $time $metadata[$level] $levelpad$message\n",
  metadata: :all

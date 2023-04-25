import Config

config :balance, Balance.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: System.get_env("POSTGRES_DB") || "balance_test",
  username: System.get_env("POSTGRES_USER") || "balance_test",
  password: System.get_env("POSTGRES_PASSWORD") || "balance",
  hostname: System.get_env("POSTGRES_HOST") || "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Print only warnings and errors during test
config :logger, level: :warn

use Mix.Config

config :balance, Balance.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "balance_dev",
  username: "balance_dev",
  password: "balance",
  hostname: "localhost"

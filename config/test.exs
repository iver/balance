use Mix.Config

config :balance, Balance.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "balance_test",
  username: "balance_test",
  password: "balance",
  hostname: "localhost"

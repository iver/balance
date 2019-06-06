use Mix.Config

config :balance, Balance.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "balance",
  username: "balance",
  password: "balance",
  hostname: "localhost"

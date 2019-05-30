defmodule Balance.Repo do
  use Ecto.Repo,
    otp_app: :balance,
    adapter: Ecto.Adapters.Postgres
end

require Logger

config = Application.get_env(:balance, Balance.Repo, :database)
Logger.info "Database config: #{inspect config}"

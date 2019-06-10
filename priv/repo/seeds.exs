alias Balance.Repo
alias Balance.Settings
require Logger

config = Application.get_env(:balance, Balance.Repo, :database)
Logger.info "Database config: #{inspect config}"

Repo.insert!(%Settings.Bonus{kind: "team", percent: 0.5})
Repo.insert!(%Settings.Bonus{kind: "individual", percent: 0.5})
Repo.insert!(%Settings.Goal{level: "A", goals: 5, team: "all"})
Repo.insert!(%Settings.Goal{level: "B", goals: 10, team: "all"})
Repo.insert!(%Settings.Goal{level: "C", goals: 15, team: "all"})
Repo.insert!(%Settings.Goal{level: "Cuauh", goals: 20, team: "all"})
Repo.insert!(%Settings.Goal{level: "A", goals: 5, team: "rojo"})
Repo.insert!(%Settings.Goal{level: "B", goals: 10, team: "rojo"})
Repo.insert!(%Settings.Goal{level: "C", goals: 15, team: "rojo"})
Repo.insert!(%Settings.Goal{level: "Cuauh", goals: 20, team: "rojo"})
Repo.insert!(%Settings.Goal{level: "A", goals: 5, team: "azul"})
Repo.insert!(%Settings.Goal{level: "B", goals: 10, team: "azul"})
Repo.insert!(%Settings.Goal{level: "C", goals: 15, team: "azul"})
Repo.insert!(%Settings.Goal{level: "Cuauh", goals: 20, team: "azul"})

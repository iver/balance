alias Balance.Repo
alias Balance.Settings

IO.puts("\n\t[Seeds] Inserting ...")

bonus_settings = [
  %{kind: "team", percent: 0.5},
  %{kind: "individual", percent: 0.5}
]

goal_settings = [
  %{level: "A", goals: 5, team: "all"},
  %{level: "B", goals: 10, team: "all"},
  %{level: "C", goals: 15, team: "all"},
  %{level: "Cuauh", goals: 20, team: "all"},
  %{level: "A", goals: 5, team: "rojo"},
  %{level: "B", goals: 10, team: "rojo"},
  %{level: "C", goals: 15, team: "rojo"},
  %{level: "Cuauh", goals: 20, team: "rojo"},
  %{level: "A", goals: 5, team: "azul"},
  %{level: "B", goals: 10, team: "azul"},
  %{level: "C", goals: 15, team: "azul"},
  %{level: "Cuauh", goals: 20, team: "azul"}
]

options = [on_conflict: :nothing]
{inserted, _} = Repo.insert_all(Settings.Bonus, bonus_settings, options)
IO.puts("\t[Seeds] #{inspect(inserted)} bonus settings was inserted")

{inserted, _} = Repo.insert_all(Settings.Goal, goal_settings, options)
IO.puts("\t[Seeds] #{inspect(inserted)} goal settings was inserted \n")

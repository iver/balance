defmodule Balance.Repo.Migrations.GoalSettings do
  use Ecto.Migration

  def change do
    create table(:goal_settings) do
      add :level, :string, null: false
      add :goals, :integer, default: 0
      add :team, :string, default: "all"
    end
  end
end

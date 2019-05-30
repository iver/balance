defmodule Balance.Repo.Migrations.BonusSettings do
  use Ecto.Migration

  def change do
    create table(:bonus_settings) do
      add :percent, :float, defaul: 0.5
      add :kind, :string, defaul: "team"
    end
  end
end

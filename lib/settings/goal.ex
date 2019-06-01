defmodule Balance.Goal do
  use Ecto.Schema
  import Ecto.Changeset

  schema "goal_settings" do
    field(:level, :string)
    field(:goals, :integer, default: 0)
    field(:team, :string, default: "all")
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:level, :goals, :team])
  end

end

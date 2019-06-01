defmodule Balance.Goal do
  use Ecto.Schema
  import Ecto.Changeset

  @levels ["A", "B", "C", "Cuauh"]

  schema "goal_settings" do
    field(:level, :string)
    field(:goals, :integer)
    field(:team, :string, default: "all")
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:level, :goals, :team])
    |> validate_required([:level, :goals])
    |> validate_level()
    |> validate_number(:goals, greater_than: 0)
  end

  @doc """
  Validate a level is belongs to the allowed levels

  ## Examples

     iex> change = Balance.Goal.changeset(%Balance.Goal{}, %{level: "B", goals: 7, team: "all"})
     iex> Balance.Goal.validate_level(change)
     #Ecto.Changeset<action: nil, changes: %{goals: 7, level: \"B\"}, errors: [], data: #Balance.Goal<>, valid?: true>

  """
  def validate_level(changeset) do
    level = get_field(changeset, :level)

    if level in @levels do
      changeset
    else
      add_error(changeset, :level, "invalid level")
    end
  end
end

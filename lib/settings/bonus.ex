defmodule Balance.Bonus do
  use Ecto.Schema
  import Ecto.Changeset

  @kinds_names ["team", "individual"]

  schema "bonus_settings" do
    field(:percent, :float, default: 0.5)
    field(:kind, :string, default: "team")
  end

  def changeset(bonus, params) do
    bonus
    |> cast(params, [:percent, :kind])
    |> validate_kind()
  end

  @doc """
  Validate when a bonus kind belongs to the allowed types

  ## Examples

     iex> change = Balance.Bonus.changeset(%Balance.Bonus{}, %{percent: 1, kind: "team"})
     iex> Balance.Bonus.validate_kind(change)
     #Ecto.Changeset<action: nil, changes: %{percent: 1.0}, errors: [], data: #Balance.Bonus<>, valid?: true>

     iex> change = Balance.Bonus.changeset(%Balance.Bonus{}, %{percent: 1, kind: "invalid team"})
     iex> Balance.Bonus.validate_kind(change)
     #Ecto.Changeset<action: nil, changes: %{kind: \"invalid team\", percent: 1.0}, errors: [kind: {\"invalid kind name\", []}, kind: {\"invalid kind name\", []}], data: #Balance.Bonus<>, valid?: false>

  """
  def validate_kind(changeset) do
    kind = get_field(changeset, :kind)

    if kind in @kinds_names do
      changeset
    else
      add_error(changeset, :kind, "invalid kind name")
    end
  end
end

defmodule Settings.Bonus do
  @moduledoc """
  Bonus module is used to save into repository and validate any worng data
  """
  use Ecto.Schema
  import Ecto.Changeset

  @kinds ["team", "individual"]

  @derive {Poison.Encoder, only: [:percent, :kind]}
  schema "bonus_settings" do
    field(:percent, :float, default: 0.5)
    field(:kind, :string, default: "team")
  end

  def changeset(bonus, params) do
    bonus
    |> cast(params, [:percent, :kind])
    |> validate_kind()
    |> validate_number(:percent, greater_than: 0)
  end

  @doc """
  Validate when a bonus kind belongs to the allowed types

  ## Examples

     iex> change = Settings.Bonus.changeset(%Settings.Bonus{}, %{percent: 1, kind: "team"})
     iex> Settings.Bonus.validate_kind(change)
     #Ecto.Changeset<action: nil, changes: %{percent: 1.0}, errors: [], data: #Settings.Bonus<>, valid?: true>

     iex> change = Settings.Bonus.changeset(%Settings.Bonus{}, %{percent: 1, kind: "invalid team"})
     iex> Settings.Bonus.validate_kind(change)
     #Ecto.Changeset<action: nil, changes: %{kind: \"invalid team\", percent: 1.0}, errors: [kind: {\"invalid kind name\", []}, kind: {\"invalid kind name\", []}], data: #Settings.Bonus<>, valid?: false>

  """
  def validate_kind(changeset) do
    kind = get_field(changeset, :kind)

    if kind in @kinds do
      changeset
    else
      add_error(changeset, :kind, "invalid kind name")
    end
  end
end

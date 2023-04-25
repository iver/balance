defmodule Balance.Settings.Bonus do
  @moduledoc """
  Representa la configuración de la bonificación, aquí se validan los poncentajes y tipos.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: __MODULE__

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
  Valida cuando una bonificación pertenece a un tipo permitido.

  ## Ejemplos

  ```elixir

     iex> alias Balance.Settings.Bonus
     iex> change = Bonus.changeset(%Bonus{}, %{percent: 1, kind: "team"})
     iex> Bonus.validate_kind(change)
     #Ecto.Changeset<action: nil, changes: %{percent: 1.0}, errors: [], data: #Balance.Settings.Bonus<>, valid?: true>

     iex> alias Balance.Settings.Bonus
     iex> change = Bonus.changeset(%Bonus{}, %{percent: 1, kind: "invalid team"})
     iex> Bonus.validate_kind(change)
     #Ecto.Changeset<action: nil, changes: %{kind: \"invalid team\", percent: 1.0}, errors: [kind: {\"invalid kind name\", []}, kind: {\"invalid kind name\", []}], data: #Balance.Settings.Bonus<>, valid?: false>

  ```

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

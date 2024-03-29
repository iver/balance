defmodule Balance.Settings.Goal do
  @moduledoc """
  Representa la configuración de como debe clasificarse
  la calificación de los jugadores en función del número de goles.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Balance.Settings

  @type t :: __MODULE__

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
  Valida si un nivel pertenece a los niveles permitidos

  ## Ejemplos

  ```elixir

     iex> change = Balance.Settings.Goal.changeset(%Balance.Settings.Goal{}, %{level: "B", goals: 7, team: "all"})
     iex> Balance.Settings.Goal.validate_level(change)
     #Ecto.Changeset<action: nil, changes: %{goals: 7, level: \"B\"}, errors: [], data: #Balance.Settings.Goal<>, valid?: true>

  ```

  """
  def validate_level(changeset) do
    level = get_field(changeset, :level)

    if level in @levels do
      changeset
    else
      add_error(changeset, :level, "invalid level")
    end
  end

  defimpl Counter do
    def sum(%Settings.Goal{team: team_setting, goals: goals}, acc, team) do
      if team_setting == team, do: goals + acc, else: acc
    end
  end
end

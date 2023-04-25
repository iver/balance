defmodule Balance.Models.Player do
  @moduledoc """
  Entidad que representa a un jugador
  """

  defstruct(
    name: "",
    level: "",
    goals: 0,
    fixed: 0,
    bonus: 0,
    variable: 0,
    total: 0,
    team: ""
  )

  @type t :: __MODULE__

  defimpl Counter do
    def sum(%Balance.Models.Player{team: team_player, goals: goals}, acc, team) do
      if team_player == team, do: goals + acc, else: acc
    end
  end
end

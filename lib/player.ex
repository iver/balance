defmodule Player do
  @moduledoc """
  Entity that represents a player
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

  defimpl Counter do
    def sum(%Player{team: team_player, goals: goals}, acc, team) do
      if team_player == team, do: goals + acc, else: acc
    end
  end
end

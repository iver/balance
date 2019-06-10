defmodule Team do
  @moduledoc """
  Encapsulates the tasks to be performed per team.
  """

  @doc """
  Convert a json string to player list as [%Player{}]

  """
  def extract(data) when is_bitstring(data) do
    with {:ok, json} <- Poison.decode(data),
         {:ok, players} <- extract(json) do
      {:ok, players}
    else
      :error -> {:error, "The data couldn't parse"}
    end
  end

  @doc """
  Convert a decoded list to player list as [%Player{}]

  """
  def extract(players) do
    result =
      Enum.reduce(players, [], fn player, list ->
        [
          %Balance.Models.Player{
            name: player["nombre"],
            level: player["nivel"],
            goals: player["goles"],
            fixed: player["sueldo"],
            bonus: player["bono"],
            team: player["equipo"],
            total: player["sueldo_completo"]
          }
          | list
        ]
      end)

    {:ok, result}
  end
  def export(players) do

    result =
      Enum.reduce(players, [], fn player, list ->
        [
          %{
            nombre: player.name,
            nivel: player.level,
            goles: player.goals,
            sueldo: player.fixed,
            bono: player.bonus,
            equipo: player.team,
            sueldo_completo: player.total
          }
          | list
        ]
      end)

    {:ok, result}
  end
end

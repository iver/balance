defmodule Team do
  @moduledoc """
  Encapsula las tareas a realizar que están relacionadas con un equipo.
  """

  @doc """
  Convierte una cadena de jugadores en formato JSON
  a una lista de tipo `[%Balance.Models.Player{}]`.

  También convierte una lista de valores a una de [%Player{}]

  """
  def extract(data) when is_bitstring(data) do
    with {:ok, list} <- Json.Parser.decode(data),
         {:ok, players} <- extract(list) do
      {:ok, players}
    else
      :error -> {:error, "The data couldn't parse"}
    end
  end

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

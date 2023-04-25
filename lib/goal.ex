defmodule Goal do
  @moduledoc """
  Contiene lo relacionado a cálculos en función de
  goles, por ejemplo el pocentaje por jugador.
  """
  require Logger

  alias Balance.Models.Player
  alias Balance.Settings.Goal

  @spec percentage(number, number) :: map()
  def percentage(%{players: players, goals: goals}) do
    Logger.debug("percentage!(#{players}, #{goals})")

    if players > 0 && goals > 0 do
      result = players / goals
      {:ok, result}
    else
      {:error, "Goals must be greather than zero"}
    end
  end

  @doc """
  Calcula el porcentaje de goles por jugador.

  ## Ejemplo

  ```elixir

     iex> player = %Balance.Models.Player{goals: 9, level: "C"}
     iex> goal_settings = [%Balance.Settings.Goal{level: "C", goals: 10, team: "all"}]
     iex> Goal.percentage(player, goal_settings)
     %{individual: 0.9}

   ```

  """
  @spec percentage(Player.t(), [Goal.t()]) :: map()
  def percentage(player, goals_settings) do
    Logger.debug("percentage(player. goals_settings)")
    Logger.debug("Player: #{inspect(player)} -- goals_settings: #{inspect(goals_settings)}")
    individual = player.goals / by_level(player.level, goals_settings)
    %{individual: individual}
  end

  @doc """
  Calcula el porcentaje de goles por equipo

  ## Ejemplo

  ```elixir

     iex> players = [%Balance.Models.Player{goals: 9, team: "all"}, %Balance.Models.Player{goals: 10, team: "all"}]
     iex> goal_settings = [%Balance.Settings.Goal{level: "C", goals: 10, team: "all"}, %Balance.Settings.Goal{level: "A", goals: 10, team: "all"}]
     iex> Goal.percentage(players, goal_settings, "all")
     %{team: 0.95}

  ```

  """
  def percentage(players, goals_settings, team) do
    players = count(players, team)
    goals = count(goals_settings, team)
    Logger.debug("-- Percentage -- team: #{team}")

    case percentage(%{players: players, goals: goals}) do
      {:ok, result} ->
        %{team: result}

      {:error, result} ->
        Logger.info("Error: #{result}")
        %{team: result}
    end
  end

  @doc """
  Regresa los goles realizados por equipo. La lista usada como parámetro
  debe implementar el protocolo `Counter`

  ## Ejemplos

  ```elixir

     iex> settings = [%Balance.Settings.Goal{ goals: 5,team: "all"}, %Balance.Settings.Goal{ goals: 10, team: "all"}, %Balance.Settings.Goal{goals: 15, team: "all" }, %Balance.Settings.Goal{ goals: 20, team: "all" }]
     iex> Goal.count(settings, "all")
     50

     iex> players = [%Balance.Models.Player{name: "Juan", goals: 10, team: "rojo"},
     ...> %Balance.Models.Player{name: "Pablo", goals: 5, team: "rojo"},
     ...> %Balance.Models.Player{name: "Tirso", goals: 25, team: "blanco"},
     ...> %Balance.Models.Player{name: "Tercero", goals: 15, team: "rojo"}]
     iex> Goal.count(players, "rojo")
     30

  ```

  """
  @spec count(Counter.t(), String.t()) :: integer
  def count(list, team) when is_list(list) do
    Enum.reduce(list, 0, fn element, acc ->
      Counter.sum(element, acc, team)
    end)
  end

  @spec by_level(String.t(), [Goal.t()]) :: number
  def by_level(level, goal_settings) do
    settings = Enum.find(goal_settings, fn element -> element.level == level end)
    settings.goals
  end
end

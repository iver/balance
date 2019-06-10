defmodule Goal do
  @doc """
  Calculate the goal percent by player

  ## Example

  ```

     iex> player = %Balance.Models.Player{goals: 9, level: "C"}
     iex> goal_settings = [%Balance.Settings.Goal{level: "C", goals: 10, team: "all"}]
     iex> Goal.percentage(player, goal_settings)
     %{individual: 0.9}

   ```

  """
  def percentage(player, goals_settings) do
    individual = player.goals / Goal.by_level(player.level, goals_settings)
    %{individual: individual}
  end

  @doc """
  Calculate the goal percent by team

  ## Example

  ```

     iex> players = [%Balance.Models.Player{goals: 9, team: "all"}, %Balance.Models.Player{goals: 10, team: "all"}]
     iex> goal_settings = [%Balance.Settings.Goal{level: "C", goals: 10, team: "all"}, %Balance.Settings.Goal{level: "A", goals: 10, team: "all"}]
     iex> Goal.percentage(players, goal_settings, "all")
     %{team: 0.95}

  ```

  """
  def percentage(players, goals_settings, team) do
    players = Goal.count(players, team)
    goals = Goal.count(goals_settings, team)
    %{team: percentage!(players, goals)}
  end

  @spec percentage!(number, number) :: number | no_return
  def percentage!(players, goals) do
    if players > 0 && goals > 0 do
      players / goals
    else
      raise "Goals must be greather than zero"
    end
  end

  @doc """
  Returns team's goals done. The List() using as parameter must
  implement the Counter protocol.

  ## Examples

  ```

     iex> settings = Balance.Repo.list_goals_settings()
     iex> Goal.count(settings, "all")
     25

     iex> players = [%Balance.Models.Player{name: "Juan", goals: 10, team: "rojo"},
     ...> %Balance.Models.Player{name: "Pablo", goals: 5, team: "rojo"},
     ...> %Balance.Models.Player{name: "Tirso", goals: 25, team: "blanco"},
     ...> %Balance.Models.Player{name: "Tercero", goals: 15, team: "rojo"}]
     iex> Goal.count(players, "rojo")
     30

  ```

  """
  @spec count([%{}], String.t()) :: integer
  def count(list, team) when is_list(list) do
    Enum.reduce(list, 0, fn element, acc ->
      Counter.sum(element, acc, team)
    end)
  end

  @spec by_level(String.t(), [%Balance.Settings.Goal{}]) :: number
  def by_level(level, goal_settings) do
    settings = Enum.find(goal_settings, fn element -> element.level == level end)
    settings.goals
  end
end

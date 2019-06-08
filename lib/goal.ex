defmodule Goal do
  @doc """
  Calculate the goal percent by player

  ## Example

     iex> player = %Player{goals: 9, level: "C"}
     iex> goal_settings = [%Settings.Goal{level: "C", goals: 10, team: "all"}]
     iex> Goal.percentage(player, goal_settings)
     %{individual: 0.9}

  """
  def percentage(player, goals_settings) do
    individual = player.goals / Goal.by_level(player.level, goals_settings)
    %{individual: individual}
  end

  @doc """
  Calculate the goal percent by team

  ## Example

  iex> players = [%Player{goals: 9, team: "all"}, %Player{goals: 10, team: "all"}]
  iex> goal_settings = [%Settings.Goal{level: "C", goals: 10, team: "all"}, %Settings.Goal{level: "A", goals: 10, team: "all"}]
  iex> Goal.percentage(players, goal_settings, "all")
  %{team: 0.95}

  """
  def percentage(players, goals_settings, team) do
    player = Goal.count(players, team)
    goals = Goal.count(goals_settings, team)
    require Logger
    Logger.info("Count: #{player} count: #{goals}")
    team = player / goals
    %{team: team}
  end

  @doc """
  Returns team's goals done. The List() using as parameter must
  implement the Counter protocol.

  ## Examples

     iex> settings = Balance.Repo.list_goals_settings()
     iex> Goal.count(settings, "all")
     25

     iex> players = [%Player{name: "Juan", goals: 10, team: "rojo"},
     ...> %Player{name: "Pablo", goals: 5, team: "rojo"},
     ...> %Player{name: "Tirso", goals: 25, team: "blanco"},
     ...> %Player{name: "Tercero", goals: 15, team: "rojo"}]
     iex> Goal.count(players, "rojo")
     30

  """
  @spec count([%{}], String.t()) :: integer
  def count(list, team) when is_list(list) do
    Enum.reduce(list, 0, fn element, acc ->
      Counter.sum(element, acc, team)
    end)
  end

  def by_level(level, goal_settings) do
    settings = Enum.find(goal_settings, fn element -> element.level == level end)
    settings.goals
  end
end
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

  defimpl Salary, for: Player do
    @spec salary(%Player{}, %{goals: [%Settings.Goal{}], bonus: [%Settings.Bonus{}]}) :: float
    def salary(_player, _settings) do
      10
    end
  end

  defimpl Counter do
    def sum(%Player{team: team_player, goals: goals}, acc, team) do
      if team_player == team, do: goals + acc, else: acc
    end
  end

  def individual_bonus(player, %{goals: goal_settings, bonus: bonus_settings}) do
    personal_percent = player.goals / goals_by(player.level, goal_settings)
    individual_bonus = player.bonus * Bonus.percentage(:individual, bonus_settings)
    personal_percent * individual_bonus
  end

  def goals_by(level, goal_settings) do
    settings = Enum.find(goal_settings, fn element -> element.level == level end)
    settings.goals
  end
end

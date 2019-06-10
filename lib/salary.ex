defmodule Balance.Salary do
  require Logger
  @doc """
  Returns bonus tupe as %{individual: bonus, team: bonus} calculated depends on the player
  definition and current settings
  """
  @spec bonus(%Balance.Models.Player{}, %Balance.Settings.Goal{}) :: %{}
  def bonus(player, goal_settings) do
    # settings %{percent: %{individual: individual, team: team}}
    percent = Bonus.percentage(goal_settings)
    # %{amount: %{individual: individual, team: team}}
    Bonus.amount(percent, player.bonus)
  end

  def calculate(players, player, %{goals: goal_settings, bonus: bonus_settings}) do
    amount = Balance.Salary.bonus(player, bonus_settings)
    individual = Goal.percentage(player, goal_settings)
    team_percent = Goal.percentage(players, goal_settings, player.team)
    bonus = total_bonus(%{percent: Enum.into(individual, team_percent)}, amount)
    total = normalize(player.fixed, bonus)
    %{player | total: total}
  end

  @doc """
  Get total bonus from individual and team limits
  """
  def total_bonus(%{percent: percent}, %{amount: amount}) do
    individual = amount.individual * percent.individual
    team = amount.team * percent.team
    limit(individual, amount.individual) + limit(team, amount.team)
  end

  def normalize(fixed, bonus) do
    salary = fixed + bonus
    :erlang.float_to_binary(salary,  [decimals: 2])
  end

  defp limit(bonus, amount) do
    if bonus > amount, do: amount, else: bonus
  end
end

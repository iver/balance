defmodule Balance.Salary do
  @doc """
  Returns bonus tupe as %{individual: bonus, team: bonus} calculated depends on the player
  definition and current settings
  """
  @spec bonus(%Player{}, %Settings.Goal{}) :: %{}
  def bonus(player, goal_settings) do
    # settings %{percent: %{individual: individual, team: team}}
    percent = Bonus.percentage(goal_settings)
    # %{amount: %{individual: individual, team: team}}
    Bonus.amount(percent, player.bonus)
  end

  # Eliminar
  #  def bonus(%{bonus: bonus}, percent) do
  #    individual = bonus.individual * percent.individual
  #    team = bonus.team * percent.team
  #    %{ok: %{individual: limit(individual, bonus.individual), team: limit(team, bonus.team)}}
  #  end
end
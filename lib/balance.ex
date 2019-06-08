defmodule Balance do
  @moduledoc """
  Module responsible for calculating players' income at resuelve
  """

  @doc """
  Read a file in json format and return a list of players
  """
  def read_file(filename) do
    with {:ok, body} <- File.read(filename),
         {:ok, players} <- Team.parser(body) do
      players
    else
      :error -> {:error, "The #{filename} couldn't parse"}
    end
  end

  def calculate(players, %{goals: goal_settings, bonus: bonus_settings}) do
    Enum.reduce(players, [], fn player, acc ->
      amount = Balance.Salary.bonus(player, bonus_settings)
      individual = Goal.percentage(player, goal_settings)
      team_percent = Goal.percentage(players, goal_settings, player.team)

      bonus = total_bonus(%{percent: Enum.into(individual, team_percent)}, amount)
      player = %{player | total: player.fixed + bonus}
      [player | acc]
    end)
  end

  @doc """
  Get total bonus from individual and team limits
  """
  def total_bonus(%{percent: percent}, %{amount: amount}) do
    individual = amount.individual * percent.individual
    team = amount.team * percent.team
    limit(individual, amount.individual) + limit(team, amount.team)
  end

  defp limit(bonus, amount) do
    if bonus > amount, do: amount, else: bonus
  end
end

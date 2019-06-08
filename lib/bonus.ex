defmodule Bonus do
  @doc """
  Returns the bonus settings defined for team use

  ## Example

     iex> settings = Balance.Repo.list_bonus_settings()
     iex> Bonus.percentage(settings)
     %{percent: %{individual: 1.0, team: 0.5}}

  """
  @spec percentage([%Settings.Bonus{}]) :: %{}
  def percentage(bonus_settings) do
    team = Enum.find(bonus_settings, fn bonus -> bonus.kind == "team" end)
    individual = Enum.find(bonus_settings, fn bonus -> bonus.kind == "individual" end)
    %{percent: %{individual: individual.percent, team: team.percent}}
  end

  @doc """
  Calculate individual and team amount of bonus.

  ## Example

     iex> Bonus.amount(%{percent: %{individual: 0.6, team: 0.4}}, 5000)
     %{amount: %{individual: 3000.00, team: 2000.00 }}

  """
  def amount(%{percent: percent}, total_bonus) do
    individual = percent.individual * total_bonus
    team = percent.team * total_bonus

    %{
      amount: %{
        individual: individual,
        team: team
      }
    }
  end
end

defmodule Bonus do
  @doc """
  Returns the bonus settings defined for team use

  ## Example

  ```elixir

     iex> settings = [%Balance.Settings.Bonus{kind: "team", percent: 0.5},%Balance.Settings.Bonus{kind: "individual",percent: 1.0}]
     iex> Bonus.percentage(settings)
     %{percent: %{individual: 1.0, team: 0.5}}

  ```

  """
  @spec percentage([%Balance.Settings.Bonus{}]) :: %{}
  def percentage(bonus_settings) do
    team = Enum.find(bonus_settings, fn bonus -> bonus.kind == "team" end)
    individual = Enum.find(bonus_settings, fn bonus -> bonus.kind == "individual" end)
    %{percent: %{individual: individual.percent, team: team.percent}}
  end

  @doc """
  Calculate individual and team amount of bonus.

  ## Example

   ```elixir

     iex> Bonus.amount(%{percent: %{individual: 0.6, team: 0.4}}, 5000)
     %{amount: %{individual: 3000.00, team: 2000.00 }}

   ```
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

  def update_settings(settings) do
    case Json.Parser.decode(settings) do
      {:ok, bonus} ->
        case Balance.Repo.create_bonus(bonus) do
          {:ok, bonus} -> bonus
          {:error, error} -> error
        end

      {:error, error_info} ->
        error_info
    end
  end
end

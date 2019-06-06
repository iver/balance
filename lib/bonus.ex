defmodule Bonus do
  @doc """
  Returns the bonus settings defined for individual use

  ## Example

     iex> settings = Balance.Repo.list_bonus_settings()
     iex> Bonus.percentage(:individual, settings)
     1.0

  """
  @spec percentage(atom(), [%Settings.Bonus{}]) :: %Settings.Bonus{}
  def percentage(:individual, bonus_settings) do
    bonus = Enum.find(bonus_settings, fn bonus -> bonus.kind == "individual" end)
    bonus.percent
  end

  @doc """
  Returns the bonus settings defined for team use

  ## Example

     iex> settings = Balance.Repo.list_bonus_settings()
     iex> Bonus.percentage(:team, settings)
     0.5

  """
  @spec percentage(atom(), [%Settings.Bonus{}]) :: %Settings.Bonus{}
  def percentage(:team, bonus_settings) do
    bonus = Enum.find(bonus_settings, fn bonus -> bonus.kind == "team" end)
    bonus.percent
  end
end

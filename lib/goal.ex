defmodule Goal do
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
end

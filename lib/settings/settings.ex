defmodule Settings do
  alias Balance.Repo

  @moduledoc """
  Define settings type like %Settings.Goal{} and %Settings.Bonus{}
  """
  defstruct goals: nil, bonus: nil

  @type t(goals, bonus) :: %Settings{goals: goals, bonus: bonus}

  @type t :: %Settings{goals: %Settings.Goal{}, bonus: %Settings.Bonus{}}

  @doc """
  Load available settings and returns a %Settings{} struct
  """
  @spec load() :: Settings.t()
  def load do
    goals = Repo.list_goals_settings()
    bonus = Repo.list_bonus_settings()
    %Settings{goals: goals, bonus: bonus}
  end
end

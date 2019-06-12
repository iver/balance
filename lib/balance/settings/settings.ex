defmodule Balance.Settings do
  alias Balance.Repo
  alias __MODULE__

  @moduledoc """
  Define settings type like `%Settings.Goal{}` and `%Settings.Bonus{}`
  """
  defstruct goals: nil, bonus: nil

  @type t(goals, bonus) :: %Settings{goals: goals, bonus: bonus}

  @typedoc """
  Represents Balance.Settings types with `:goals` and `:bonus` atoms as settings members of `%Settings.Goal{}` and `%Settings.Bonus{}` respectively
  """
  @type t :: %Settings{goals: %Settings.Goal{}, bonus: %Settings.Bonus{}}

  @doc """
  Load available settings and returns a %Settings{} struct
  """
  @spec load() :: Balance.Settings.t()
  def load do
    goals = Repo.list_goals_settings()
    bonus = Repo.list_bonus_settings()
    %Settings{goals: goals, bonus: bonus}
  end
end

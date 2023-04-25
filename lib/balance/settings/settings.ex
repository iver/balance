defmodule Balance.Settings do
  @moduledoc """
  Define settings type like `%Settings.Goal{}` and `%Settings.Bonus{}`
  """

  alias Balance.Repo
  alias Balance.Settings
  alias Balance.Settings.Bonus
  alias Balance.Settings.Goal

  defstruct goals: nil, bonus: nil

  @typedoc """
  Representa los tipos de `Balance.Settings` con átomos `:goals` y `:bonus`
  como miembros de configuración de `%Balance.Settings.Goal{}` y `%Balance.Settings.Bonus{}` respectivamente

  """
  @type t :: %Settings{goals: Goal.t(), bonus: Bonus.t()}

  @doc """
  Obtiene la configuración almancenada en base de datos
  y regresa una estructura de tipo `%Balance.Settings{}`

  ## Ejemplos

  ```elixir

  iex> %Balance.Settings{goals: goals, bonus: bonus} = Balance.Settings.load()
  iex> is_list(bonus)
  true
  iex> is_list(goals)
  true

  ```

  """
  @spec load() :: Settings.t()
  def load do
    goals = Repo.list_goals_settings()
    bonus = Repo.list_bonus_settings()
    %Settings{goals: goals, bonus: bonus}
  end
end

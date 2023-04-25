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
    goals = list_goals()
    bonus = list_bonus()
    %Settings{goals: goals, bonus: bonus}
  end

  @doc """
  Obtiene una lista de `Balance.Settings.Goal`

  ## Ejemplo:

  ```elixir

  > Balance.Settings.list_goals()
  [%Balance.Settings.Goal{}]

  ```

  """
  def list_goals do
    Repo.all(Settings.Goal)
  end

  @doc """
  Obtiene una lista de configuraciones de los bonos.
  `[Balance.Settings.Bonus]`

  ## Ejemplo:

  ```elixir

  > Balance.Settings.list_bonus()
  [%Balance.Settings.Bonus{}]

  ```

  """
  def list_bonus do
    Repo.all(Settings.Bonus)
  end
end

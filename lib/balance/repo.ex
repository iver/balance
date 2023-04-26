defmodule Balance.Repo do
  @moduledoc """
  Brinda acceso al repositorio de almacenamiento
  """
  use Ecto.Repo,
    otp_app: :balance,
    adapter: Ecto.Adapters.Postgres

  alias __MODULE__
  alias Balance.Settings

  @doc """
  Crea un `Balance.Settings.Bonus`.

  ## Ejemplos:

  ```elixir

     iex> Balance.Repo.create_bonus(%{percent: 0.5, kind: "individual"})
     {:ok, %Balance.Settings.Bonus{}}

     iex> Balance.Repo.create_bonus(%{percent: 0.3, kind: "other_data"})
     {:error, %Ecto.Changeset{}}

  ```

  """
  def create_bonus(attrs \\ %{}) do
    %Settings.Bonus{}
    |> Settings.Bonus.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Actualiza un `Balance.Settings.Bonus`

  ## Ejemplos:

  ```elixir

     iex> bonus = Balance.Repo.get_by(id: 1)
     iex> Balance.Repo.update_bonus(bonus, %{percent: 0.4})
     {:ok, %Balance.Settings.Bonus{percent: 0.4}}

     iex> bonus = Balance.Repo.get_by(id: 1)
     iex> Balance.Repo.update_bonus(bonus, %{percent: -1})
     {:error, %Ecto.Changeset{}}

  ```

  """
  def update_bonus(%Settings.Bonus{} = bonus, attrs) do
    bonus
    |> Settings.Bonus.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Borra un `Balance.Settings.Bonus`

  ## Ejemplos:

  ```elixir

     iex> bonus = Balance.Repo.get_by(id: 1)
     iex> Balance.Repo.delete_bonus(bonus)
     {:ok, %Balance.Settings.Bonus{}}

     iex> bonus = Balance.Repo.get_by(id: 5)
     iex> Balance.Repo.delete_bonus(bonus)
     {:error, %Ecto.Changeset{}}

  ```

  """
  def delete_bonus(%Settings.Bonus{} = bonus) do
    Repo.delete(bonus)
  end

  @doc """
  Crea un `Balance.Settings.Goal`.

  ## Ejemplo:

  ```elixir

     iex> Balance.Repo.create_goal(%{level: "D", goals: 12, team: "juniors"})
     {:ok, %Balance.Settings.Goal{}}

     iex> Balance.Repo.create_goal(%{level: 1, goals: 10, team: "team"})
     {:error, %Ecto.Changeset{}}

  ```

  """
  def create_goal(attrs \\ %{}) do
    %Settings.Goal{}
    |> Settings.Goal.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Actualiza un `Balance.Settings.Goal`.

  ## Ejemplos:

  ```elixir

     iex> goal = Balance.Repo.get_by(id: 1)
     iex> Balance.Repo.update_goal(goal, %{level: "A", goals: 12, team: "rojo"})
     {:ok, %Balance.Settings.Goal{}}

     iex> goal = Balance.Repo.get_by(id: 1)
     iex> Balance.Repo.update_goal(goal, %{level: "X", goals: 19, team: "blanco"})
     {:error, %Ecto.Changeset{}}

  ```

  """
  def update_goal(%Settings.Goal{} = goal, attrs) do
    goal
    |> Settings.Goal.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Borra un `Balance.Settings.Goal`

  ## Ejemplos:

  ```elixir

     iex> goal = Balance.Repo.get_by(id: 1)
     iex> Balance.Repo.delete_goal(goal)
     {:ok, %Balance.Settings.Goal{}}

     iex> goal = Balance.Repo.get_by(id: 1)
     iex> Balance.Repo.delete_goal(goal)
     {:error, %Ecto.Changeset{}}

  ```

  """
  def delete_goal(%Settings.Goal{} = goal) do
    Repo.delete(goal)
  end

  if Mix.env() in [:dev, :test] do
    @spec truncate(Ecto.Schema.t()) :: {:ok, String.t()} | {:error, String.t()}
    def truncate(schema) do
      table_name = schema.__schema__(:source)

      case query("TRUNCATE #{table_name}", []) do
        {:ok, result} -> {:ok, "Command executed #{result.command}"}
        {:error, result} -> {:error, "Command #{result.message}"}
      end
    end
  end
end

defmodule Balance.Repo do
  @moduledoc """
  Allows access to storage repository
  """
  use Ecto.Repo,
    otp_app: :balance,
    adapter: Ecto.Adapters.Postgres

  alias __MODULE__
  alias Balance.Settings

  @doc """
  Returns the list of settings of bonus.

  ## Example

     iex> Repo.list_bonus_settings()
     [%Balance.Settings.Bonus{}]

  """
  def list_bonus_settings do
    Repo.all(Settings.Bonus)
  end

  @doc """
  Creates a Balance.Settings.Bonus.

  ## Examples

     iex> Balance.Repo.create_bonus(%{percent: 0.5, kind: "individual"})
     {:ok, %Balance.Settings.Bonus{}}

     iex> Repo.create_bonus(%{percent: 0.3, kind: "other_data"})
     {:error, %Ecto.Changeset{}}

  """
  def create_bonus(attrs \\ %{}) do
    %Settings.Bonus{}
    |> Settings.Bonus.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a Settings.Bonus.

  ## Examples

     iex> bonus = Repo.get_by(id: 1)
     iex> Repo.update_bonus(bonus, %{percent: 0.4})
     {:ok, %Balance.Settings.Bonus{percent: 0.4}}

     iex> bonus = Repo.get_by(id: 1)
     iex> Repo.update_bonus(bonus, %{percent: -1})
     {:error, %Ecto.Changeset{}}

  """
  def update_bonus(%Settings.Bonus{} = bonus, attrs) do
    bonus
    |> Settings.Bonus.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Bonus setting.

  ## Examples

     iex> bonus = Repo.get_by(id: 1)
     iex> Repo.delete_bonus(bonus)
     {:ok, %Balance.Settings.Bonus{}}

     iex> bonus = Repo.get_by(id: 5)
     iex> Repo.delete_bonus(bonus)
     {:error, %Ecto.Changeset{}}

  """
  def delete_bonus(%Settings.Bonus{} = bonus) do
    Repo.delete(bonus)
  end

  @doc """
  Returns the list of goals settings.

  ## Example

  iex> Repo.list_goals_settings()
  [%Balance.Settings.Goal{}]

  """
  def list_goals_settings do
    Repo.all(Settings.Goal)
  end

  @doc """
  Creates a Balance.Settings.Goal.

  ## Examples

     iex> Repo.create_goal(%{level: "D", goals: 12, team: "juniors"})
     {:ok, %Balance.Settings.Goal{}}

     iex> Repo.create_goal(%{level: 1, goals: 10, team: "team"})
     {:error, %Ecto.Changeset{}}

  """
  def create_goal(attrs \\ %{}) do
    %Settings.Goal{}
    |> Settings.Goal.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a Balance.Settings.Goal.

  ## Examples

     iex> goal = Repo.get_by(id: 1)
     iex> Repo.update_goal(goal, %{level: "A", goals: 12, team: "rojo"})
     {:ok, %Balance.Settings.Goal{}}

     iex> goal = Repo.get_by(id: 1)
     iex> Repo.update_goal(goal, %{level: "X", goals: 19, team: "blanco"})
     {:error, %Ecto.Changeset{}}

  """
  def update_goal(%Settings.Goal{} = goal, attrs) do
    goal
    |> Settings.Goal.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Goal.

  ## Examples

     iex> goal = Repo.get_by(id: 1)
     iex> Repo.delete_goal(goal)
     {:ok, %Balance.Settings.Goal{}}

     iex> goal = Repo.get_by(id: 1)
     iex> Repo.delete_goal(goal)
     {:error, %Ecto.Changeset{}}

  """
  def delete_goal(%Settings.Goal{} = goal) do
    Repo.delete(goal)
  end
end

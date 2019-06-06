defmodule Balance.Repo do
  @moduledoc """
  Allows access to storage repository
  """
  use Ecto.Repo,
    otp_app: :balance,
    adapter: Ecto.Adapters.Postgres

  alias __MODULE__

  @doc """
  Returns the list of settings of bonus.

  ## Example

     iex> Repo.list_bonus_settings()
     [%Settings.Bonus{}]

  """
  def list_bonus_settings do
    Repo.all(Settings.Bonus)
  end

  @doc """
  Creates a Settings.Bonus.

  ## Examples

     iex> Balance.Repo.create_bonus(%{percent: 0.5, kind: "individual"})
     {:ok, %Settings.Bonus{}}

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
     {:ok, %Settings.Bonus{percent: 0.4}}

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
     {:ok, %Settings.Bonus{}}

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
  [%Settings.Goal{}]

  """
  def list_goals_settings do
    Repo.all(Settings.Goal)
  end

  @doc """
  Creates a Settings.Goal.

  ## Examples

     iex> Repo.create_goal(%{level: "D", goals: 12, team: "juniors"})
     {:ok, %Settings.Goal{}}

     iex> Repo.create_goal(%{level: 1, goals: 10, team: "team"})
     {:error, %Ecto.Changeset{}}

  """
  def create_goal(attrs \\ %{}) do
    %Settings.Goal{}
    |> Settings.Goal.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a Settings.Goal.

  ## Examples

     iex> goal = Repo.get_by(id: 1)
     iex> Repo.update_goal(goal, %{level: "A", goals: 12, team: "rojo"})
     {:ok, %Settings.Goal{}}

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
     {:ok, %Settings.Goal{}}

     iex> goal = Repo.get_by(id: 1)
     iex> Repo.delete_goal(goal)
     {:error, %Ecto.Changeset{}}

  """
  def delete_goal(%Settings.Goal{} = goal) do
    Repo.delete(goal)
  end
end

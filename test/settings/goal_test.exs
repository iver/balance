defmodule Balance.GoalTest do
  use ExUnit.Case
  doctest Balance.Goal

  describe "GoalSettings" do
    alias Balance.Goal
    @valid_attrs %{level: "A", goals: 5, team: "all"}
    @valid_attrs_c %{level: "Cuauh", goals: 20, team: "all"}
    @update_attrs %{level: "B", goals: 10, team: "rojo"}
    @invalid_level %{level: "X", goals: 0, team: "all"}
    @invalid_goal %{level: "C", team: "all"}

    def save_goal(attrs, isValid) do
      goal = Goal.changeset(%Goal{}, attrs)
      # require IEx
      # IEx.pry()
      assert goal.valid? == isValid
      Balance.Repo.insert(goal)
    end

    test "Save valid goal" do
      goal = save_goal(@valid_attrs, true)
      assert {:ok, %Goal{}} = goal
    end

    test "Save valid goal for Cuauh" do
      goal = save_goal(@valid_attrs_c, true)
      assert {:ok, %Goal{}} = goal
    end

    test "Save invalid level" do
      goal = save_goal(@invalid_level, false)
      assert {:error, result} = goal
      assert result.errors[:level] == {"invalid level", []}
    end

    test "Save invalid goal" do
      goal = save_goal(@invalid_goal, false)
      assert {:error, result} = goal
      assert result.errors[:goals] == {"can't be blank", [validation: :required]}
    end

    test "Update valid goal" do
      goal = save_goal(@valid_attrs, true)
      assert {:ok, goal2} = goal
      goal2up = Goal.changeset(goal2, @update_attrs)
      assert goal2up.valid? == true
      assert {:ok, result} = Balance.Repo.update(goal2up)
    end
  end
end

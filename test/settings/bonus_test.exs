defmodule Balance.BonusTest do
  use ExUnit.Case
  doctest Balance.Bonus

  describe "BonusSettings" do
    alias Balance.Bonus
    @valid_attrs %{percent: 1, kind: "individual"}
    @update_attrs %{percent: 0.5, kind: "team"}
    @invalid_attrs %{percent: -1, kind: "other kind"}

    def save_bonus(attrs, isValid) do
      bonus = Bonus.changeset(%Bonus{}, attrs)
      assert bonus.valid? == isValid
      Balance.Repo.insert(bonus)
    end

    test "Save valid bonus" do
      bonus = save_bonus(@valid_attrs, true)
      assert {:ok, %Bonus{}} = bonus
    end

    test "Save invalid bonus" do
      bonus = save_bonus(@invalid_attrs, false)
      assert {:error, result} = bonus
      assert result.errors[:kind] == {"invalid kind name", []}
    end

    test "Update valid bonus" do
      bonus = save_bonus(@valid_attrs, true)
      assert {:ok, bonus2} = bonus
      bonus2up = Bonus.changeset(bonus2, @update_attrs)
      assert bonus2up.valid? == true
      assert {:ok, result} = Balance.Repo.update(bonus2up)
    end
  end
end

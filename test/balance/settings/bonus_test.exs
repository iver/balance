defmodule Balance.Settings.BonusTest do
  use ExUnit.Case
  doctest Balance.Settings.Bonus

  describe "changeset/2" do
    alias Balance.Settings.Bonus
    @valid_attrs %{percent: 1, kind: "individual"}
    @update_attrs %{percent: 0.5, kind: "team"}
    @invalid_percent %{percent: -1, kind: "individual"}
    @invalid_kind %{percent: 120, kind: "other kind"}

    setup %{attrs: attrs, valid?: valid?} do
      bonus = Bonus.changeset(%Bonus{}, attrs)
      assert bonus.valid? == valid?
      bonus = Balance.Repo.insert(bonus)
      {:ok, %{bonus: bonus}}
    end

    @tag attrs: @valid_attrs, valid?: true
    test "when data is valid", %{bonus: bonus} do
      assert {:ok, %Bonus{}} = bonus
    end

    @tag attrs: @invalid_kind, valid?: false
    test "Save invalid bonus kind", %{bonus: bonus} do
      assert {:error, result} = bonus
      assert result.errors[:kind] == {"invalid kind name", []}
    end

    @tag attrs: @invalid_percent, valid?: false
    test "Save invalid bonus percent", %{bonus: bonus} do
      assert {:error, result} = bonus

      assert result.errors[:percent] ==
               {"must be greater than %{number}",
                [validation: :number, kind: :greater_than, number: 0]}
    end

    @tag attrs: @valid_attrs, valid?: true
    test "Update valid bonus", %{bonus: bonus} do
      assert {:ok, previous} = bonus
      assert previous.percent == @valid_attrs[:percent]
      assert previous.kind == @valid_attrs[:kind]

      changed = Bonus.changeset(previous, @update_attrs)
      assert changed.valid? == true
      assert {:ok, updated} = Balance.Repo.update(changed)

      assert updated.percent == @update_attrs[:percent]
      assert updated.kind == @update_attrs[:kind]
    end
  end
end

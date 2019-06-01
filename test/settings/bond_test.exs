defmodule Balance.BondTest do
  use ExUnit.Case
  doctest Balance.Bond

  describe "BonusSettings" do
    alias Balance.Bond
    @valid_attrs %{percent: 1, kind: "individual"}
    @update_attrs %{percent: 0.5, kind: "team"}
    @invalid_attrs %{percent: -1, kind: "other kind"}

    test "Save valid bond" do
      bond = Bond.changeset(%Bond{}, @valid_attrs)
      assert bond.valid? == true
      assert {:ok, result} = Balance.Repo.insert(bond)
    end

    test "Update valid bond" do
      bond = Balance.Repo.get_by(Balance.Bond, id: 1)
      assert %Bond{} = bond
      bond2up = Bond.changeset(bond, @update_attrs)
      assert bond2up.valid? == true
      assert {:ok, result} = Balance.Repo.update(bond2up)
    end

    test "Save invalid bond" do
      bond = Bond.changeset(%Bond{}, @invalid_attrs)
      assert bond.valid? == false
      assert {:error, result} = Balance.Repo.insert(bond)
      assert result.errors[:kind] == {"invalid kind name", []}
    end
  end
end

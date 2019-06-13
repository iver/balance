defmodule BonusTest do
  use ExUnit.Case
  doctest Bonus

  describe "Bonus Settings" do
    test "Update settings definitions for bonus" do
      json_bonus = ~s([{"kind": "team","percent": 0.5}, {"kind": "individual", "percent": 0.5}])
      {:ok, bonus_list} = Bonus.update_settings(json_bonus)

      expected = [
        %Balance.Settings.Bonus{kind: "team", percent: 0.5},
        %Balance.Settings.Bonus{kind: "individual", percent: 0.5}
      ]

      assert bonus_list == expected
    end
  end
end

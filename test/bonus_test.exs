defmodule BonusTest do
  use ExUnit.Case
  doctest Bonus

  describe "update_settings/1" do
    test "when json is ok" do
      json_bonus = ~s([{"kind": "team","percent": 0.5}, {"kind": "individual", "percent": 0.5}])
      bonus_list = Bonus.update_settings(json_bonus)

      expected = [
        %{"kind" => "team", "percent" => 0.5},
        %{"kind" => "individual", "percent" => 0.5}
      ]

      assert bonus_list == expected
    end
  end
end

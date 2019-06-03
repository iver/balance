defmodule Json.BonusTest do
  use ExUnit.Case
  doctest Json.Bonus

  describe "Json Bonus" do
    alias Json.Bonus

    @valid_json ~s({"percent": 0.5, "kind": "individual"})

    test "Decode valid json" do
      bonus = Bonus.decode!(@valid_json)
      assert %Settings.Bonus{} = bonus
    end

    test "Encode valid struct" do
      bonus = %Settings.Bonus{percent: 0.3, kind: "team"}
      json = Json.Bonus.encode(bonus)
      assert "{\"percent\":0.3,\"kind\":\"team\"}" == json
    end
  end
end

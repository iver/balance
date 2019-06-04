defmodule Json.BonusTest do
  use ExUnit.Case
  doctest Json.Parser

  describe "Json Bonus" do
    @valid_json ~s({"percent": 0.5, "kind": "individual"})

    test "Decode valid json" do
      bonus = Json.Parser.decode!(@valid_json, %Settings.Bonus{})
      assert %Settings.Bonus{} = bonus
    end

    test "Encode valid struct" do
      bonus = %Settings.Bonus{percent: 0.3, kind: "team"}
      json = Json.Parser.encode(bonus)
      assert "{\"percent\":0.3,\"kind\":\"team\"}" == json
    end
  end
end

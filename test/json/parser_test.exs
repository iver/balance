defmodule Json.ParserTest do
  use ExUnit.Case
  doctest Json.Parser

  describe "Json Bonus" do
    @bonus_json ~s({"percent": 0.5, "kind": "individual"})
    @goal_json ~s({\"level\": \"C\", \"goals\": 15, \"team\": \"all\"})
    alias Balance.Settings.Bonus
    alias Balance.Settings.Goal

    test "Decode valid json to Bonus data type" do
      setting = Json.Parser.decode!(@bonus_json, %Bonus{})
      assert %Bonus{} = setting
      assert setting.percent == 0.5
      assert setting.kind == "individual"
    end

    test "Decode valid json to Goal data type" do
      setting = Json.Parser.decode!(@goal_json, %Goal{})
      assert %Goal{} = setting
      assert setting.level == "C"
      assert setting.goals == 15
      assert setting.team == "all"
    end

    test "Error decoding wrong data" do
      {:error, result} = Json.Parser.decode!(@bonus_json, %{percent: 20, kind: "individual"})
      assert "Decode for value type is not implemented" = result
    end

    test "Encode valid struct" do
      bonus = %Bonus{percent: 0.3, kind: "team"}
      {:ok, json} = Json.Parser.encode(bonus)
      assert "{\"percent\":0.3,\"kind\":\"team\"}" == json
    end
  end
end

defmodule Balance.ParserTest do
  use ExUnit.Case
  doctest Balance.Parser

  alias Balance.Parser
  alias Balance.Settings.Bonus
  alias Balance.Settings.Goal

  describe "decode!/2" do
    @bonus_json ~s({"percent":0.5,"kind":"individual"})
    @goal_json ~s({\"level\": \"C\", \"goals\": 15, \"team\": \"all\"})

    test "Decode valid json to Bonus data type" do
      setting = Parser.decode!(@bonus_json, %Bonus{})
      assert %Bonus{} = setting
      assert setting.percent == 0.5
      assert setting.kind == "individual"
    end

    test "Decode valid json to Goal data type" do
      setting = Parser.decode!(@goal_json, %Goal{})
      assert %Goal{} = setting
      assert setting.level == "C"
      assert setting.goals == 15
      assert setting.team == "all"
    end

    test "Error decoding wrong data" do
      {:error, result} = Parser.decode!(@bonus_json, %{percent: 20, kind: "individual"})
      assert "Decode for value type is not implemented" = result
    end
  end

  describe "decode/1" do
    @tag :latest
    test "Json decode as map" do
      json_string =
        "{\"nombre\":\"Juan Perez\", \"nivel\":\"C\", \"goles\":10, \"sueldo\":50000, \"bono\":25000, \"sueldo_completo\":null, \"equipo\":\"rojo\"}"

      {:ok, result} = Parser.decode(json_string)

      expected = %{
        "bono" => 25_000,
        "equipo" => "rojo",
        "goles" => 10,
        "nivel" => "C",
        "nombre" => "Juan Perez",
        "sueldo" => 50_000,
        "sueldo_completo" => nil
      }

      assert result == expected
    end
  end

  describe "encode/1" do
    test "Encode valid struct" do
      bonus = %Bonus{percent: 0.5, kind: "individual"}
      {:ok, json} = Parser.encode(bonus)
      assert @bonus_json == json
    end
  end
end

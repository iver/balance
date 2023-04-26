defmodule BalanceTest do
  use ExUnit.Case
  doctest Balance

  @one_valid_player [
    %Balance.Models.Player{
      name: "Juanita",
      level: "A",
      goals: 15,
      fixed: 10_000,
      bonus: 5000,
      team: "rojo",
      total: 15_000
    }
  ]
  @two_valid_players [
    %Balance.Models.Player{
      name: "Juan Perez",
      level: "C",
      goals: 10,
      fixed: 50_000,
      bonus: 25_000,
      total: nil,
      team: "rojo"
    },
    %Balance.Models.Player{
      name: "Jelipe",
      level: "A",
      goals: 7,
      fixed: 20_000,
      bonus: 10_000,
      total: nil,
      team: "azul"
    }
  ]

  describe "encode_players/1" do
    test "when data is valid" do
      {:ok, encoded} = Balance.encode_players(@one_valid_player)

      expected =
        "[{\"sueldo_completo\":15000,\"sueldo\":10000,\"nombre\":\"Juanita\",\"nivel\":\"A\",\"goles\":15,\"equipo\":\"rojo\",\"bono\":5000}]"

      assert encoded == expected
    end
  end

  describe "disperse/2" do
    test "when data is valid" do
      settings = Balance.Settings.load()
      totals = [25_700.00, 60_833.33]
      teams = ["rojo", "azul"]
      [first | [last]] = Balance.disperse(@two_valid_players, settings)

      assert first.total in totals
      assert first.team in teams

      assert last.total in totals
      assert last.team in teams
    end
  end

  describe "normalize/1" do
    test "when argument has no errors" do
      assert "is ok" = Balance.normalize({:ok, "is ok"})
    end

    test "when error expected" do
      assert :error_expected = Balance.normalize({:error, :error_expected})
    end

    test "when the result is not expected" do
      assert :nothing = Balance.normalize(:nothing)
    end
  end
end

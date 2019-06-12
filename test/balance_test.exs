defmodule BalanceTest do
  use ExUnit.Case
  doctest Balance

  describe "Balance" do
    test "Test encode players" do
      players = [
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

      {:ok, encoded} = Balance.encode_players(players)

      expected =
        "[{\"sueldo_completo\":15000,\"sueldo\":10000,\"nombre\":\"Juanita\",\"nivel\":\"A\",\"goles\":15,\"equipo\":\"rojo\",\"bono\":5000}]"

      assert encoded == expected
    end
  end
end

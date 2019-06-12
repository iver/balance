defmodule Json.Parser do
  @moduledoc """
  Allows to parse bonus json to struct easily
  """

  @doc """
  Decode json string

  ## Example

  ```elixir

  iex> data = ~s({"nombre":"Juan Perez", "nivel":"C", "goles":10, "sueldo":50000, "bono":25000, "sueldo_completo":null, "equipo":"rojo"})
  iex> Json.Parser.decode(data)
  {:ok,
  %{
  "bono" => 25000,
  "equipo" => "rojo",
  "goles" => 10,
  "nivel" => "C",
  "nombre" => "Juan Perez",
  "sueldo" => 50000,
  "sueldo_completo" => nil
  }}

  ```

  """
  def decode(json) do
    Poison.decode(json)
  end

  @doc """
  Decode JSON to a value, raises an exception on error.

  ## Example

  ```elixir

     iex> Json.Parser.decode!(~s({"percent": 0.5, "kind": "individual"}), %Balance.Settings.Bonus{})
     %Balance.Settings.Bonus{
     id: nil,
     kind: \"individual\",
     percent: 0.5
     }

  ```

  """
  def decode!(params, %_{} = value) do
    Poison.decode!(params, as: value)
  end

  def decode!(_params, _value) do
    {:error, "Decode for value type is not implemented"}
  end

  @doc """
  Encode a value to JSON, raises an exception on error.

  ## Example

  ```elixir

  iex> expected = ~s([{"percent":0.5,"kind":"team"},{"percent":0.5,"kind":"individual"}])
  iex> bonus = [%Balance.Settings.Bonus{kind: "team", percent: 0.5},%Balance.Settings.Bonus{kind: "individual",percent: 0.5}]
  iex> {:ok, result} = Json.Parser.encode(bonus)
  iex> expected == result
  true

  ```

  """
  def encode(bonus) do
    bonus
    |> Poison.encode(Map.new([]))
  end
end

defmodule Json.Parser do
  @moduledoc """
  Allows to parse bonus json to struct easily
  """

  @doc """
  Decode a model list
  """
  @spec decode([%{}], %{}) :: %{}
  def decode(list, value) when is_list(list) do
    Enum.reduce(list, [], fn item, acc ->
      [
        Json.Parser.decode!(item, value) | acc
      ]
    end)
  end

  @doc """
  Decode json string

  ## Example

  ```elixir

  iex> Json.Parser.decode("{\"nombre\":\"Juan Perez\", \"nivel\":\"C\", \"goles\":10, \"sueldo\":50000, \"bono\":25000, \"sueldo_completo\":null, \"equipo\":\"rojo\"}")
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

  """
  def encode(bonus) do
    bonus
    |> Poison.encode(Map.new([]))
  end
end

defmodule Balance.Parser do
  @moduledoc """
  Contiene funciones que encapsulan el uso de Poison
  para analizar una structura y convertir a JSON y viceversa.
  """

  @doc """
  Obtiene una estructura a partir de una cadena JSON

  ## Ejemplo:

  ```elixir

  iex> data = ~s({"nombre":"Juan Perez", "nivel":"C", "goles":10, "sueldo":50000, "bono":25000, "sueldo_completo":null, "equipo":"rojo"})
  iex> Balance.Parser.decode(data)
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
  Convierte un JSON a una estructura, en caso de error
  lanzará una excepción.

  ## Ejemplo:

  ```elixir

     iex> Balance.Parser.decode!(~s({"percent": 0.5, "kind": "individual"}), %Balance.Settings.Bonus{})
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
  Genera un JSON a partir del parámetro recibido.

  ## Ejemplo:

  ```elixir

  iex> expected = ~s([{"percent":0.5,"kind":"team"},{"percent":0.5,"kind":"individual"}])
  iex> bonus = [%Balance.Settings.Bonus{kind: "team", percent: 0.5},%Balance.Settings.Bonus{kind: "individual",percent: 0.5}]
  iex> {:ok, result} = Balance.Parser.encode(bonus)
  iex> expected == result
  true

  ```

  """
  def encode(bonus) do
    bonus
    |> Poison.encode(Map.new([]))
  end
end

defmodule Json.Parser do
  @moduledoc """
  Allows to parse bonus json to struct easily
  """

  @doc """
  Decode JSON to a value, raises an exception on error.

  ## Example

     iex> Json.Parser.decode!(~s({"percent": 0.5, "kind": "individual"}), %Balance.Settings.Bonus{})
     %Balance.Settings.Bonus{
     id: nil,
     kind: \"individual\",
     percent: 0.5
     }

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

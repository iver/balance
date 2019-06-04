defmodule Json.Parser do
  @moduledoc """
  Allows to parse bonus json to struct easily
  """

  @doc """
  Decode JSON to a value, raises an exception on error.

  ## Example

     iex> Json.Parser.decode!(~s({"percent": 0.5, "kind": "individual"}), %Settings.Bonus{})
     %Settings.Bonus{
     id: nil,
     kind: \"individual\",
     percent: 0.5
     }

  """
  def decode!(params, %_{} = value) do
    Poison.decode!(params, as: value)
  end

  @doc """
  Encode a value to JSON, raises an exception on error.

  """
  def encode(bonus) do
    bonus
    |> Poison.Encoder.encode(Map.new([]))
    |> IO.iodata_to_binary()
  end
end

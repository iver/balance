defmodule Json.Bonus do
  @moduledoc """
  Allows to parse bonus json to struct easily
  """

  @derive [Poison.Encoder]
  defstruct [:percent, :kind]

  @doc """
  Decode JSON to a value, raises an exception on error.

  ## Example

     iex> Json.Bonus.decode!(~s({"percent": 0.5, "kind": "individual"}))
     %Settings.Bonus{
     id: nil,
     kind: \"individual\",
     percent: 0.5
     }

  """
  def decode!(params) do
    Poison.decode!(params, as: %Settings.Bonus{})
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

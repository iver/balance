defprotocol Counter do
  @doc """
  Returns the total sum as integer using the String.t() as parameter
  """

  @type t :: __MODULE__

  @spec sum(%{}, number, String.t()) :: number
  def sum(struct, acc, team)
end

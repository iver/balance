defprotocol Counter do
  @doc """
  Returns the total sum as integer using the String.t() as parameter
  """
  @spec sum(%{}, number, String.t()) :: number
  def sum(struct, acc, team)
end

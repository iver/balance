defprotocol Counter do
  @doc """
  Returns the total sum as integer using the String.t() as parameter
  """
  @spec sum(%{}, integer, String.t()) :: integer
  def sum(struct, acc, team)
end

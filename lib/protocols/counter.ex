defprotocol Counter do
  @doc """
  Returns the total sum as integer using the String.t() as parameter
  """
  def sum(struct, acc, team)
end

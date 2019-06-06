defprotocol Salary do
  @doc """
  Returns the salary as float using the %Settings.Bonus{} as parameter
  """
  def salary(player, bonus_settings)
end

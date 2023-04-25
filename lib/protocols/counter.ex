defprotocol Counter do
  @doc """
  Protocolo que contiene la función a implementar para poder extraer
  la sumatoría de los miembros de un mapa.
  """

  @type t :: __MODULE__

  @spec sum(map(), number(), String.t()) :: number()
  def sum(struct, acc, team)
end

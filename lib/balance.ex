defmodule Balance do
  @moduledoc """
  Módulo encargado de calcular el ingreso de los jugadores

  # EL RETO

  ## Problema

  El sueldo de los jugadores de un equipo Patito SA de CV se compone de dos partes **un sueldo fijo** y **un bono variable**, la suma de estas dos partes es el sueldo de un jugador. El bono variable se compone de dos partes **meta de goles individual** y **meta de goles por equipo** cada una tiene un peso de 50%.

  El programa deberá hacer el cálculo del sueldo de los jugadores del equipo.

  ### ¿Cómo se calculan los alcances de meta y bonos?

  La meta individual de goles por jugador depende del nivel que tenga asignado:

  | Nivel |Goles/mes|
  | ------------- |:-------------:|
  |A |5|
  |B |10|
  |C |15|
  |Cuauh |20|

  Ejemplo:
  Los jugadores Juan, Pedro, Martín y Luis anotaron así durante el mes:

  | Jugador | Nivel |Goles anotados en el mes/mínimo requerido|
  | ------------- |:-------------:| :-----------: |
  |Juan | A |6/5|
  |Pedro | B |7/10|
  |Martín |C |16/15|
  |Luis | Cuauh |19/20|
  |  | | |
  | total |  |48/50|

  En el bono por equipo tendrían un alcance de 96%
  Luis tendría un alcance individual de 95% para un alcance total de 95.5%
  El suelo fijo de Luis es de 50,000.00 y su bono es de 10,000.00 por lo que su sueldo final será $59,550.00

  ## Entradas

  El programa deberá recibir como entrada un JSON con al siguiente estructura:

  ```json
  [
   {
      "nombre":"Juan Perez",
      "nivel":"C",
      "goles":10,
      "sueldo":50000,
      "bono":25000,
      "sueldo_completo":null,
      "equipo":"rojo"
   },
   {
      "nombre":"EL Cuauh",
      "nivel":"Cuauh",
      "goles":30,
      "sueldo":100000,
      "bono":30000,
      "sueldo_completo":null,
      "equipo":"azul"
   },
   {
      "nombre":"Cosme Fulanito",
      "nivel":"A",
      "goles":7,
      "sueldo":20000,
      "bono":10000,
      "sueldo_completo":null,
      "equipo":"azul"

   },
   {
      "nombre":"El Rulo",
      "nivel":"B",
      "goles":9,
      "sueldo":30000,
      "bono":15000,
      "sueldo_completo":null,
      "equipo":"rojo"

   }
  ]
  ```

  ## Salidas

  En la respuesta se deberá añadir la llave `sueldo_completo` con el monto correcto de cada jugador.

  ```json
  [
   {
      "nombre":"El Rulo",
      "goles_minimos":10,
      "goles":9,
      "sueldo":30000,
      "bono":15000,
      "sueldo_completo": 14250,
      "equipo":"rojo"
   }
  ]
  ```

  ## Bonus

  Además de calcular el sueldo de los jugadores del equipo, el programa puede calcular el sueldo de los jugadores de otros equipos con distintos mínimos por nivel. El programa deberá recibir como entrada un solo JSON con el arreglo de equipos.

  """
  require Logger

  alias Balance.Models.Player
  alias Balance.Parser
  alias Balance.Salary
  alias Balance.Settings

  @doc """
  Lee un archivo en formato JSON y regresa una lista de jugadores
  """
  def read_file(filename) do
    with {:ok, body} <- File.read(filename),
         {:ok, players} <- Team.extract(body) do
      players
    else
      :error -> {:error, "The #{filename} couldn't parse"}
    end
  end

  @doc """
  Regresa una lista de jugadores con el salario total calculado
  """
  @spec disperse([Player.t()], Settings.t()) :: [Player.t()]
  def disperse(players, settings) do
    Enum.reduce(players, [], fn player, acc ->
      player = Salary.calculate(players, player, settings)
      Logger.debug("Player: #{inspect(player)}")
      [player | acc]
    end)
  end

  @doc """
  Prepara la lista de los jugadores para exportar como cadena.

  """
  def encode_players(players) do
    case Team.export(players) do
      {:ok, players} ->
        Parser.encode(players)

      {:error, data} ->
        Logger.debug("ERROR: updating players #{inspect(data)}")
        {:error, data}
    end
  end

  @doc """
  Guarda la información de los jugadores en un archivo llamado players.json
  """
  @spec save({:ok, map()} | any()) :: :ok | {:error, File.posix()} | any()
  def save({:ok, players}) do
    File.write("players.json", players, [:binary])
  end

  def save(data) do
    Logger.debug("Save any data -> #{inspect(data)}")
    data
  end

  @doc """
  Extrae el resultado y define si existe un error:

  ## Ejemplo:

  ```elixir

  iex> {:error, info} = {:error, "Error value"}
  iex> Balance.normalize({:error, info})
  "Error value"

  ```
  """
  def normalize({:ok, players}), do: players

  def normalize({:error, error_info}) do
    Logger.debug("#{inspect(error_info)}")
    error_info
  end

  def normalize(data) do
    Logger.debug("#{inspect(data)}")
    data
  end
end

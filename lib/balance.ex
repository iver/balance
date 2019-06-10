defmodule Balance do
  @moduledoc """
  Module responsible for calculating players' income at resuelve.

  # The Challengue

  ## Problema

  El sueldo de los jugadores del Resuelve FC se compone de dos partes **un sueldo fijo** y **un bono variable**, la suma de estas dos partes es el sueldo de un jugador. El bono variable se compone de dos partes **meta de goles individual** y **meta de goles por equipo** cada una tiene un peso de 50%.

  Tu programa deberá hacer el cálculo del sueldo de los jugadores del Resuelve FC.

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

  ## La prueba

  Tu programa deberá recibir como input un JSON con esta estructura:

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


  En la respuesta deberás llenar la llave `sueldo_completo` con el monto correcto de cada jugador.

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
  Además de calcular el sueldo de los jugadores del Resuelve FC, tu programa puede calcular el sueldo de los jugadores de otros equipos con distintos mínimos por nivel. Tu programa deberá recibir como input un solo JSON con el arreglo de equipos.

  """
  alias Balance.Models.Player
  require Logger


  @doc """
  Read a file in json format and return a list of players
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
  Return a list of players with the total salary calculated
  """
  @spec disperse([%Player{}], Balance.Settings.t()) :: [%Player{}]
  def disperse(players, settings) do
    Enum.reduce(players, [], fn player, acc ->
      player = Balance.Salary.calculate(players, player, settings)
      Logger.debug("Player: #{inspect(player)}")
      [player | acc]
    end)
  end

  def save(result) do
    case result do
      {:ok, players} -> 
        case Json.Parser.encode(players) do
          {:ok, result} ->
            File.write("players.json", result , [:binary])
          {:error, result} ->
            {:error, result}
        end
      {:error, data} ->
        {:error, data}
    end
  end

end

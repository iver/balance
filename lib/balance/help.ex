defmodule Balance.Help do
  @moduledoc """
  Muestra la información al usuario.
  Imprime en pantalla como puede usarse el programa en la línea de comandos.
  """

  def show do
    """
    NOMBRE
    \t Balance -- CLI para el cálculo de salarios\n
    SINOPSIS
    \t balance [--file(default)] <archivo-a-analizar>\n
    """
    |> author()
    |> description()
    |> file()
    |> text()
    |> help()
    |> version()
    |> info()
  end

  defp author(data) do
    """
    #{data}
    AUTHOR
    \t Iván Jaimes
    \t ivan@iver.mx\n
    """
  end

  defp description(data) do
    """
    #{data}
    DESCRIPCION
    \t Realiza el cálculo de salarios del problema planteado en el archivo README.md.\n
    OPCIONES
    """
  end

  defp file(data) do
    """
    #{data}
    \t -f | --file <file_json> \tParse json file named <file_json>.
    """
  end

  defp text(data) do
    """
    #{data}
    \t -t | --text <text_json> \tParse json text.
    """
  end

  defp help(data) do
    """
    #{data}
    \t -h | --help \t\t\tShows the help.
    """
  end

  defp version(data) do
    """
    #{data}
    \t -v | --version \t\tShows the gcli version.
    """
  end

  defp info(data) do
    IO.puts(data)
  end
end

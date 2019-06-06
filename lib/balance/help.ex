defmodule Balance.Help do
  @moduledoc """
  Expose information to the user.
  Print on the screen how can we use the cli.
  """

  def use() do
    IO.puts("NAME")
    IO.puts("\t Balance -- Resuelve balance command line interface\n")
    IO.puts("SYNOPSIS")
    IO.puts("\t balance [--file(default)] <file to parse>\n")
    author()
    description()
    file()
    help()
    version()
  end

  defp description() do
    IO.puts("DESCRIPTION")
    IO.puts("\t Calculate Resuelve FC players' salary.\n
    ")
    IO.puts("OPTIONS")
  end

  defp file() do
    IO.puts("\t -f | --file <file_json> \t\tParse json file named <file_json>.")
  end

  defp help() do
    IO.puts("\t -h | --help \t\tShows the help.")
  end

  defp version() do
    IO.puts("\t -v | --version \tShows the gcli version.")
  end

  defp author() do
    IO.puts("AUTHOR")
    IO.puts("\t Iván Jaimes")
    IO.puts("\t ivan@iver.mx\n")
  end
end

defmodule Screen do
  @moduledoc """
  Tiene la responsabilidad de mostrar las opciones disponibles
  y redireccionar las acciones a realizar por cada una.
  """

  require Logger

  def main(args \\ []) do
    args
    |> parse_args()
    |> process()
    |> info()
  end

  defp parse_args(args) do
    switches = [file: :string, text: :string, bonus: :string, help: :boolean, version: :boolean]
    aliases = [f: :file, t: :text, b: :bonus, h: :help, v: :version]

    OptionParser.parse(args, switches: switches, aliases: aliases)
  end

  defp process({switches, args, invalid}) do
    if is_nil(invalid) == false && length(invalid) > 0 do
      # @TODO: Use args and invalid data if required
      info("Ivalid args: #{inspect(invalid)} -> args: #{inspect(args)}")
    end

    Enum.each(switches, fn switch -> App.run(switch) end)

    if Enum.empty?(switches) do
      error("balance: Ilegal option.\n")
      Balance.Help.show()
    end
  end

  defp info(data) do
    IO.puts(data)
  end

  defp error(data) do
    IO.warn(data)
  end
end

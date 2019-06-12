defmodule Screen do
  @moduledoc """
  Screen module has the responsability to show options and define actions for each one
  """

  require Logger

  def main(args \\ []) do
    args
    |> parse_args()
    |> process()
    |> IO.puts()
  end

  defp parse_args(args) do
    switches = [file: :string, text: :string, bonus: :string, help: :boolean, version: :boolean]
    aliases = [f: :file, t: :text, b: :bonus, h: :help, v: :version]

    OptionParser.parse(args, switches: switches, aliases: aliases)
  end

  defp process({switches, args, invalid}) do
    if is_nil(invalid) == false && length(invalid) > 0 do
      # TODO: Use args and invalid data if required
      Logger.info("Ivalid args: #{inspect(invalid)} -> args: #{inspect(args)}")
    end

    Enum.each(switches, fn switch -> App.run(switch) end)

    if Enum.empty?(switches) do
      IO.puts("balance: Ilegal option.\n")
      Balance.Help.use()
    end
  end
end

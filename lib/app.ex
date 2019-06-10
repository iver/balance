defmodule App do
  def run({:version, true}) do
    v =
      case File.read("assets/version") do
        {:ok, content} ->
          list = String.split(content, "\n")
          hd(list)

        {:error, _reason} ->
          "0.0.1"
      end

    IO.puts("Balance version: #{v}")
  end

  def run({:file, filename}) do
    settings = Balance.Settings.load()

    filename
    |> Balance.read_file()
    |> Balance.disperse(settings)
    |> Team.export()
    |> Balance.save()
    |> IO.puts()
  end

  def run({:text, data}) do
    IO.puts("Not implemented yet! ... file: #{data}")
  end

  def run({:help, true}) do
    Balance.Help.use()
  end
end

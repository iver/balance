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
    |> Balance.encode_players()
    |> Balance.save()
    |> Balance.normalize()
    |> IO.puts()
  end

  def run({:text, data}) do
    IO.puts("\nResult: \n\t")
    settings = Balance.Settings.load()

    case Team.extract(data) do
      {:ok, players} ->
        players
        |> Balance.disperse(settings)
        |> Balance.encode_players()
        |> Balance.normalize()
        |> IO.puts()

      :error ->
        {:error, "The text couldn't parse"}
    end
  end

  def run({:help, true}) do
    Balance.Help.use()
  end
end

defmodule App do
  @moduledoc """
  Contiene funciones que regresan información relacionada a la aplicación
  """

  alias Balance.Settings

  def run({:version, true}) do
    v =
      case File.read("assets/version") do
        {:ok, content} ->
          list = String.split(content, "\n")
          hd(list)

        {:error, _reason} ->
          Application.spec(:balance)[:vsn]
      end

    print("Balance version: #{v}")
  end

  def run({:file, filename}) do
    settings = Settings.load()

    filename
    |> Balance.read_file()
    |> Balance.disperse(settings)
    |> Balance.encode_players()
    |> Balance.save()
    |> Balance.normalize()
    |> print()
  end

  def run({:text, data}) do
    print("\nResult: \n\t")
    settings = Settings.load()

    case Team.extract(data) do
      {:ok, players} ->
        players
        |> Balance.disperse(settings)
        |> Balance.encode_players()
        |> Balance.normalize()
        |> print()

      :error ->
        {:error, "The text couldn't parse"}
    end
  end

  def run({:bonus, data}) do
    print("\nSaving bonus settings:\n")

    data
    |> Bonus.update_settings()
    |> print()
  end

  def run({:help, true}) do
    Balance.Help.show()
  end

  defp print(message) do
    IO.puts(message)
  end
end

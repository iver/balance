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
    IO.puts("Not implemented yet! ... file: #{filename}")
  end

  def run({:help, true}) do
    Balance.Help.use()
  end
end

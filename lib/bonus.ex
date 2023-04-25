defmodule Bonus do
  @moduledoc """
  Contiene funciones relacionadas al cálculo de bonificaciones.
  """

  alias Balance.Settings.Bonus

  @doc """
  Devuelve la configuración de bonificación definida para uso del equipo

  ## Ejemplo

  ```elixir

     iex> settings = [%Balance.Settings.Bonus{kind: "team", percent: 0.5},%Balance.Settings.Bonus{kind: "individual",percent: 1.0}]
     iex> Bonus.percentage(settings)
     %{percent: %{individual: 1.0, team: 0.5}}

  ```

  """
  @spec percentage([Bonus.t()]) :: %{}
  def percentage(bonus_settings) do
    team = Enum.find(bonus_settings, fn bonus -> bonus.kind == "team" end)
    individual = Enum.find(bonus_settings, fn bonus -> bonus.kind == "individual" end)
    %{percent: %{individual: individual.percent, team: team.percent}}
  end

  @doc """
  Calcula la bonificación individual y por equipo.

  ## Ejemplo

   ```elixir

     iex> Bonus.amount(%{percent: %{individual: 0.6, team: 0.4}}, 5000)
     %{amount: %{individual: 3000.00, team: 2000.00 }}

   ```
  """
  def amount(%{percent: percent}, total_bonus) do
    individual = percent.individual * total_bonus
    team = percent.team * total_bonus

    %{
      amount: %{
        individual: individual,
        team: team
      }
    }
  end

  def update_settings(settings) do
    require Logger

    case Json.Parser.decode(settings) do
      {:ok, list} ->
        # Enum.each(list, fn item ->
        #   Logger.info("Data: #{inspect(item)} \n")
        # end)

        list

      # case Balance.Repo.create_bonus(bonus) do
      #   {:ok, bonus} -> bonus
      #   {:error, error} -> error
      # end

      {:error, error_info} ->
        error_info
    end
  end
end

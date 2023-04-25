defmodule Balance.Application do
  # Ver https://hexdocs.pm/elixir/Application.html
  # para más información sobre OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # Lista de los procesos hijos a supervisar
    children = [
      # Para iniciar un trabajador (worker), de la misma forma
      # que se haría con Balance.Worker.start_link(arg)
      # {Balance.Worker, arg}
      Balance.Repo
    ]

    # Ver https://hexdocs.pm/elixir/Supervisor.html
    # para otro tipo de estrategias y opciones soportadas
    opts = [strategy: :one_for_one, name: Balance.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

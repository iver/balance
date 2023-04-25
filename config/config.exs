# Este archivo es responsable de configurar la aplicación y
# las dependencias con la ayuda del módulo `Mix.Config`.
import Config

config :balance,
  ecto_repos: [Balance.Repo]

# Esta configuración se carga antes que cualquier dependencia y está restringida
# a este proyecto. Si otro proyecto depende de este proyecto,
# este archivo no se cargará ni afectará al proyecto principal. Por esta razón,
# si desea proporcionar valores predeterminados para su aplicación para
# usuarios de terceros, debe hacerse en su archivo "mix.exs".

# Se puede configurar la aplicación como:
#
#     config :balance, key: :value
#
# y acceder a esta configuración en la aplicación como:
#
#     Aplicación.get_env(:balance, :key)
#
# También se puede configurar una aplicación de terceros:
#
#     config :logger, level: :info
#

# También es posible importar archivos de configuración, relativos a este
# directorio. Por ejemplo, se puede emular la configuración por entorno
# descomentando la línea de abajo y definiendo dev.exs, test.exs y demás.
# La configuración del archivo importado anulará las definidas
# aquí (razón por la cual es importante importarlos al final).

import_config "#{Mix.env()}.exs"

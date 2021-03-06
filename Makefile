SHELL := /bin/bash
ACTUAL := $(shell pwd)
MIX_ENV=dev

export MIX_ENV
export ACTUAL

help:
	@echo -e "Ejercicio de Resuelve. \n\nComandos disponibles:"
	@echo -e "\tmake install\t Instala el proyecto"
	@echo -e "\tmake init\t inicializa la base de datos"
	@echo -e "\tmake debug\t Ejecuta el proyecto en modo debug"
	@echo -e "\tmake compile\t Compila el proyecto"
	@echo -e "\tmake test\t Ejecuta las pruebas del proyecto"
	@echo -e "\tmake release\t Compila el proyecto y genera el paquete a subir al servidor"
	@echo -e "\tmake deploy\t Despliega el paquete generado en el servidor"
	@echo -e "\tmake clean\t Elimina los archivos generados por la compilación"

install:
	./bash/install.sh

get:
	mix local.hex --force;
	mix local.rebar --force;
	mix deps.get;
	mix deps.compile;

init: get
	mix ecto.setup

debug:
	iex -S mix

doc: compile
	mix docs
	tar -zcf docs.tar.gz doc/

test: MIX_ENV=test
test: init
	mix test --trace --exclude lib/balance/repo.ex
	mix coveralls

compile: clean get
	mix compile
	mix docs
	tar -zcf docs.tar.gz doc/

release: MIX_ENV=prod
release: compile
	mix escript.build

deploy:
	@echo "Not implemented yet!"

clean:
	mix clean
	mix deps.clean --all
	rm -rf doc/ docs.tar.gz balance


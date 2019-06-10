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
	@echo "Not implemented yet!"

init:
	mix ecto.reset

debug:
	iex -S mix

doc: compile
	mix docs
	tar -zcf docs.tar.gz doc/

test: MIX_ENV=test
test: init
	mix test

compile: clean
	mix deps.get
	mix deps.compile
	mix compile
	mix docs
	tar -zcf docs.tar.gz doc/

release: MIX_ENV=prod
release: compile
	@echo "Not implemented yet!"

deploy:
	@echo "Not implemented yet!"

clean:
	mix clean
	mix deps.clean --all
	rm -rf doc/ docs.tar.gz


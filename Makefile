SHELL = /bin/bash

default:
	@printf "Please run the make command alongside the rule that is intended to be run!\n"
	@printf "Usage: \`make [venv-|dock-]"
	@printf "<"
	@printf "build|run|clean"
	@printf ">"
	@printf "\`\n"
	@printf "For further information, please check out the documentation.\n"

build: clean build-pip
	@printf "Copying the files to the product/ folder..."
	@test -d product || mkdir product
	@test -d product/static || mkdir product/static
	@test -d product/static/styles || mkdir product/static/styles
	@test -d product/templates || mkdir product/templates
	@cp AI/ai.py product/ai.py
	@cp GUI/templates/index.html product/templates/index.html
	@cp GUI/templates/answer.html product/templates/answer.html
	@cp GUI/static/styles/style-index.css product/static/styles/style-index.css
	@cp GUI/static/styles/style-answer.css product/static/styles/style-answer.css
	@cp server/flask_server.py product/flask_server.py
	@printf " OK\n"
	@printf "You can now start the server by running \`make run\`.\n"

build-pip:
	@printf "Installing the pip packages (verbosely)...\n"
	pip3 install bs4==0.0.1
	pip3 install flask==2.2.2
	pip3 install google==3.0.0
	pip3 install rich==12.6.0
	pip3 install tensorflow==2.11.0
	pip3 install transformers==4.25.1
	pip3 install waitress==2.1.2
	@printf "\n\nAll the packages have been installed successfully!\n"

run:
	@printf "Starting the server...\n"
	@cd product
	@python3 product/flask_server.py

run-here:
	@printf "Starting the server...\n"
	@python3 flask_server.py

clean:
	@printf "Removing the product/ folder if it exists..."
	@rm -rf product
	@printf " OK\n"

venv-build: venv-clean
	@printf "Creating the venv..."
	@python3 -m venv venv-product
	@printf " OK\n"
	@printf "Copying the files to the venv-product/ folder..."
	@test -d venv-product/static || mkdir venv-product/static
	@test -d venv-product/static/styles || mkdir venv-product/static/styles
	@test -d venv-product/templates || mkdir venv-product/templates
	@cp AI/ai.py venv-product/ai.py
	@cp GUI/templates/index.html venv-product/templates/index.html
	@cp GUI/templates/answer.html venv-product/templates/answer.html
	@cp GUI/static/styles/style-index.css venv-product/static/styles/style-index.css
	@cp GUI/static/styles/style-answer.css venv-product/static/styles/style-answer.css
	@cp server/flask_server.py venv-product/flask_server.py
	@printf " OK\n"
	@printf "Activating venv and installing pip packages (this might take a while)..."
	@. ./venv-product/bin/activate; \
		pip3 install bs4==0.0.1; \
		pip3 install flask==2.2.2; \
		pip3 install google==3.0.0; \
		pip3 install rich==12.6.0; \
		pip3 install tensorflow==2.11.0; \
		pip3 install transformers==4.25.1; \
		pip3 install waitress==2.1.2
	@printf "\n\nEverything was setup successfully!\n"
	@printf "You can now start the server by running \`make venv-run\`.\n"

venv-run:
	@printf "Starting the venv server...\n"
	@cd product
	@. ./venv-product/bin/activate; python3 ./venv-product/flask_server.py

venv-clean:
	@printf "Removing the venv-product/ folder if it exists..."
	@rm -rf venv-product
	@printf " OK\n"

docker-build: docker-clean
	@printf "Copying the files to the docker-product/ folder..."
	@test -d docker-product/static || mkdir docker-product/static
	@test -d docker-product/static/styles || mkdir docker-product/static/styles
	@test -d docker-product/templates || mkdir docker-product/templates
	@cp AI/ai.py docker-product/ai.py
	@cp GUI/templates/index.html docker-product/templates/index.html
	@cp GUI/templates/answer.html docker-product/templates/answer.html
	@cp GUI/static/styles/style-index.css docker-product/static/styles/style-index.css
	@cp GUI/static/styles/style-answer.css docker-product/static/styles/style-answer.css
	@cp server/flask_server.py docker-product/flask_server.py
	@cp Makefile docker-product/Makefile
	@printf " OK\n"
	@printf "Building using docker (this might take a while)..."
	@docker build -t w1bb/ia4:1.0 docker-product
	@printf "\n\nEverything was setup successfully!\n"
	@printf "You can now start the server by running \`make docker-run\`.\n"

docker-clean:
	@printf "Killing all docker containers..."
	@docker kill $(shell docker ps -q)
	@printf " OK\n"
	@printf "Removing the docker-product/ folder content if it exists..."
	@rm -rf docker-product/static
	@rm -rf docker-product/templates
	@rm -rf docker-product/*.py
	@rm -rf docker-product/Makefile
	@printf " OK\n"

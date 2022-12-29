SHELL = /bin/bash

default:
	@printf "Please run the make command alongside the rule that is intended to be run!\n"
	@printf "Usage: \`make [venv-|dock-]"
	@printf "<"
	@printf "build|run|clean"
	@printf ">"
	@printf "\`\n"
	@printf "For further information, please check out the documentation.\n"

build: clean
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
	@printf "Installing the pip packages (verbosely)...\n"
	pip install bs4
	pip install flask
	pip install google
	pip install rich
	pip install tensorflow
	pip install transformers
	pip install waitress
	@printf "\n\nAll the packages have been installed successfully!\n"
	@printf "You can now start the server by running \`make run\`.\n"

run:
	@printf "Starting the server...\n"
	@cd product
	@python3 product/flask_server.py

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
		pip install bs4; \
		pip install flask; \
		pip install google; \
		pip install rich; \
		pip install tensorflow; \
		pip install transformers; \
		pip install waitress; \
		pip install datasets
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

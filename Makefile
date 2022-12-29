default:
	@printf "Please run the make command alongside the rule that is intended to be run!\n"
	@printf "Usage: \`make"
	@printf "<"
	@printf "build|run|debug|clean"
	@printf ">"
	@printf "\`\n"
	@printf "For further information, please check out the documentation.\n"

build: clean
	@printf "Copying the files to the product folder..."
	@mkdir product
	@mkdir product/static
	@mkdir product/static/styles
	@mkdir product/templates
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
	pip install googlesearch-python
	pip install rich
	pip install tensorflow
	pip install transformers
	pip install waitress
	@printf "\n\nAll the packages have been installed successfully!\n"
	@printf "You can now run \`make "
	@printf "<"
	@printf "run|debug"
	@printf ">"
	@printf "\`.\n"

run:
	@printf "Starting the server...\n"
	@cd product
	python3 product/flask_server.py

clean:
	@printf "Removing the product folder if it exists..."
	@rm -rf product
	@printf " OK\n"
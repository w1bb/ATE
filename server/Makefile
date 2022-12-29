default:
	@printf "Please run the make command alongside the rule that is intended to be run!\n"
	@printf "Usage: \`make"
	@printf "<"
	@printf "build|clean"
	@printf ">"
	@printf "\`\n"
	@printf "For further information, please check out the documentation.\n"

build: clean
	@printf "Copying the files to the server folder..."
	@mkdir static
	@mkdir static/styles
	@mkdir templates
	@cp ../AI/ai.py ai.py
	@cp ../GUI/templates/index.html templates/index.html
	@cp ../GUI/templates/answer.html templates/answer.html
	@cp ../GUI/static/styles/style-index.css static/styles/style-index.css
	@cp ../GUI/static/styles/style-answer.css static/styles/style-answer.css
	@printf " OK\n"

clean:
	@printf "Removing the product folder if it exists..."
	@rm -rf __pycache__
	@rm -rf templates
	@rm -rf static
	@rm -rf ai.py
	@printf " OK\n"

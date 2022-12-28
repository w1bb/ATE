#Package import
from flask import Flask, render_template, request
from waitress import serve
import ai

#initialise app
app = Flask(__name__)

#decorator for homepage 
@app.route('/')
def index():
	return render_template('index.html', PageTitle = "Landing page")


#This function will run when POST method is used.
@app.route('/', methods = ['POST'] )
def parse_request():
    #getting question from form
    question = request.form.get('question')

    
    #making sure its not empty
    if question != '':
        # TODO: generate answer
        answer = ai.ask_question(question)
        
        return render_template('raspuns.html', answer = answer, question = question)

    else:
        return render_template('index.html', PageTitle = "Landing page")
        #This just reloads the page if question is given and the user tries to POST. 


if __name__ == '__main__':
	serve(app, host = "0.0.0.0", port = 8080)

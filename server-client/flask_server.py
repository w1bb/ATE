#Package import
from flask import Flask, render_template, send_file, make_response, url_for, Response, redirect, request 
 
#initialise app
app = Flask(__name__)

#decorator for homepage 
@app.route('/')
def index():
	return render_template('index.html', PageTitle = "Landing page")

if __name__ == '__main__':
	app.run(debug = True)


#These functions will run when POST method is used.
@app.route('/', methods = ["POST"] )
def parse_request():
    #gathering file from form
    question = request.form.get('question')
    
    
    #making sure its not empty
    if question != '':
        print(question)
        processed_text = question.upper()
        return processed_text
        
    
    else:
        return render_template('index.html', PageTitle = "Landing page")
      #This just reloads the page if no file is selected and the user tries to POST. 
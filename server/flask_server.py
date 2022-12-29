# ------------------------------------------------------------------------------

#                            ========================
#                            ===  LICENSE NOTICE  ===
#                            ========================

# This code is provided under the MIT license.

# Copyright (c) 2022 Maria-Miruna ALDICA,
#                    Matei-Ștefan IONESCU,
#                    Valentin-Ioan VINTILĂ.

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# ------------------------------------------------------------------------------

#                          ============================
#                          ===  The actual program  ===
#                          ============================

# Package import
from inspect import getsourcefile
from os.path import abspath
this_folder = abspath(getsourcefile(lambda:0))
this_folder = this_folder[:len(this_folder) - this_folder[::-1].index('/')]

from flask import Flask, render_template, request
from waitress import serve
exec(open(this_folder + "ai.py").read())

# initialise app
app = Flask(__name__)

# decorator for homepage 
@app.route('/')
def index():
	return render_template('index.html', PageTitle = "Landing page")


# This function will run when POST method is used.
@app.route('/', methods = ['POST'] )
def parse_request():
    # getting question from form
    question = request.form.get('question')

    
    # making sure its not empty
    if question != '':
        # generate answer
        answer = ask_question(question)
        
        return render_template('answer.html', answer = answer, question = question)

    else:
        return render_template('index.html', PageTitle = "Landing page")
        # This just reloads the page if question is given and the user tries to POST. 


if __name__ == '__main__':
	serve(app, host = "0.0.0.0", port = 8080)

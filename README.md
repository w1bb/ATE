# IA4-Project

This code is intended to store a client-server application that provides the
user answers to trivia-like questions. It is part of a computer science
assignment (2nd year, 1st semester).

**(Self imposed) deadline**: 29 / 12 / 2022

**Soft deadline**: ?

This project will be available
<a href="https://github.com/w1bb/IA4-Project">on Github</a> once the soft deadline passes.

## License

Once the soft deadline passes, this project will be available under the **MIT
license**. The code and documentation present in this repository was kindly
contributed by:

* Maria-Miruna ALDICA
(<a href="https://github.com/miruna15aldica">@miruna15aldica</a>);
* Matei-Ștefan IONESCU
(<a href="https://github.com/Matei77">@Matei77</a>);
* Valentin-Ioan VINTILĂ
(<a href="https://github.com/w1bb">@w1bb</a>).

## Required packages

In order to function properly, the project requires a number of packages, each
with its specific functionality:

* `bs4`, required by the AI module - it helps scrape the Wikipedia articles;
* `flask`, required by the Server module - it provides the functionality to instantiate the actual server;
* `googlesearch`, required by the AI module - it searches Google for the best Wikipedia articles;
* `rich` - used throught the project to make text beautiful;
* `tensorflow`, required by the AI module - it is used by the `transformers` package;
* `transformers`, required by the AI module - it is the actual brain of the operation;
* `waitress`, required by the Server module - it provides the functionality to host the server on `localhost:8080`;

Please note that all these packages can be installed via `pip`.

## AI

The AI folder contains the following files:

```
ai.py = The file containing the AI implementation;
ai-test.py = An example that tests the AI implementation by allowing an agent to
             ask as many questions as he desires (break with Ctrl+C).
```

### ai.py

This file contains two important functions:

* `ask_question(original_question)`

    This function receives a question (`original_question`) and provides an
answer in the form of a string. If no results could be found in a given time
span, the `"Sorry, could not find any answer on Wikipedia!"` string is returned
instead.
* `get_urls(original_question, stop_no, urls)`

    This function searches Google
for a question (`original_question`) and tries to find `stop_no` answers; the
result is returned in `results` (this design choice was made so that
`ask_question` could call it as a separate process in order to limit its maximum
time consumption).

**The former function is created to be exported**, whilst the latter is used
inside `ask_question` and should not be relevant to the other parts of the
project.

*Note:* The `ask_question` function is slow at times, please be patient!

### ai-test.py

Run this script and try questions such as `Who is the current president of the
United States?` or `When did the roman empire fall?`. Were the results
satisfactory?
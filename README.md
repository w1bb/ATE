# IA4-Project

This code is intended to store a server application that provides the
user answers to trivia-like questions. It is part of a computer science
assignment (2nd year, 1st semester).

**(Self imposed) deadline**: 29 / 12 / 2022

**Hard deadline**: ?

This project will be available
<a href="https://github.com/w1bb/IA4-Project">on Github</a> once the hard deadline passes.

## License

Once the hard deadline passes, this project will be available under the **MIT
license**. The code and its documentation were kindly contributed by:

* Maria-Miruna ALDICA
(<a href="https://github.com/miruna15aldica">@miruna15aldica</a>);
* Matei-Ștefan IONESCU
(<a href="https://github.com/Matei77">@Matei77</a>);
* Valentin-Ioan VINTILĂ
(<a href="https://github.com/w1bb">@w1bb</a>).

## Running the project

There are three ways to run this project, and each comes with its advantages and disadvantages:

* Running the project **locally without venv** - this has the benefit of running out of the box as long as a few requirements are met (please read the dedicated subsection);
* Running the project **locally with venv** - this is almost the same as the first option, only it is safer, but it consumes more time;
* Running the project using **docker** - this will take even longer, but will work on any machine.

Pick your poison!

### Running locally without venv

In order to run this project, a few assumptions are made:

* The user is on a Linux OS (preferably Ubuntu or Arch);
* The user has `make`, `python3.10` and `pip` installed, alongside a browser to check out the resulting server.

To build and run the project, please follow these steps:

1. From the parent (current) folder, run `make build`. This will create a folder called `product` that will contain all the files required by the server. The command will also check to see if the required packages are installed and, if they are missing, it will install them. If you dislike this behaviour, check out the other ways of running the server.
2. Run `make run` in order to start the server. In a browser (e.g. Firefox), you can now go to `127.0.0.1:8080` and check the functionality of the application. Please note that the terminal in which you typed the command will now act as a logger. You should also make sure the `8080` port is not already in use.
3. When you are done, you can exit the server by pressing `Ctrl+C`.
4. *(Optional)* Once you are done testing the functionality, you can run a cleanup procedure by typing `make clean`. Please make sure the server is not running in the background before running this command.

### Running locally with venv

In order to run this project, a few assumptions are made:

* The user is on a Linux OS (preferably Ubuntu or Arch);
* The user has `make`, `python3.10`, `pip` and `venv` installed, alongside a browser to check out the resulting server. Note that `venv` should come with the Python package, but this is not guaranteed (Debian might not ship `python` with `venv`).

To build and run the project, please follow these steps:

1. From the parent (current) folder, run `make venv-build`. This will create a folder called `venv-product` that will contain all the files required by the server. The command will also install the required packages in the virtual environment.
2. Run `make venv-run` in order to start the server. In a browser (e.g. Firefox), you can now go to `127.0.0.1:8080` and check the functionality of the application. Please note that the terminal in which you typed the command will now act as a logger. You should also make sure the `8080` port is not already in use.
3. When you are done, you can exit the server by pressing `Ctrl+C`.
4. *(Optional)* Once you are done testing the functionality, you can run a cleanup procedure by typing `make venv-clean`. Please make sure the server is not running in the background before running this command.

### Running using docker

In order to run this project, a few assumptions are made:

* The user is on a Linux OS (preferably Ubuntu or Arch);
* The user has `docker` correctly installed and configured on its machine. This might require the user to get added to a [special group](https://stackoverflow.com/questions/47854463/docker-got-permission-denied-while-trying-to-connect-to-the-docker-daemon-socke).

To build and run the project, please follow these steps:

1. From the parent (current) folder, run `make docker-build`. This will create the files inside `docker-product` and then will prompt `docker` to create an image file. This process will take a while.
2. After the first step is complete, one should get a message similar to this one:
    ```
    (...)
    Step 13/13 : CMD ["make", "run-here"]
    ---> Running in bcdf1f83fd11
    Removing intermediate container bcdf1f83fd11
    ---> ee0ed09054f9
    Successfully built ee0ed09054f9
    Successfully tagged w1bb/ia4:1.0

    Everything was setup successfully!
    ```
    In this case, the resulting image is called `ee0ed09054f9` (it can be determined as it follows the `Successfully built` message). Use that name to start the actual server - this can be accomplished by running:
    ```
    wi@arch:~$ docker run -p 8080:8080 <IMAGE NAME>
    ```
    Based on the example above, one should run `docker run -p 8080:8080 ee0ed09054f9`. In a browser (e.g. Firefox), you can now go to `127.0.0.1:8080` and check the functionality of the application. Please note that the terminal in which you typed the command will now act as a logger. You should also make sure the `8080` port is not already in use.
3. When you are done, you can exit the server by pressing `Ctrl+C`.
4. *(Optional)* Once you are done testing the functionality, you can run a cleanup procedure by typing `make docker-clean`. Please make sure the server is not running in the background before running this command.



## Documentation

This section will present the inner-workings of the code.

### Required packages

In order to function properly, the project requires a number of packages, each
with its specific functionality:

* `bs4`, required by the AI module - it helps scrape the Wikipedia articles;
* `flask`, required by the Server module - it provides the functionality to instantiate the actual server;
* `google`, required by the AI module - it searches Google for the best Wikipedia articles;
* `rich` - used throught the project to make text beautiful;
* `tensorflow`, required by the AI module - it is used by the `transformers` package;
* `transformers`, required by the AI module - it is the actual brain of the operation;
* `waitress`, required by the Server module - it provides the functionality to host the server on `localhost:8080`;

Please note that all these packages can be installed via `pip`.

### The AI module

The AI folder contains the following files:

```
ai.py = The file containing the AI implementation;
ai-test.py = An example that tests the AI implementation by allowing an agent to
             ask as many questions as he desires (break with Ctrl+C).
```

#### ai.py

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

#### ai-test.py

Run this script and try questions such as `Who is the current president of the
United States?` or `When did the roman empire fall?`. Were the results
satisfactory?
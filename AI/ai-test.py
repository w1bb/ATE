exec(open("ai.py").read())

while True:
    question = input("Q: ")
    answer = ask_question(question)
    print("A: ", answer)

# e.g. Who is the current president of the United States?

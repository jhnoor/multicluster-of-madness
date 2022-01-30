import json
import random
import os
from flask import Flask

with open('parker-1.json', 'r') as json_file:
	parker_lines = json.load(json_file)

app = Flask(__name__)

@app.route('/')
def index():
    return "[{}]: {}\n".format(os.getenv("HOSTNAME"), random.choice(parker_lines))

if __name__ == '__main__':
    app.run(debug=True)
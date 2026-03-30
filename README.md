# Creative AI Assignment
# By Sam Gatsky -- sg823@kent.ac.uk

## What is this?
Using your webcam, it analyzes the face shown and paints around it depending on the expression.

Positive expressions: Light green box with bouncing dots inside, bubbling with energy!

Negative expressions: Red outlining box with piercing lines. Dead inside...

Neutral expression: Back to normal, standard white box surrounding face.

The project is made of 2 vital components:
- The processing script (takes input and draws on the canvas)
- FastAPI Python 3.11 script (does the AI predictions)

## 1: Setup the virtual environment
Go to your terminal/gitbash and create a virtual environment for the project.

Since the facial expression system utilizes Tensorflow, run this using a python 3.11 virtual environment.

In the directory of the project, run:

``python3.11 -m venv venv``

## 2: Activate the virtual environment

Windows: ``source venv/scripts/activate``

Linux/MacOS: ``source venv/bin/activate``

## 3: Install dependencies

Ensure pip is installed ``python -m pip install``

Save the required packages to the virtual environment. You can review them under ``./requirements.txt`` beforehand. 

Install them by running the following:

``python -m pip install -r requirements.txt``

## 4: Run FastAPI
Now the required packages are installed, run FastAPI before running the draw_face.pde file in processing.

``fastapi dev main.py``

## 5: Run the processing script
Once FastAPI is active, go back to draw_face script in your active processing window and run it. It should draw a box around any face in the webcam and change the view depending on the expressions shown by the people in it.




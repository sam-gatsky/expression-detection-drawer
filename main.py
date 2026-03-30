from fastapi import FastAPI, Query
from pydantic import BaseModel
from deepface import DeepFace
import cv2
import numpy as np

app = FastAPI()

class ImageData(BaseModel):
    image: str

@app.get("/")
async def root():
    return {"message": "Hello World"}

@app.get("/analyze")
def analyze(filename: str = Query(...)):
    # Read the image from the server's filesystem
    with open(filename, "rb") as f:
        image_bytes = f.read()

    # Save temp copy to disk or convert to numpy for DeepFace
    nparr = np.frombuffer(image_bytes, np.uint8)
    img = cv2.imdecode(nparr, cv2.IMREAD_COLOR)

    # Analyze the image
    result = DeepFace.analyze(img, actions=["emotion"], enforce_detection=False)

    # Return only the main emotion
    dominant_emotion = result[0]["dominant_emotion"] # extracts the dominant expression as it's the first item in the result list
    return {dominant_emotion}
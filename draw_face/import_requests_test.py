import requests
import base64

image_name = "draw_face/temp.png"
# troubleshooted with current_dir = os.getcwd()

def test_analyze(imagePath):
    with open(imagePath, "rb") as f:
        image_bytes = f.read()
    image_b64 = base64.b64encode(image_bytes).decode("utf-8") # converts the image to base64 so it can be read by the API

    response = requests.post("http://127.0.0.1:8000/analyze", json={"image": image_b64})

    responseDict = response.json()

    print(responseDict["emotion"]) # for testing purposes, prints the main emotion to the console

    return responseDict["emotion"]



test_analyze(image_name)
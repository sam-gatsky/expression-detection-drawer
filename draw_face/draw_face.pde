import http.requests.*;
import processing.video.*;
import gab.opencv.*;
import java.awt.*;

OpenCV opencv;
Capture video;

// --- expression state ---
int moodTimer = 0;
String API_ENDPOINT = "http://127.0.0.1:8000";
String API_ANALYZE = "/analyze"; // pathway to the GET analyze function on the API
String currentExp = "";
String obtainedStr = "";

void setup() {
  frameRate(1); // 1 frame per second captured
  size(640, 480); // upscales the preview to be visible
  video = new Capture(this, 640/2, 480/2); // renders at half res for performance
  video.start();

  opencv = new OpenCV(this, 640/2, 480/2); // renders at helf res for performance
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE); // pre-trained openCV model to detect eyes and noses to determine faces

  strokeWeight(3);
}

void draw() {
  scale(2); // upscales the image that was previously downscaled for optimization
  opencv.loadImage(video);
  image(video, 0, 0);
  frameCount = frameCount + 1;
  
  Rectangle[] faces = opencv.detect(); // draws the rectangle around the face

  // if there is a face
  if (faces.length != 0) {
    Rectangle f = faces[0]; // Coords are in INT for center of face box to be drew

      PImage faceImg = video.get(f.x, f.y, f.width, f.height);
    
      if (frameCount % 5 == 0) { // every 5 seconds take analysis
        analyzeEmotion(faceImg); // param webcam feed img
      }

    drawFaceFX(f);
    }
  }

void drawFaceFX(Rectangle f) {
  noFill();
  println("detected expression is : ", currentExp);
  if (currentExp.contains("happy") || currentExp.contains("surprise")) {
    stroke(25, 250, 0);
    rect(f.x, f.y, f.width, f.height);
    drawSparkles(f);
  }

  else if (currentExp.contains("angry") || currentExp.contains("sad") || currentExp.contains("disgust") || currentExp.contains("fear")) {
    stroke(255, 50, 50);
    rect(f.x, f.y, f.width, f.height);
    drawGlitch(f);
  }

  else { // neutral || anything else
    stroke(255);
    rect(f.x, f.y, f.width, f.height);
  }
}

// HAPPY = sparkles
void drawSparkles(Rectangle f) {
  for (int i = 0; i < 6; i++) {
    float sx = random(f.x, f.x + f.width);
    float sy = random(f.y, f.y + f.height);
    stroke(25, 250, 0);
    point(sx, sy);
  }
}

// ANGRY = glitch lines
void drawGlitch(Rectangle f) {
  stroke(255, 0, 0);
  for (int i = 0; i < 5; i++) {
    float y = random(f.y, f.y + f.height);
    line(f.x - 10, y, f.x + f.width + 10, y);
  }
}

void captureEvent(Capture c) {
  c.read();
}

void analyzeEmotion(PImage face) {
  face.save("temp.png"); // saves the faceshot as a png

  // refer to https://github.com/runemadsen/HTTP-Requests-for-Processing/tree/master for docs
  GetRequest get = new GetRequest(API_ENDPOINT + API_ANALYZE + "?filename=draw_face/temp.png");
  get.send();
  obtainedStr = get.getContent(); // example: ["happy"]
      obtainedStr = obtainedStr.replace("["," "); // cleaning up the string so it can be used in Processing
      obtainedStr = obtainedStr.replace("]"," ");
      obtainedStr = obtainedStr.replace("\"", "");
  currentExp = obtainedStr;
}

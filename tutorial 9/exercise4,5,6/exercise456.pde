import shapes3d.*;
import shapes3d.utils.*;
import peasy.*;

Ellipsoid sun, earth, moon;
PeasyCam cam;

float sunRot = 0;
float earthOrbit = 0;
float earthRot = 0;
float moonOrbit = 0;
PVector[] stars = new PVector[300];
//manual cam                               //question5 manual camera control has been commented out 
//float rotX = 0;
//float rotY = 0;
//float lastX, lastY;
//boolean dragging = false;

//void mousePressed() {
//  dragging = true;
//  lastX = mouseX;
//  lastY = mouseY;
//}
//void mouseDragged() {
//  if (dragging) {
//    float dx = mouseX - lastX;
//    float dy = mouseY - lastY;
//    rotY += dx * 0.01;
//    rotX += dy * 0.01;
//    lastX = mouseX;
//    lastY = mouseY;
//  }
//}
//void mouseReleased() {
//  dragging = false;
//}

void setup() {
  size(900, 600, P3D);
  //zoom initally500
  cam = new PeasyCam(this, 500);
  
  PImage sunTex = loadImage("sun.jpg");
  PImage earthTex = loadImage("earth.png");
  PImage moonTex = loadImage("moon.png");

  sun = new Ellipsoid(80, 80, 80);
  sun.use(S3D.BODY).texture(sunTex).drawMode(S3D.TEXTURE);
  earth = new Ellipsoid(40, 40, 40);
  earth.use(S3D.BODY).texture(earthTex).drawMode(S3D.TEXTURE);
  moon = new Ellipsoid(20, 20, 20);
  moon.use(S3D.BODY).texture(moonTex).drawMode(S3D.TEXTURE);

 for (int i = 0; i < stars.length; i++) {
    stars[i] = new PVector(
      random(-1000, 1000),
      random(-1000, 1000),
      random(-1000, 1000)); }
}

void draw() {
  background(0);
 //Stars
  stroke(255);
  strokeWeight(2);
  for (PVector s : stars) {
    point(s.x, s.y, s.z); }

  ambientLight(80, 80, 80);
  pointLight(255, 255, 255, 0, 0, 200);

  //translate(width/2, height/2)      -manual cam
  //rotateX(rotX);
  //rotateY(rotY);

 //Sun
 pushMatrix();
  rotateY(sunRot);
  sun.draw(getGraphics());
  popMatrix();

 //Earth orbit
  pushMatrix();
  rotateY(earthOrbit);
  translate(200, 0, 0);
  pushMatrix();
  rotateY(earthRot);
  earth.draw(getGraphics());
  popMatrix();

  //Moon orbit
 pushMatrix();
 rotateY(moonOrbit);
  translate(80, 0, 0);
  moon.draw(getGraphics());
  popMatrix();
  popMatrix();

  sunRot += 0.01;
  earthOrbit += 0.008;
  earthRot += 0.05;
  moonOrbit += 0.03;}

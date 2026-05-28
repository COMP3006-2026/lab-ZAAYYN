import shapes3d.*;
import shapes3d.contour.*;
import shapes3d.path.*;
import shapes3d.utils.*;
//hold right click and move the vehical
Box body, roof, frontSlope, headlightL, headlightR;
Tube wheelFL, wheelFR, wheelRL, wheelRR;
float rotX = 0;
float rotY = 0;
float lastMouseX, lastMouseY;
boolean dragging = false;

void setup() {
  size(900, 600, P3D);
  body = new Box(150, 35, 60);
  body.fill(color(120, 220, 140)).strokeWeight(0); // light green

  roof = new Box(80, 25, 50);
  roof.fill(color(100, 200, 120)).strokeWeight(0);

  frontSlope = new Box(40, 25, 50);
  frontSlope.fill(color(120, 220, 140)).strokeWeight(0);

  headlightL = new Box(10, 8, 10);
  headlightL.fill(color(255, 255, 180)).strokeWeight(0);

  headlightR = new Box(10, 8, 10);
  headlightR.fill(color(255, 255, 180)).strokeWeight(0);

  wheelFL = makeWheel();
  wheelFR = makeWheel();
  wheelRL = makeWheel();
  wheelRR = makeWheel();}

Tube makeWheel() {
  Path path = new Linear(new PVector(-15, 0, 0),new PVector(15, 0, 0),2);

  Oval circle = new Oval(18, 32);
  Tube t = new Tube(path, circle);

  t.use(S3D.BODY).fill(color(30)).drawMode(S3D.SOLID);
  t.use(S3D.END0 | S3D.END1).fill(color(120)).drawMode(S3D.SOLID);

  return t;
}

void draw() {
  background(255);
  lights();
  translate(width/2, height/2);
  rotateX(rotX);
  rotateY(rotY);
  drawCar();
}

void drawCar() {
  PGraphics pg = getGraphics();

  pushMatrix();
  scale(1.2, 0.8, 1);  
  body.draw(pg);
  popMatrix();
  
  pushMatrix();
  translate(-10, -25, 0);
  scale(1.0, 0.8, 1);
  roof.draw(pg);
  popMatrix();

  pushMatrix();
  translate(65, -10, 0);
  rotateZ(-PI/8);   
  scale(1.0, 0.7, 1);
  frontSlope.draw(pg);
  popMatrix();

  pushMatrix();
  translate(85, 5, 18);
  headlightL.draw(pg);
  popMatrix();

  pushMatrix();
  translate(85, 5, -18);
  headlightR.draw(pg);
  popMatrix();

  pushMatrix();
  translate(55, 28, 32);
  rotateY(HALF_PI);
  wheelFL.draw(pg);
  popMatrix();

  pushMatrix();
  translate(55, 28, -32);
  rotateY(HALF_PI);
  wheelFR.draw(pg);
  popMatrix();

  pushMatrix();
  translate(-55, 28, 32);
  rotateY(HALF_PI);
  wheelRL.draw(pg);
  popMatrix();

  pushMatrix();
  translate(-55, 28, -32);
  rotateY(HALF_PI);
  wheelRR.draw(pg);
  popMatrix();
}

void mousePressed() {
  dragging = true;
  lastMouseX = mouseX;
  lastMouseY = mouseY;
}
void mouseDragged() {
  if (dragging) {
    float dx = mouseX - lastMouseX;
    float dy = mouseY - lastMouseY;
    rotY += dx * 0.01;
    rotX += dy * 0.01;
    lastMouseX = mouseX;
    lastMouseY = mouseY;
  }
}

void mouseReleased() {
  dragging = false;
}

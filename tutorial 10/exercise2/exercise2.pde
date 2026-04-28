import shapes3d.*;
import shapes3d.contour.*;
import shapes3d.path.*;
import shapes3d.utils.*;

float rotX = 0, rotY = 0;
float lastMouseX, lastMouseY;
boolean dragging = false;

float[] carX     = {-320, -160,   0,  160,  320};
float[] carScale = { 0.5,  0.4, 1.2,  0.3,  0.6};
color[] bodyCol  = {color(220,80,80), color(80,130,220), color(120,220,140), color(240,200,60), color(200,100,240)};
color[] roofCol  = {color(180,60,60), color(60,100,180), color(100,190,120), color(200,160,40),  color(160,70,200)};

void setup() {
  size(900, 600, P3D);
}

Tube makeWheel() {
  Path p = new Linear(new PVector(-15,0,0), new PVector(15,0,0), 2);
  Oval o = new Oval(18, 32);
  Tube t = new Tube(p, o);
  t.use(S3D.BODY).fill(color(30)).drawMode(S3D.SOLID);
  t.use(S3D.END0|S3D.END1).fill(color(120)).drawMode(S3D.SOLID);
  return t;
}

void drawCar(PGraphics pg, float sc, color bc, color rc) {
  Box body  = new Box(150,35,60); body.fill(bc).strokeWeight(0);
  Box roof  = new Box(80,25,50);  roof.fill(rc).strokeWeight(0);
  Box slope = new Box(40,25,50);  slope.fill(bc).strokeWeight(0);
  Box hlL   = new Box(10,8,10);   hlL.fill(color(255,255,180)).strokeWeight(0);
  Box hlR   = new Box(10,8,10);   hlR.fill(color(255,255,180)).strokeWeight(0);
  Tube wFL=makeWheel(), wFR=makeWheel(), wRL=makeWheel(), wRR=makeWheel();

  pushMatrix();
  scale(sc);
  pushMatrix(); scale(1.2,0.8,1); body.draw(pg); popMatrix();
  pushMatrix(); translate(-10,-25,0); scale(1,0.8,1); roof.draw(pg); popMatrix();
  pushMatrix(); translate(65,-10,0); rotateZ(-PI/8); scale(1,0.7,1); slope.draw(pg); popMatrix();
  pushMatrix(); translate(85,5, 18); hlL.draw(pg); popMatrix();
  pushMatrix(); translate(85,5,-18); hlR.draw(pg); popMatrix();
  pushMatrix(); translate( 55,28, 32); rotateY(HALF_PI); wFL.draw(pg); popMatrix();
  pushMatrix(); translate( 55,28,-32); rotateY(HALF_PI); wFR.draw(pg); popMatrix();
  pushMatrix(); translate(-55,28, 32); rotateY(HALF_PI); wRL.draw(pg); popMatrix();
  pushMatrix(); translate(-55,28,-32); rotateY(HALF_PI); wRR.draw(pg); popMatrix();
  popMatrix();
}

void draw() {
  background(240);
  lights();
  for (int i = 0; i < 5; i++) {
    pushMatrix();
    translate(width/2 + carX[i], height/2, 0);
    rotateX(rotX);
    rotateY(rotY);
    drawCar(getGraphics(), carScale[i], bodyCol[i], roofCol[i]);
    popMatrix();
  }
}

void mousePressed()  { dragging=true; lastMouseX=mouseX; lastMouseY=mouseY; }
void mouseDragged() {
  if (dragging) {
    rotY += (mouseX-lastMouseX)*0.01;
    rotX += (mouseY-lastMouseY)*0.01;
    lastMouseX=mouseX; lastMouseY=mouseY;
  }
}
void mouseReleased() { dragging=false; }

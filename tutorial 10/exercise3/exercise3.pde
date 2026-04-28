import shapes3d.*;
import shapes3d.contour.*;
import shapes3d.path.*;
import shapes3d.utils.*;

float rotX = 0, rotY = 0;
float lastMouseX, lastMouseY;
boolean dragging = false;
int selectedCar = -1; 

float[] carX     = {-320, -160,   0,  160,  320};
float[] carScale = { 0.5,  0.4, 1.2,  0.3,  0.6};
color[] bodyCol  = {color(220,80,80),   color(80,130,220),  color(120,220,140), color(240,200,60),  color(200,100,240)};
color[] roofCol  = {color(180,60,60),   color(60,100,180),  color(100,190,120), color(200,160,40),  color(160,70,200)};

//brighter
color[] bodyColBright = {color(255,120,120), color(120,180,255), color(160,255,180), color(255,240,100), color(240,150,255)};
color[] roofColBright = {color(255,100,100), color(100,150,255), color(140,255,160), color(255,210,80),  color(210,110,255)};

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

//2daround car
float[] carBounds(int i) {
  float cx = width/2 + carX[i];
  float cy = height/2;
  float sc = carScale[i];
  float hw = 100 * sc * 1.2;  
  float hh = 60  * sc;       
  return new float[]{cx - hw, cy - hh, cx + hw, cy + hh};
}

void draw() {
  background(240);
  lights();

  for (int i = 0; i < 5; i++) {
    color bc = (i == selectedCar) ? bodyColBright[i] : bodyCol[i];
    color rc = (i == selectedCar) ? roofColBright[i] : roofCol[i];

    pushMatrix();
    translate(width/2 + carX[i], height/2, 0);
    rotateX(rotX);
    rotateY(rotY);
    drawCar(getGraphics(), carScale[i], bc, rc);
    popMatrix();}

  
}

void mousePressed()  { dragging = false; lastMouseX = mouseX; lastMouseY = mouseY; }

void mouseDragged() {
  float dx = mouseX - lastMouseX;
  float dy = mouseY - lastMouseY;
  if (abs(dx) > 2 || abs(dy) > 2) {
    dragging = true;
    rotY += dx * 0.01;
    rotX += dy * 0.01;
  }
  lastMouseX = mouseX; lastMouseY = mouseY;
}

void mouseReleased() {
  if (!dragging) {
  //boundry
    int[] order = {2, 0, 4, 1, 3}; 
    int hit = -1;
    for (int idx : order) {
      float[] b = carBounds(idx);
      if (mouseX >= b[0] && mouseX <= b[2] && mouseY >= b[1] && mouseY <= b[3]) {
        hit = idx;
        break;
      }
    }
    if (hit == selectedCar) {
      selectedCar = -1; //clcik same to deselect
    } else {
      selectedCar = hit; //-1 if click empty screen
    }
  }
  dragging = false;
}

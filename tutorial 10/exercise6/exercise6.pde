import shapes3d.*;
import shapes3d.contour.*;
import shapes3d.path.*;
import shapes3d.utils.*;

float rotX = 0, rotY = 0;
float lastMouseX, lastMouseY;
boolean dragging = false;

float[] carX     = {-320, -160,   0,  160,  320};
float[] carScale = { 0.35, 0.28, 0.8, 0.22, 0.42};

color[] bodyCol  = {color(220,80,80),  color(80,130,220),  color(120,220,140), color(240,200,60),  color(200,100,240)};
color[] roofCol  = {color(180,60,60),  color(60,100,180),  color(100,190,120), color(200,160,40),  color(160,70,200)};

float t = 0;

void setup() {
  size(900, 600, P3D);
}

//simple floor grid
void drawGrid() {
  stroke(200);
  strokeWeight(1);
  int size = 800;
  int step = 40;

  for (int i = -size; i <= size; i += step) {
    line(i, 0, -size, i, 0, size); //Z lines
    line(-size, 0, i, size, 0, i); //X lines
  }
}

//wheel
Tube makeWheel(int dark, int light) {
  Path p = new Linear(new PVector(-15,0,0), new PVector(15,0,0), 2);
  Oval o = new Oval(18, 32);
  Tube tube = new Tube(p, o);
  tube.use(S3D.BODY).fill(dark).drawMode(S3D.SOLID);
  tube.use(S3D.END0|S3D.END1).fill(light).drawMode(S3D.SOLID);
  return tube;
}

//car model
void drawCar(PGraphics pg, float sc, color bc, color rc, int alpha) {
  bc = color(red(bc), green(bc), blue(bc), alpha);
  rc = color(red(rc), green(rc), blue(rc), alpha);

  int wheelDark  = color(30,30,30,alpha);
  int wheelLight = color(120,120,120,alpha);
  int headlight  = color(255,255,180,alpha);

  Box body  = new Box(150,35,60); body.fill(bc).strokeWeight(0);
  Box roof  = new Box(80,25,50);  roof.fill(rc).strokeWeight(0);
  Box slope = new Box(40,25,50);  slope.fill(bc).strokeWeight(0);
  Box hlL   = new Box(10,8,10);   hlL.fill(headlight).strokeWeight(0);
  Box hlR   = new Box(10,8,10);   hlR.fill(headlight).strokeWeight(0);

  Tube wFL=makeWheel(wheelDark,wheelLight),
       wFR=makeWheel(wheelDark,wheelLight),
       wRL=makeWheel(wheelDark,wheelLight),
       wRR=makeWheel(wheelDark,wheelLight);

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
  background(245);
  lights();

  //draw grid first
  pushMatrix();
  translate(width/2, height/2 + 80, -300);
  rotateX(PI/2);
  drawGrid();
  popMatrix();

  t = (t + 0.003) % 1.0;
  float ping = (sin(t * TWO_PI) + 1) * 0.5;

  for (int i = 0; i < 5; i++) {
    pushMatrix();

    if (i == 0) {
      //car1 moves left-right
      float tx = lerp(-350, 350, ping);
      translate(width/2 + tx, height/2, -300);
  } else if (i == 1) {
      //car2 infinity path + spin
      float a = t * TWO_PI;
      translate(width/2 + 180*sin(a), height/2 -60*sin(a), 130*sin(a*2)-300);
      rotateY(a*2);  } else if (i == 2) {
      //car3 circle + grow
      float a = t * TWO_PI;
      float r = 170;
      translate(width/2 + r*cos(a), height/2, r*sin(a)-300);
      float base = carScale[i];
      float sc = lerp(base, base*2.0, ping);
      scale(sc/base);  } else if (i == 3) {
      //car4 wave + fade
      float tx = lerp(-260, 260, ping);
      float ty = 100 * sin(t * TWO_PI * 3);
      int alpha = int(lerp(255, 0, ping));

      translate(width/2 + tx, height/2 + ty, -300);
      rotateX(rotX); rotateY(rotY);

      drawCar(getGraphics(), carScale[i],
        color(red(bodyCol[i]),green(bodyCol[i]),blue(bodyCol[i]),alpha),
        color(red(roofCol[i]),green(roofCol[i]),blue(roofCol[i]),alpha),
        alpha);

      popMatrix();
      continue;

    } else {
      //car5 spiral motion
      float a = t * TWO_PI * 2;
      translate(width/2 + lerp(-220,220,ping), height/2 + 90*cos(a), 160*sin(a)-300);
    }

    rotateX(rotX);
    rotateY(rotY);
    drawCar(getGraphics(), carScale[i], bodyCol[i], roofCol[i], 255);
    popMatrix();
  }

  //labels
  hint(DISABLE_DEPTH_TEST);
  fill(40); noStroke(); textSize(12);
  text("red: straight", 16, 20);
  text("blue: infinity", 16, 36);
  text("green: circle+scale", 16, 52);
  text("yellow: wave+fade", 16, 68);
  text("purple: spiral", 16, 84);
  hint(ENABLE_DEPTH_TEST);
}

void mousePressed(){ dragging=true; lastMouseX=mouseX; lastMouseY=mouseY; }

void mouseDragged(){
  if(dragging){
    rotY += (mouseX-lastMouseX)*0.01;
    rotX += (mouseY-lastMouseY)*0.01;
    lastMouseX=mouseX;
    lastMouseY=mouseY;
  }
}

void mouseReleased(){ dragging=false; }

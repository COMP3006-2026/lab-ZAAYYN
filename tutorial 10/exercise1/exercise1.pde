float sphereX, sphereY, sphereZ;
float lastMouseY;
boolean shiftPressed = false;
void setup() {
  size(900, 700, P3D);
  sphereX = width / 2;
  sphereY = height / 2;
  sphereZ = 0;
  lastMouseY = mouseY;
  smooth(8);}

void draw() {
  background(15, 15, 25);
  drawGrid();
  if (shiftPressed) {
  //mosue control vertical
    float dy = mouseY - lastMouseY;
    sphereZ += dy * 2;
    sphereZ = constrain(sphereZ, -400, 400); } else {
 //moving mouse horizontally
    sphereX += (mouseX - sphereX) * 0.12;
    sphereY += (mouseY - sphereY) * 0.12;
  }
  lastMouseY = mouseY;

  lights();
  ambientLight(40, 40, 60);
  directionalLight(255, 255, 255, -0.5, -0.8, -1);
  pointLight(100, 200, 255, sphereX - 80, sphereY - 80, sphereZ + 200);
  float t = map(sphereZ, -400, 400, 0, 1);
  float r = 255;
float g = lerp(50, 120, t);
float b = 0;
  float sphereRadius = map(sphereZ, -400, 400, 40, 100);

//draw sphere
  pushMatrix();
  translate(sphereX, sphereY, sphereZ);
  noStroke();
  fill(r, g, b);
  sphereDetail(64);
  sphere(sphereRadius);
  popMatrix();
 
  drawDepthRail();
  drawHUD();
}

void drawGrid() {
  stroke(255, 255, 255, 18);
  strokeWeight(1);
  int cols = 10;
  int rows = 6;
  float vanX = width / 2.0;
  float vanY = height * 0.5;

  for (int i = 0; i <= cols; i++) {
    float bx = map(i, 0, cols, 0, width);
    line(bx, height, vanX, vanY);
  }
  for (int j = 1; j <= rows; j++) {
    float t = (float) j / rows;
    float lx = lerp(vanX, 0, t);
    float rx = lerp(vanX, width, t);
    float ly = lerp(vanY, height, t);
    line(lx, ly, rx, ly);  }
}

void drawDepthRail() {
  float rx = width - 30;
  float ry1 = height * 0.1;
  float ry2 = height * 0.9;
 

//line
  stroke(255, 255, 255, 30);
  strokeWeight(1);
  line(rx, ry1, rx, ry2);


  float t = map(sphereZ, -400, 400, 0, 1);
  float dotY = lerp(ry2, ry1, t);
  noStroke();
  fill(100, 220, 255, 180);
  ellipse(rx, dotY, 10, 10);

//labels
  fill(255, 255, 255, 80);
  textSize(10);
  textAlign(CENTER);
  text("Z", rx, ry1 - 10);
  text(nf(sphereZ, 1, 0), rx, dotY - 12);
}

void drawHUD() {
  textSize(12);
  textAlign(LEFT);
  fill(255, 255, 255, 100);
  text("x: " + nf(sphereX, 1, 0) +
       "  y: " + nf(sphereY, 1, 0) +
       "  z: " + nf(sphereZ, 1, 0), 14, 20);
  if (shiftPressed) {
    fill(255, 200, 80, 200);
    text("mode: DEPTH (Z)", 14, 38); } else {
    fill(100, 220, 255, 200);
    text("mode: XY", 14, 38);}
  fill(255, 255, 255, 50);
  text("Move mouse: XY | Hold SHIFT + move mouse:Z depth", width/2 - 170, height - 14);
}
void keyPressed() {
  if (keyCode == SHIFT) {
    shiftPressed = true;
    lastMouseY = mouseY;}
}

void keyReleased() {
  if (keyCode == SHIFT) {
    shiftPressed = false;  }
}

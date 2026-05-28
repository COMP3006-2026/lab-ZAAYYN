int numShapes = 10;
Shape[] shapes =new Shape[numShapes];
void setup() {
  size(800, 600, P3D);
  generateShapes();
}

void draw() {
  background(20, 20, 40);
  lights();
  pointLight(255, 220, 180, 200, -200, 300);
  ambientLight(60, 60, 80);
 
translate(width/2, height/2, 0);
rotateX(frameCount * 0.003);
rotateY(frameCount * 0.005);
  
 for (Shape s : shapes) {
s.display();  }
}

void keyPressed() {
  if (key == 'r' || key == 'R') generateShapes();}

void generateShapes() {
  for (int i = 0; i < numShapes; i++) {
    shapes[i] = new Shape(); }
}

class Shape {
  float x, y, z;
  float size;
  color col;
  boolean isSphere;
  float rx, ry, rz;
  float speedX, speedY;

  Shape() {
    x = random(-200, 200);
    y = random(-200, 200);
    z = random(-200, 200);
    size = random(20, 80);
    col = color(random(80, 255), random(80, 255), random(80, 255));
    isSphere = random(1) > 0.5;
    rx = random(TWO_PI);
    ry = random(TWO_PI);
    rz = random(TWO_PI);
    speedX = random(-0.01, 0.01);
    speedY = random(-0.01, 0.01);
  }

  void display() {
   rx += speedX;
  ry += speedY;

   pushMatrix();
    translate(x, y, z);
    rotateX(rx);
    rotateY(ry);
    rotateZ(rz);

    fill(col);
    noStroke();
    specular(200, 200, 200);
    shininess(80);

  if (isSphere) {
     sphere(size / 2);   } else {
      box(size);
    }

  popMatrix(); }
}

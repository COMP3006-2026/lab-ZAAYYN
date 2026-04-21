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
    s.display();}
}

void keyPressed() {
  if (key == 'r' || key == 'R') generateShapes();
}

void generateShapes() {
  for (int i = 0; i < numShapes; i++) {
    shapes[i] = new Shape();}
}

class Shape {
  float x, y, z;
  float size;
  color col;
  boolean isSphere;
  float rx, ry, rz;
  float speedX, speedY;
  
  boolean hasFill;
  boolean hasStroke;

Shape() {
    x = random(-200, 200);
    y = random(-200, 200);
    z = random(-200, 200);
    size = random(20, 80);
    isSphere = random(1) > 0.5;
    rx = random(TWO_PI);
    ry = random(TWO_PI);
    rz = random(TWO_PI);
    speedX = random(-0.01, 0.01);
    speedY = random(-0.01, 0.01);

//Random RGB color
    int colorChoice = int(random(3));
    if (colorChoice == 0)      col = color(220, 50, 50);
    else if (colorChoice == 1) col = color(50, 200, 80);
    else                       col = color(50, 120, 230);
    //random fill and stroke
    hasFill   = random(1) > 0.5;
    hasStroke = random(1) > 0.5;

    if (!hasFill && !hasStroke) hasFill = true;  }

  void display() {
    rx += speedX;
    ry += speedY;

    pushMatrix();
    translate(x, y, z);
    rotateX(rx);
    rotateY(ry);
    rotateZ(rz);
    specular(200, 200, 200);
    shininess(80);

  if (hasFill) {
      fill(col);
    } else { noFill();
    }

  if (hasStroke) {
      stroke(col);
      strokeWeight(2);    } else {
      noStroke();
    }

    if (isSphere) {
      sphere(size / 2); } else {
      box(size);
    }
   popMatrix();  }
}

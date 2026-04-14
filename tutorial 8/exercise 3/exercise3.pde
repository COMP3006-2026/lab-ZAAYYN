import peasy.*; 
PeasyCam cam;

void setup() {
  size(600, 600, P3D);
  cam = new PeasyCam(this, 400);  //camera distance
}

void draw() {
  background(30);
  lights();
  
  fill(100, 180, 255);
  noStroke();
  
  float radius = 150;
  float thickness = 80;
  
 //front face
  beginShape();
  for (int i = 0; i < 5; i++) {
    float angle = map(i, 0, 5, 0, TWO_PI) - HALF_PI;
    vertex(cos(angle) * radius, sin(angle) * radius, thickness / 2);
  }
  endShape(CLOSE);
  
 //back face
  beginShape();
  for (int i = 0; i < 5; i++) {
    float angle = map(i, 0, 5, 0, TWO_PI) - HALF_PI;
    vertex(cos(angle) * radius, sin(angle) * radius, -thickness / 2);
  }
  endShape(CLOSE);
 //sides
  for (int i = 0; i < 5; i++) {
    float angle1 = map(i,     0, 5, 0, TWO_PI) - HALF_PI;
    float angle2 = map(i + 1, 0, 5, 0, TWO_PI) - HALF_PI;
    beginShape();
    vertex(cos(angle1) * radius, sin(angle1) * radius,  thickness / 2);
    vertex(cos(angle2) * radius, sin(angle2) * radius,  thickness / 2);
    vertex(cos(angle2) * radius, sin(angle2) * radius, -thickness / 2);
    vertex(cos(angle1) * radius, sin(angle1) * radius, -thickness / 2);
    endShape(CLOSE);
  }
}

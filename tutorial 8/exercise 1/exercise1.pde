void setup() {
  size(600, 600, P3D);   ///p3d
  sphereDetail(64);}

void draw() {
  background(30);
  lights();     //3d lights
   float rotX = map(mouseY, 0, height, PI, -PI);  //maping mouse to move
 float rotY = map(mouseX, 0, width, -PI, PI); 
  translate(width / 2, height / 2, 0);
  rotateX(rotX);
  rotateY(rotY);
  
  fill(100, 180, 255);
  noStroke();
  sphere(100);
  
  noFill();
  stroke(255, 255, 255, 60);
  strokeWeight(1);
  //lines latitude  
  for (int lat = -60; lat <= 60; lat += 30) {
    float r = cos(radians(lat)) * 101;
    float y = sin(radians(lat)) * 101;
    beginShape();
    for (int i = 0; i <= 64; i++) {
      float a = map(i, 0, 64, 0, TWO_PI);
      vertex(r * cos(a), y, r * sin(a));
    }
    endShape();
  }
  //lines longitude
  for (int lon = 0; lon < 360; lon += 45) {
    float a = radians(lon);
    beginShape();
   for (int i = 0; i <= 64; i++) {
     float phi = map(i, 0, 64, 0, PI);
      vertex(sin(phi) * cos(a) * 101, cos(phi) * 101, sin(phi) * sin(a) * 101);
    }   endShape();
  }
}

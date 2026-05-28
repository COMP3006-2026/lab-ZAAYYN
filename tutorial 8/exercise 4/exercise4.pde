import peasy.*;

PeasyCam cam;
float moonAngle = 0; //trackingmoon

void setup() {
  size(600, 600, P3D);
  cam = new PeasyCam(this, 400);}

void draw() {
  background(0);
  lights();
  //Earth
  fill(30, 100, 255); //blue
  noStroke();
  sphere(80);

  moonAngle += 0.02; //speed of orbit
  //rotation and moon is smaller if move far
  pushMatrix();
    rotateY(moonAngle);       
    translate(180, 0, 0);     
    fill(160, 160, 160);      
    sphere(25);
  popMatrix();}

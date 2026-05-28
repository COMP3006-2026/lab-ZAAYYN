import peasy.*;

PeasyCam cam;
float moonAngle = 0;
float shuttleDist = 80;   //starting at earths surface
boolean arrived = false;
boolean returning = false;

void setup() {
  size(600, 600, P3D);
  cam = new PeasyCam(this, 500);
}

void draw() {
  background(0);
  lights();
  
 //Earth
  fill(30, 100, 255);
  noStroke();
  sphere(80);
  
 //moon orbiting
  moonAngle += 0.01; 
  float moonX = cos(moonAngle) * 180;
  float moonZ = sin(moonAngle) * 180;
  
  pushMatrix();
    translate(moonX, 0, moonZ);
    fill(160, 160, 160);
    sphere(25);
  popMatrix();
  
//shuttle momvemnt logic
  if (!arrived && !returning) {
    shuttleDist += 0.5;       //slow steady to the moooon
    if (shuttleDist >= 180) {
      arrived = true;   //reaching mooon
    }
  } else if (arrived) {
    shuttleDist -= 0.5;     //flying back to earth
    if (shuttleDist <= 80) {
      arrived = false;     //reset and go again
      }
  }
  
  //shuttle follows moon angle so it flies toward moon not empty space
  float sx = cos(moonAngle) * shuttleDist;
  float sz = sin(moonAngle) * shuttleDist;
  
  pushMatrix();
    translate(sx, 0, sz);
    rotateY(-moonAngle);        
    
   //shuttle bodyyyy
    fill(220, 220, 220);
    box(20, 10, 10);
    
  
    pushMatrix();
      translate(13, 0, 0);
      fill(255, 80, 80);
      box(7, 6, 6);
    popMatrix();
    
   
    pushMatrix();
      translate(-4, 0, 0);
      fill(180, 180, 180);
      box(10, 2, 22);
    popMatrix();
    
  popMatrix();}

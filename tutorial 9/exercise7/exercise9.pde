import shapes3d.*;
import shapes3d.utils.*;
import peasy.*;
PeasyCam cam;
PImage brickTex, woodTex, floorTex;
//double left click will reset your cam pov
void setup() {
  size(900, 600, P3D);
  cam = new PeasyCam(this, 600);
  brickTex = loadImage("wall.jpg");
  woodTex  = loadImage("wood.jpg");
  floorTex = loadImage("floor.jpg");}

void draw() {
  background(30);
  ambientLight(100, 100, 100);
  pointLight(255, 240, 200, 0, -150, 0);

  drawRoom();
  drawTable(0, 300, 0);       
  drawChair(120, 300, 30);    
}

void drawRoom() {
  int W = 400;
  int H = 300;
  int D = 400;
  noStroke();
  //FLOOR
  pushMatrix();
  translate(0, H, 0);
  rotateX(HALF_PI);
  drawTexturedPlane(W*2, D*2, floorTex);
  popMatrix();

  //CEILING
  pushMatrix();
  translate(0, -H, 0);
  rotateX(-HALF_PI);
  drawTexturedPlane(W*2, D*2, brickTex);
  popMatrix();

  //BACK WALL
  pushMatrix();
  translate(0, 0, -D);
  drawTexturedPlane(W*2, H*2, brickTex);
  popMatrix();

  //LEFT WALL
  pushMatrix();
  translate(-W, 0, 0);
  rotateY(HALF_PI);
  drawTexturedPlane(D*2, H*2, brickTex);
  popMatrix();

  //RIGHT WALL
  pushMatrix();
  translate(W, 0, 0);
  rotateY(-HALF_PI);
  drawTexturedPlane(D*2, H*2, brickTex);
  popMatrix();
}

void drawTexturedPlane(float w, float h, PImage tex) {
  float hw = w / 2;
  float hh = h / 2;
  beginShape();
  texture(tex);
  vertex(-hw, -hh, 0,  0,          0);
  vertex( hw, -hh, 0,  tex.width,  0);
  vertex( hw,  hh, 0,  tex.width,  tex.height);
  vertex(-hw,  hh, 0,  0,          tex.height);
  endShape(CLOSE);}


void drawTable(float cx, float floorY, float cz) {
  float tabW    = 160, tabD    = 100, tabThick = 12;
  float legW    = 12,  legH    = 80;
  pushMatrix();
  translate(cx, floorY, cz);
//table legs
  float lx = tabW/2 - legW;
  float lz = tabD/2 - legW;

  drawLeg( lx, 0,  lz, legW, legH, woodTex);
  drawLeg(-lx, 0,  lz, legW, legH, woodTex);
  drawLeg( lx, 0, -lz, legW, legH, woodTex);
  drawLeg(-lx, 0, -lz, legW, legH, woodTex);

//table slab
  pushMatrix();
  translate(0, -legH - tabThick/2, 0);
  drawBox(tabW, tabThick, tabD, woodTex);
  popMatrix();

  popMatrix();}

//chair
void drawChair(float cx, float floorY, float cz) {
  float seatW    = 80,  seatD     = 80, seatThick = 10;
  float legW     = 10,  legH      = 60;
  float backH    = 80,  backThick = 10;
  pushMatrix();
  translate(cx, floorY, cz);

  float lx = seatW/2 - legW;
  float lz = seatD/2 - legW;

  drawLeg( lx, 0,  lz, legW, legH, woodTex);
  drawLeg(-lx, 0,  lz, legW, legH, woodTex);
  drawLeg( lx, 0, -lz, legW, legH, woodTex);
  drawLeg(-lx, 0, -lz, legW, legH, woodTex);

  pushMatrix();
  translate(0, -legH - seatThick/2, 0);
  drawBox(seatW, seatThick, seatD, woodTex);
  popMatrix();
//backrest
  pushMatrix();
  translate(0, -legH - seatThick - backH/2, -seatD/2 + backThick/2);
  drawBox(seatW, backH, backThick, woodTex);
  popMatrix();

  popMatrix();
}


void drawLeg(float x, float baseY, float z, float w, float h, PImage tex) {
  pushMatrix();
  translate(x, -h/2, z); 
  drawBox(w, h, w, tex);
  popMatrix();}

void drawBox(float w, float h, float d, PImage tex) {
  noStroke();
  textureMode(IMAGE);
  beginShape(QUADS);
  texture(tex);
  float hw = w/2, hh = h/2, hd = d/2;
 //Front
  vertex(-hw, -hh,  hd, 0, 0);
  vertex( hw, -hh,  hd, w, 0);
  vertex( hw,  hh,  hd, w, h);
  vertex(-hw,  hh,  hd, 0, h);
 //Back
  vertex( hw, -hh, -hd, 0, 0);
  vertex(-hw, -hh, -hd, w, 0);
  vertex(-hw,  hh, -hd, w, h);
  vertex( hw,  hh, -hd, 0, h);
 //Left
  vertex(-hw, -hh, -hd, 0, 0);
  vertex(-hw, -hh,  hd, d, 0);
  vertex(-hw,  hh,  hd, d, h);
  vertex(-hw,  hh, -hd, 0, h);
 //Right
  vertex( hw, -hh,  hd, 0, 0);
  vertex( hw, -hh, -hd, d, 0);
  vertex( hw,  hh, -hd, d, h);
  vertex( hw,  hh,  hd, 0, h);
 //Top
  vertex(-hw, -hh, -hd, 0, 0);
  vertex( hw, -hh, -hd, w, 0);
  vertex( hw, -hh,  hd, w, d);
  vertex(-hw, -hh,  hd, 0, d);
 //Bottom
  vertex(-hw,  hh,  hd, 0, 0);
  vertex( hw,  hh,  hd, w, 0);
  vertex( hw,  hh, -hd, w, d);
  vertex(-hw,  hh, -hd, 0, d);
  endShape();}

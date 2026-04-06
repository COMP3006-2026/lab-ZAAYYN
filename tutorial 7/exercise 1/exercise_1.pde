PImage[] earthFrames;
PImage moonImg;

int earthFrame = 0;
int totalEarthFrames = 240;           //it uses the all 0 to 239 gif of the earth inside the folder named earth

float moonOrbit = 0;
int earthRadius = 100;
int moonRadius  = 35;
int orbitRadius = 220;

float orbitTiltX = 0.35;
int cx, cy;

void setup() {
  size(800, 600);
  smooth(8);
  cx = width / 2;
  cy = height / 2;
  earthFrames = new PImage[totalEarthFrames];
  for (int i = 0; i < totalEarthFrames; i++) {
    earthFrames[i] = loadImage("earth/" + i + ".gif"); }

  moonImg = loadImage("moon.png");}

void draw() {
  background(5, 8, 20);
//path
  noFill();
  stroke(255, 255, 255, 25);
  strokeWeight(0.8);
  ellipse(cx, cy, orbitRadius * 2, orbitRadius * 2 * sin(HALF_PI - orbitTiltX));

//3D positoin for moon
  float mx = cx + orbitRadius * cos(moonOrbit);
  float my = cy + orbitRadius * sin(moonOrbit) * sin(HALF_PI - orbitTiltX);

  float depthScale = map(sin(moonOrbit), -1, 1, 0.75, 1.25);
  int scaledMoonRadius = (int)(moonRadius * depthScale);

  boolean moonBehind = sin(moonOrbit) < 0;

  if (moonBehind) {
    drawMoon(mx, my, scaledMoonRadius);
  }

  drawEarth();

  if (!moonBehind) {
    drawMoon(mx, my, scaledMoonRadius);
  }

  earthFrame = (earthFrame + 1) % totalEarthFrames;
  moonOrbit += 0.012;
}

void drawEarth() {
  int d = earthRadius * 2;

  PGraphics pg = createGraphics(d, d, JAVA2D);
  pg.smooth(8);
  pg.beginDraw();
  pg.clear();

  PGraphics mask = createGraphics(d, d, JAVA2D);
  mask.smooth(8);
  mask.beginDraw();
  mask.background(0);
  mask.fill(255);
  mask.noStroke();
  mask.ellipse(d / 2, d / 2, d, d);
  mask.endDraw();
  
  pg.imageMode(CENTER);
  pg.image(earthFrames[earthFrame], d / 2, d / 2, d, d);
  pg.mask(mask);
  pg.endDraw();

  imageMode(CENTER);
  image(pg, cx, cy);
}

void drawMoon(float x, float y, int r) {
  int d = r * 2;
  PGraphics pg = createGraphics(d, d, JAVA2D);
  pg.smooth(8);
  pg.beginDraw();
  pg.clear();
  PGraphics mask = createGraphics(d, d, JAVA2D);
  mask.smooth(8);
  mask.beginDraw();
  mask.background(0);
  mask.fill(255);
  mask.noStroke();
  mask.ellipse(d / 2, d / 2, d, d);
  mask.endDraw();

  pg.imageMode(CENTER);
  pg.image(moonImg, d / 2, d / 2, d, d);
  pg.mask(mask);
  pg.endDraw();
  imageMode(CENTER);
  image(pg, x, y);
}

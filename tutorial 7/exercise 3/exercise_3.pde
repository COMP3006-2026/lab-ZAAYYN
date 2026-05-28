float moonOrbit = 0;
float moonOrbitSpeed = 0.008;
int earthRadius = 60;
int moonRadius  = 20;
int orbitRadius = 180;
float orbitTiltX = 0.35;

int cx, cy;

float shuttleT     = 0;
float shuttleSpeed = 0;
float acceleration = 0.0003;
boolean arrived    = false;
int TRAIL = 30;
float[] trailX = new float[TRAIL];
float[] trailY = new float[TRAIL];
int trailCount = 0;

void setup() {
  size(800, 600);
  smooth(8);
  cx = width / 2;
  cy = height / 2;
}

void draw() {
  background(5, 8, 20);
//moon position
  float mx = cx + orbitRadius * cos(moonOrbit);
  float my = cy + orbitRadius * sin(moonOrbit) * sin(HALF_PI - orbitTiltX);
  float depthScale     = map(sin(moonOrbit), -1, 1, 0.75, 1.25);
  int scaledMoonRadius = (int)(moonRadius * depthScale);

//orbit
  noFill();
  stroke(255, 255, 255, 25);
  strokeWeight(0.8);
  ellipse(cx, cy, orbitRadius * 2, orbitRadius * 2 * sin(HALF_PI - orbitTiltX));
//start and end
  float startX = cx + earthRadius * cos(atan2(my - cy, mx - cx));
  float startY = cy + earthRadius * sin(atan2(my - cy, mx - cx));
  float endX   = mx - scaledMoonRadius * cos(atan2(my - cy, mx - cx));
  float endY   = my - scaledMoonRadius * sin(atan2(my - cy, mx - cx));
//curve
  float dx  = endX - startX;
  float dy  = endY - startY;
  float len = sqrt(dx * dx + dy * dy);
  float cpX = (startX + endX) / 2 - dy / len * 80;
  float cpY = (startY + endY) / 2 + dx / len * 80;
//shuttle phs
  if (!arrived) {
    if (shuttleT < 0.5) {
      shuttleSpeed += acceleration;
    } else {
      shuttleSpeed -= acceleration;
      if (shuttleSpeed < 0) shuttleSpeed = 0;
    }
    shuttleT += shuttleSpeed;
    if (shuttleT >= 1.0) {
      shuttleT     = 1.0;
      arrived      = true;
      shuttleSpeed = 0;
    }
  }
//shuttle position
  float sx    = bezierPoint(startX, cpX, cpX, endX, shuttleT);
  float sy    = bezierPoint(startY, cpY, cpY, endY, shuttleT);
  float tx    = bezierTangent(startX, cpX, cpX, endX, shuttleT);
  float ty    = bezierTangent(startY, cpY, cpY, endY, shuttleT);
  float angle = atan2(ty, tx);
//record trail
  if (!arrived) {
    trailX[trailCount % TRAIL] = sx;
    trailY[trailCount % TRAIL] = sy;
    trailCount++;
  }

//exhaust
  for (int i = 0; i < min(trailCount, TRAIL); i++) {
    int idx     = (trailCount - 1 - i + TRAIL) % TRAIL;
    float alpha = map(i, 0, TRAIL, 220, 0);
    float sz    = map(i, 0, TRAIL, 6, 1);
    noStroke();
    fill(255, 160, 60, alpha);
    ellipse(trailX[idx], trailY[idx], sz, sz);
    fill(255, 220, 120, alpha * 0.5);
    ellipse(trailX[idx], trailY[idx], sz * 0.5, sz * 0.5);
  }

//moon and earth
  boolean moonBehind = sin(moonOrbit) < 0;
  if (moonBehind) drawMoon(mx, my, scaledMoonRadius);
  drawEarth();
  if (!moonBehind) drawMoon(mx, my, scaledMoonRadius);
//shuttle
  drawShuttle(sx, sy, angle);

//draw reset
  drawButton();

//moon orbit until arrives
  if (!arrived) moonOrbit += moonOrbitSpeed;
}

void drawButton() {
  boolean hover = mouseX > 650 && mouseX < 780 &&
                  mouseY > 550 && mouseY < 585;
  noStroke();
  fill(hover ? color(60, 130, 255) : color(30, 80, 180));
  rect(650, 550, 130, 35, 8);
  textAlign(CENTER, CENTER);
  textSize(13);
  fill(255);
  text("Launch Again", 715, 567);}

void mousePressed() {
  if (mouseX > 650 && mouseX < 780 &&
      mouseY > 550 && mouseY < 585) {
    resetShuttle(); }
  }
void resetShuttle() {
  shuttleT     = 0;
  shuttleSpeed = 0;
  arrived      = false;
  trailCount   = 0;
  for (int i = 0; i < TRAIL; i++) {
    trailX[i] = 0;
    trailY[i] = 0;}
  moonOrbit += 0.3;
}

void drawEarth() {
  noStroke();
  for (int i = 15; i > 0; i--) {
    fill(30, 80, 200, i * 2);
    ellipse(cx, cy, (earthRadius + i * 2) * 2, (earthRadius + i * 2) * 2); }
  fill(30, 80, 180);
  ellipse(cx, cy, earthRadius * 2, earthRadius * 2);
  fill(50, 140, 60);
  ellipse(cx - 15, cy - 10, 40, 35);
  ellipse(cx + 18, cy + 5,  30, 40);
  ellipse(cx - 5,  cy + 20, 25, 20);
  fill(220, 235, 255, 180);
  ellipse(cx, cy - earthRadius + 8, earthRadius, 14);
  ellipse(cx, cy + earthRadius - 6, earthRadius * 0.7, 10);
  fill(255, 255, 255, 25);
  ellipse(cx - earthRadius * 0.25, cy - earthRadius * 0.25, earthRadius * 1.1, earthRadius);}

void drawMoon(float x, float y, int r) {
  noStroke();
  for (int i = 8; i > 0; i--) {
    fill(180, 180, 200, i * 2);
    ellipse(x, y, (r + i * 2) * 2, (r + i * 2) * 2);
  }
  fill(200, 200, 210);
  ellipse(x, y, r * 2, r * 2);
  fill(170, 170, 178);
  ellipse(x - 5, y - 4, 8, 8);
  ellipse(x + 6, y + 3, 6, 6);
  ellipse(x - 3, y + 6, 5, 5);
  ellipse(x + 2, y - 7, 4, 4);
  fill(255, 255, 255, 30);
  ellipse(x - r * 0.25, y - r * 0.25, r * 0.9, r * 0.8);
}

void drawShuttle(float x, float y, float angle) {
  pushMatrix();
  translate(x, y);
  rotate(angle);

  noStroke();
  fill(255, 100, 30, 180);
  triangle(-18, -4, -18, 4, -28, 0);
  fill(255, 200, 80, 120);
  triangle(-18, -2, -18, 2, -24, 0);

  fill(220, 220, 230);
  beginShape();
  vertex(18,  0);
  vertex(8,  -7);
  vertex(-14, -6);
  vertex(-18, -3);
  vertex(-14,  6);
  vertex(8,   7);
  endShape(CLOSE);

  fill(150, 210, 255, 200);
  ellipse(8, 0, 9, 7);

  fill(180, 180, 195);
  beginShape();
  vertex(2,  -7);
  vertex(-8,  -7);
  vertex(-12, -16);
  vertex(-4,  -16);
  endShape(CLOSE);

  beginShape();
  vertex(2,   7);
  vertex(-8,   7);
  vertex(-12,  16);
  vertex(-4,   16);
  endShape(CLOSE);

  fill(160, 160, 175);
  beginShape();
  vertex(-10, -6);
  vertex(-18, -3);
  vertex(-18, -12);
  endShape(CLOSE);

  stroke(255, 80, 80);
  strokeWeight(1.2);
  line(0, -5, 10, -5);
  line(0,  5, 10,  5);

  popMatrix();
}

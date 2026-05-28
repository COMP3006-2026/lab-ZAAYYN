float moonOrbit = 0;
float moonOrbitSpeed = 0.02;

int earthRadius = 60;
int moonRadius  = 20;
int orbitRadius = 180;
float orbitTiltX = 0.35;

int cx, cy;

//motion blurrrrr
int TRAIL = 20;
float[] trailX = new float[TRAIL];
float[] trailY = new float[TRAIL];

void setup() {
  size(800, 600);
  smooth(8);
  cx = width / 2;
  cy = height / 2;
//starting piint of the trail
  for (int i = 0; i < TRAIL; i++) {
    trailX[i] = cx + orbitRadius;
    trailY[i] = cy;
  }
}

void draw() {
  background(5, 8, 20);

 //path
  noFill();
  stroke(255, 255, 255, 25);
  strokeWeight(0.8);
  ellipse(cx, cy, orbitRadius * 2, orbitRadius*2*sin(HALF_PI - orbitTiltX));

//moon position current
  float mx = cx + orbitRadius * cos(moonOrbit);
  float my = cy + orbitRadius * sin(moonOrbit)*sin(HALF_PI - orbitTiltX);

//depthscale for more feel
  float depthScale = map(sin(moonOrbit),-1, 1, 0.75, 1.25);
  int scaledMoonRadius =(int)(moonRadius * depthScale);

//saving trali adn shift to old ones
  for (int i = TRAIL - 1; i > 0; i--) {
    trailX[i] = trailX[i - 1];
    trailY[i] = trailY[i - 1];
  }
  trailX[0] = mx;
  trailY[0] = my;

//oldest blur to newest
  for (int i = TRAIL - 1; i >= 0; i--) {
    float alpha  = map(i, 0, TRAIL - 1, 200, 0);
    float radius = map(i, 0, TRAIL - 1, scaledMoonRadius, scaledMoonRadius * 0.3);
    noStroke();
    fill(200, 200, 220, alpha);
    ellipse(trailX[i], trailY[i], radius * 2, radius * 2);
  }

//earth
  noStroke();
  fill(30, 80, 180);
  ellipse(cx, cy, earthRadius * 2, earthRadius * 2);

//polising earth
  fill(80, 140, 255, 60);
  ellipse(cx - earthRadius * 0.25, cy - earthRadius * 0.25, earthRadius * 1.1, earthRadius * 1.0);

//moon
  noStroke();
  fill(200, 200, 220);
  ellipse(mx, my, scaledMoonRadius * 2, scaledMoonRadius * 2);
//polising moon
  fill(255, 255, 255, 60);
  ellipse(mx - scaledMoonRadius * 0.25, my - scaledMoonRadius * 0.25, scaledMoonRadius * 0.9, scaledMoonRadius * 0.8);

  moonOrbit += moonOrbitSpeed;
}

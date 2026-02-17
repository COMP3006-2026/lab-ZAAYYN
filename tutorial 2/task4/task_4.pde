void setup() {
  size(600, 400);
}

void draw() {
  background(135, 206, 235);
  drawHuman(100, 200, 60, 120);   //small human
  drawHuman(250, 220, 80, 160);   //Medium humannnn
  drawHuman(450, 250, 100, 200);  //LARGE HUMAN
}

void drawHuman(float x, float y, float w, float h) {
  noStroke();
  rectMode(CENTER);
  float headWidth = w * 0.45;
  float headHeight = h * 0.165;
  float bodyWidth = w * 0.5;
  float bodyHeight = h * 0.35;
  float armWidth = w * 0.2;
  float armHeight = h * 0.35;
  float legWidth = w * 0.2;
  float legHeight = h * 0.3;
  
  float headY = y - h * 0.285;
  float bodyY = y - h * 0.025;
  float armY = y - h * 0.025;
  float legY = y + h * 0.3;
  
  fill(#0eaeae);
  rect(x, bodyY, bodyWidth, bodyHeight);
  
  fill(#c5a295);
  rect(x, headY, headWidth, headHeight);
  
  fill(#6b4f2a);
  rect(x, headY - headHeight * 0.515, headWidth, headHeight * 0.15);
  
  fill(255);
  rect(x - headWidth * 0.22, headY - headHeight * 0.09, headWidth * 0.13, headHeight * 0.21);
  rect(x + headWidth * 0.11, headY - headHeight * 0.09, headWidth * 0.13, headHeight * 0.21);
  
  fill(#68879D);
  rect(x - headWidth * 0.18, headY - headHeight * 0.09, headWidth * 0.07, headHeight * 0.12);
  rect(x + headWidth * 0.18, headY - headHeight * 0.09, headWidth * 0.07, headHeight * 0.12);
  
  fill(120, 60, 60);
  rect(x - headWidth * 0.04, headY + headHeight * 0.27, headWidth * 0.22, headHeight * 0.12);
  
  fill(#c5a295);
  rect(x - bodyWidth * 0.6, armY, armWidth, armHeight);
  rect(x + bodyWidth * 0.6, armY, armWidth, armHeight);
  
  fill(#494697);
  rect(x - bodyWidth * 0.22, legY, legWidth, legHeight);
  rect(x + bodyWidth * 0.22, legY, legWidth, legHeight);
}

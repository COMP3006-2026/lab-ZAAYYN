void setup() {
  size(500, 400);
  background(0,255,255);
}

void draw() {
  stroke(0);
  point(50, 50);
  point(80, 80);

  line(100, 50, 200, 50);

  rect(50, 120, 100, 60);

  ellipse(250, 150, 80, 80);

  ellipse(400, 150, 120, 60);

  triangle(100, 300, 50, 250, 150, 250);

  quad(300, 250, 350, 220, 420, 260, 330, 300);
}

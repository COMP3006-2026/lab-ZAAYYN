void setup() {
  size(300, 300);
}

void draw() {
  background(135, 206, 235);
  noStroke();
  rectMode(CENTER);

  // body
  fill(#0eaeae);
  rect(150, 145, 50, 70);

  // face 
  fill(#c5a295);
  rect(150, 93, 45, 33);

  // hair
  fill(#6b4f2a); 
  rect(150, 76, 45, 5);

  // eyes (outer)
  fill(255);
  rect(140, 90, 6, 7);
  rect(155, 90, 6, 7);

  // eyes (inner)
  fill(#68879D);
  rect(142, 90, 3, 4);
  rect(158, 90, 3, 4);

  // mouth
  fill(120, 60, 60);
  rect(148, 102, 10, 4);

  // arms
  fill(#c5a295);
  rect(120, 145, 20, 70);
  rect(180, 145, 20, 70);

  // legs
  fill(#494697);
  rect(139, 210, 20, 60);
  rect(161, 210, 20, 60);
}

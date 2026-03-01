void setup() {
  size(400, 400);
  noLoop();
}
void draw() {
  background(255);
  
  int squareSize = 50;
  int x = 0;
  
  while (x < width) {
    int y = 0;
    while (y < height) {
      float gray = random(0, 255);
      fill(gray);
      stroke(0);
      rect(x, y, squareSize, squareSize);
      y += squareSize;
                      }
    x += squareSize;
                    }
}

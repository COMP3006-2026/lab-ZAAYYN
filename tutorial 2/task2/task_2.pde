void setup() {
  size(400, 400);
  noLoop();  
}

void draw() {
  background(255);
  
  int squareSize = 50;  // you can change this 

  for (int x = 0; x < width; x += squareSize) {
    for (int y = 0; y < height; y += squareSize) {
        float gray = random(0, 255);
          fill(gray);
      
      stroke(0);
      rect(x, y, squareSize, squareSize);       }
                                                  }
}

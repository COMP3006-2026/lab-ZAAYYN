class Person {
  float x, y;
  float w, h;
  color bodyColor, faceColor, hairColor, eyeColor, mouthColor, armColor, legColor;
  float speedX, speedY;
  
  Person(float x, float y, float w, float h, color bodyColor, color faceColor, color hairColor, color legColor) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.speedX = random(-3, 3);
    this.speedY = random(-3, 3);
    
    this.bodyColor = bodyColor;
    this.faceColor = faceColor;
    this.hairColor = hairColor;
    this.eyeColor = color(104, 135, 157);
    this.mouthColor = color(120, 60, 60);
    this.armColor = faceColor;
    this.legColor = legColor;
  }
  
  void draw() {
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
    
    fill(bodyColor);
    rect(x, bodyY, bodyWidth, bodyHeight);
    
    fill(faceColor);
    rect(x, headY, headWidth, headHeight);
    
    fill(hairColor);
    rect(x, headY - headHeight * 0.515, headWidth, headHeight * 0.15);
    
    fill(255);
    rect(x - headWidth * 0.22, headY - headHeight * 0.09, headWidth * 0.13, headHeight * 0.21);
    rect(x + headWidth * 0.11, headY - headHeight * 0.09, headWidth * 0.13, headHeight * 0.21);
    
    fill(eyeColor);
    rect(x - headWidth * 0.18, headY - headHeight * 0.09, headWidth * 0.07, headHeight * 0.12);
    rect(x + headWidth * 0.18, headY - headHeight * 0.09, headWidth * 0.07, headHeight * 0.12);
    
    fill(mouthColor);
    rect(x - headWidth * 0.04, headY + headHeight * 0.27, headWidth * 0.22, headHeight * 0.12);
    
    fill(armColor);
    rect(x - bodyWidth * 0.6, armY, armWidth, armHeight);
    rect(x + bodyWidth * 0.6, armY, armWidth, armHeight);
    
    fill(legColor);
    rect(x - bodyWidth * 0.22, legY, legWidth, legHeight);
    rect(x + bodyWidth * 0.22, legY, legWidth, legHeight);
  }
  
  void update() {
    x += speedX;
    y += speedY;
  }
  
  void bounce() {
    if (x - w/2 <= 0 || x + w/2 >= width) {
      speedX = -speedX; }
    if (y - h/2 <= 0 || y + h/2 >= height) {
      speedY = -speedY;
                                          }
                        }
}





Person[] people = new Person[10]; //array T_T

void setup() {
  size(800, 600);
  
  people[0] = new Person(100, 150, 60, 120, color(255, 100, 100), color(220, 180, 140), color(50, 30, 10), color(100, 100, 255));
  people[1] = new Person(200, 200, 80, 160, color(100, 200, 100), color(200, 150, 120), color(80, 50, 20), color(150, 100, 200));
  people[2] = new Person(300, 250, 70, 140, color(100, 100, 255), color(210, 170, 130), color(60, 40, 15), color(200, 150, 100));
  people[3] = new Person(400, 300, 90, 180, color(255, 150, 0), color(190, 140, 110), color(70, 45, 25), color(80, 80, 150));
  people[4] = new Person(500, 350, 100, 200, color(200, 100, 200), color(205, 160, 125), color(90, 60, 30), color(120, 120, 180));
  people[5] = new Person(600, 400, 50, 100, color(150, 200, 150), color(215, 175, 135), color(55, 35, 12), color(90, 90, 160));
  people[6] = new Person(700, 150, 110, 220, color(255, 200, 100), color(195, 155, 115), color(75, 50, 22), color(110, 110, 170));
  people[7] = new Person(150, 450, 65, 130, color(180, 120, 180), color(200, 165, 128), color(65, 42, 18), color(130, 130, 190));
  people[8] = new Person(350, 500, 85, 170, color(120, 180, 220), color(208, 168, 132), color(85, 55, 28), color(95, 95, 165));
  people[9] = new Person(550, 250, 95, 190, color(220, 150, 120), color(198, 158, 122), color(72, 48, 20), color(105, 105, 175));
  
  sortHeight();
  
  println("Sorted__by_heightT_T:");
  for (int i = 0; i < people.length; i++) {
    println("Person " + i + ": height = " + people[i].h);
  }
}

void draw() {
  background(135, 206, 235);
  
  for (int i = 0; i < people.length; i++) {
    people[i].update();
    people[i].bounce();
    people[i].draw();
  }
}

void sortHeight() {
  for (int i = 0; i < people.length - 1; i++) {
    for (int j = 0; j < people.length - i - 1; j++) {
      if (people[j].h > people[j + 1].h) {
        Person temp = people[j];
        people[j] = people[j + 1];
        people[j + 1] = temp;
                                          }
                                                        }
                                                    }
}

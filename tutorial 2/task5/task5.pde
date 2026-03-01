class Person {
  float x, y;
  float w, h;
  color bodyColor, faceColor, hairColor, eyeColor, mouthColor, armColor, legColor;
  float speedX, speedY;
  
  Person(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.speedX = 0;
    this.speedY = 0;
    
    this.bodyColor = color(14, 174, 174);
    this.faceColor = color(197, 162, 149);
    this.hairColor = color(107, 79, 42);
    this.eyeColor = color(104, 135, 157);
    this.mouthColor = color(120, 60, 60);
    this.armColor = color(197, 162, 149);
    this.legColor = color(73, 70, 151);
  }
  
  Person(float x, float y, float w, float h, color bodyColor, color faceColor, color hairColor, color legColor) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.speedX = 0;
    this.speedY = 0;
    
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
  
  void moveHorizontal(float speed) {
    this.speedX = speed;
  }
  
  void moveVertical(float speed) {
    this.speedY = speed;
  }
  
  void update() {
    x += speedX;
    y += speedY;
  }
  
  void bounceVertical() {
    if (y - h/2 <= 0 || y + h/2 >= height) {
      speedY = -speedY;
    }
  }
}

Person person1, person2, person3, person4;

void setup() {
  size(800, 600);
  
  person1 = new Person(100, 300, 80, 160);
  
  person2 = new Person(300, 100, 100, 200);
  person2.moveVertical(3);
  
  person3 = new Person(500, 400, 60, 120, color(255, 100, 100), color(220, 180, 140), color(50, 30, 10), color(100, 100, 255));
  
  person4 = new Person(700, 300, 120, 240, color(100, 200, 100), color(200, 150, 120), color(80, 50, 20), color(150, 100, 200));
}

void draw() {
  background(135, 206, 235);
  
  person1.draw();
  person2.update();
  person2.bounceVertical();
  person2.draw();
  person3.draw();
  person4.draw();
}

/*READ!! KINDLY !!
Question 1    line 140
Question 2    line 198
Question 3    line 235
Question 4    line 254
Question 5    line 284
Question 6    line 327
Question 7    line 346
Question 8    line 395
*/
int currentQuestion = -1; //in the menu
int numQuestions = 8;

Button[] buttons;
Button exitButton;
float time = 0; //animation 

void setup() {
  size(800, 600);

  buttons = new Button[numQuestions];
  int cols = 4;
  int buttonWidth = 160;
  int buttonHeight = 90;
  int spacing = 25;
  
  int totalWidth = cols * buttonWidth + (cols - 1) * spacing;
  int startX = (width - totalWidth) / 2;
  int startY = 200;

  for (int i = 0; i < numQuestions; i++) {
    int col = i % cols;
    int row = i / cols;
    int x = startX + col * (buttonWidth + spacing);
    int y = startY + row * (buttonHeight + spacing);
    buttons[i] = new Button(x, y, buttonWidth, buttonHeight, "Question" + (i + 1), i);
  }
  
  exitButton = new Button(30, height - 80, 160, 60, "EXIT", -1, color(255, 0, 0));
}

void draw() {
  time += 0.02;
  
  coolBackground();
  Scanlines();
  RetroText("M.ZAIN KHURRAM", width - 160, 25, 14, color(0, 255, 255));
  
  if (currentQuestion == -1) {
    Menu();
  } else {
    QuestionScreen();
  }
  
  movingBorder();
}

void coolBackground() {
  background(10, 5, 25);
  stroke(50, 20, 80, 100);
  strokeWeight(2);
  for (int i = 0; i < width; i += 40) line(i, 0, i, height);
  for (int i = 0; i < height; i += 40) line(0, i, width, i);
  
  noStroke();
  for (int i = 0; i < 50; i++) {
    float x = (i * 123 + time * 20) % width;
    float y = (i * 456) % height;
    fill(255, 255, 255, 200);
    rect(x, y, (i % 3) + 1, (i % 3) + 1);
  }
}

void Scanlines() {
  stroke(0, 255, 255, 15);
  for (int i = 0; i < height; i += 3) line(0, i, width, i);
}

void movingBorder() {
  noFill();
  strokeWeight(4);
  float offset = sin(time) * 5;

  stroke(255, 0, 255);
  line(10 + offset, 10, 60, 10);
  line(10, 10 + offset, 10, 60);

  stroke(0, 255, 255);
  line(width - 60, 10, width - 10 - offset, 10);
  line(width - 10, 10 + offset, width - 10, 60);

  stroke(255, 255, 0);
  line(10 + offset, height - 10, 60, height - 10);
  line(10, height - 60, 10, height - 10 - offset);

  stroke(0, 255, 0);
  line(width - 60, height - 10, width - 10 - offset, height - 10);
  line(width - 10, height - 60, width - 10, height - 10 - offset);
}

void RetroText(String txt, float x, float y, int size, color c) {
  fill(0);
  textAlign(LEFT, TOP);
  textSize(size);
  text(txt, x + 2, y + 2);

  fill(c, 150);
  text(txt, x - 1, y - 1);
  text(txt, x + 1, y + 1);
  
  fill(c);
  text(txt, x, y);
}

void Menu() {
  float titleY = 80 + sin(time * 2) * 5;
  RetroText("TUTORIAL", width/2 - 100, titleY - 25, 32, color(255, 0, 255));
  RetroText("-- 3 --", width/2 - 60, titleY + 10, 28, color(0, 255, 255));
  RetroText(">> SELECT A QUESTION <<", width/2 - 140, 150, 16, color(255, 255, 0));
  
  for (Button btn : buttons) btn.display();
  exitButton.displayExit();
}

void QuestionScreen() {
  float titleY = 70 + sin(time * 2) * 3;
  RetroText("QUESTION " + (currentQuestion + 1), width/2 - 80, titleY, 32, color(0, 255, 0));
  
  if (currentQuestion == 0) question1();
  else if (currentQuestion == 1) question2();  
  else if (currentQuestion == 2) question3();  
  else if (currentQuestion == 3) question4();
  else if (currentQuestion == 4) question5();
  else if (currentQuestion == 5) question6();
  else if (currentQuestion == 6) question7();
  else if (currentQuestion == 7) question8();
  drawRetroBackButton();
}

//question1
void question1() {
 RetroText(" Rocket using beginShape :) ", 30, 110, 18, color(255,255,0));  
  pushMatrix();
  translate(width/2, height/2 + 20);

  fill(200, 50, 50);
  stroke(150, 30, 30);
  strokeWeight(3);
  beginShape();
  vertex(-40, -80);
  vertex(-40, 80);
  vertex(40, 80);
  vertex(40, -80);
  endShape(CLOSE);

  fill(220, 70, 70);
  beginShape();
  vertex(-40, -80);
  vertex(0, -150);
  vertex(40, -80);
  endShape(CLOSE);

  fill(100, 100, 200);
  stroke(70, 70, 150);
  strokeWeight(2);
  beginShape();
  vertex(-40, 50);
  vertex(-80, 100);
  vertex(-40, 80);
  endShape(CLOSE);

  beginShape();
  vertex(40, 50);
  vertex(80, 100);
  vertex(40, 80);
  endShape(CLOSE);

  fill(100, 200, 255);
  noStroke();
  ellipse(0, -20, 30, 30);

  fill(255, 150, 0);
  stroke(255, 100, 0);
  strokeWeight(2);
  beginShape();
  vertex(-30, 80);
  vertex(-20, 120);
  vertex(-10, 90);
  vertex(0, 130);
  vertex(10, 90);
  vertex(20, 120);
  vertex(30, 80);
  endShape(CLOSE);

  popMatrix();
}

//question2
void question2() {
RetroText("beginShape with loop", 30, 110, 18, color(255,255,0));
  pushMatrix();
  translate(width/2 - 200, height/2 - 120);  

  float startX = 60;
  float baseBottom = 180;
  float baseTop = 130;   
  float peakY = 50;

  float spacing = 35;    
  float triWidth = 31;   
  int spikes = 10;

  fill(255);  
  noStroke();

  beginShape();
  vertex(startX - 40, baseBottom);
  vertex(startX + spikes * spacing + 40, baseBottom);
  vertex(startX + spikes * spacing, baseTop);

  for (int i = spikes - 1; i >= 0; i--) {
    float centerX = startX + i * spacing + spacing/2;

    vertex(centerX + triWidth/2, baseTop);  
    vertex(centerX, peakY);                 
    vertex(centerX - triWidth/2, baseTop);  
  }

  vertex(startX - 40, baseBottom);
  endShape(CLOSE);

  popMatrix();
}

//question 3
void question3(){
RetroText("Shape using bezierVertex()", 30, 110, 18, color(255,255,0));
  pushMatrix();
  translate(width/2, height/2 + 20);

  fill(0, 180, 255);

  beginShape();
  vertex(0, -130);
  bezierVertex(-100, -160, -160, -40, -90, 20);
  bezierVertex(-140, 120, -20, 140, 0, 70);
  bezierVertex(20, 140, 140, 120, 90, 20);
  bezierVertex(160, -40, 100, -160, 0, -130);
  endShape(CLOSE);

  popMatrix();
}

//question4
void question4() {
RetroText("Curve  y = 1 - xpwr4", 30, 110, 18, color(255,255,0));
  pushMatrix();

  float scale = 200;

  stroke(150);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);

  stroke(255);
  noFill();

  beginShape();

  for (float x = -1.5; x <= 1.5; x += 0.01) {

    float y = 1 - pow(x, 4);

    float screenX = width/2 + x * scale;
    float screenY = height/2 - y * scale;

    vertex(screenX, screenY);
  }

  endShape();

  popMatrix();
}
//question5
void question5() {

  pushMatrix();

  float scaleY = 60;

  strokeWeight(2);
  noFill();

  textSize(28);
  fill(255);
  textAlign(LEFT);

  text("SIN :", 40, height/3 - 80);
  stroke(0, 255, 255);
  noFill();

  beginShape();
  for (float x = 0; x < width; x += 1) {
    float angle = x * 0.05;
    float y = sin(angle) * scaleY;
    vertex(x, height/3 - y);
  }
  endShape();


  fill(255);
  text("COS :", 40, 2 * height/3 - 80);

  stroke(255, 0, 255);
  noFill();

  beginShape();
  for (float x = 0; x < width; x += 1) {
    float angle = x * 0.05;
    float y = cos(angle) * scaleY;
    vertex(x, 2 * height/3 - y);
  }
  endShape();

  popMatrix();
}
//question6
void question6() {
RetroText("100 random circles ((gray))", 30, 110, 18, color(255,255,0));
  pushMatrix();

  noStroke();

  for (int i = 0; i < 100; i++) {

    float r = random(10, 80);      
    float x = random(width);      
    float y = random(height);     
    float gray = random(255);      
    fill(gray);
    ellipse(x, y, r, r);
  }

  popMatrix();
}
//question7
void question7() {

  pushMatrix();

  noiseSeed(10);

  loadPixels();

  for (int y = 0; y < height/2; y++) {
    for (int x = 0; x < width; x++) {

      float n = noise(x * 0.01, y * 0.01);
      int c = color(n * 255);

      pixels[y * width + x] = c;
    }
  }

  updatePixels();

  noiseSeed(999);

  loadPixels();

  for (int y = height/2; y < height; y++) {
    for (int x = 0; x < width; x++) {

      float n = noise(x * 0.02, y * 0.02);

      color c;

      if (n < 0.4) c = color(20, 60, 160);      
      else if (n < 0.6) c = color(40, 180, 60);  
      else if (n < 0.8) c = color(140, 120, 80); 
      else c = color(250);                       

      pixels[y * width + x] = c;
    }
  }

  updatePixels();
  RetroText("two 2D patterns", 30, 110, 18, color(255,255,0));
  RetroText("Cloud", 30, height/2 - 20, 16, color(0,255,255));
  RetroText("Terrain(earth)", 30, height - 40, 16, color(0,255,255));

  popMatrix();
}
//question8
void question8() {
RetroText("Graph using lines", 30, 110, 18, color(255,255,0));
  pushMatrix();

  float scale = 200;

  //axis
  stroke(120);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);

  stroke(255);
  strokeWeight(2);

  float prevX = -1.5;
  float prevY = 1 - pow(prevX, 4);

  for (float x = -1.49; x <= 1.5; x += 0.01) {

    float y = 1 - pow(x, 4);

    float screenX1 = width/2 + prevX * scale;
    float screenY1 = height/2 - prevY * scale;

    float screenX2 = width/2 + x * scale;
    float screenY2 = height/2 - y * scale;

    line(screenX1, screenY1, screenX2, screenY2);

    prevX = x;
    prevY = y;
  }

  popMatrix();
}
// BACK BUTTON 
void drawRetroBackButton() {
  float x = 25, y = 25, w = 120, h = 50;

  noFill();
  stroke(0, 255, 255);
  strokeWeight(3);
  rect(x, y, w, h);

  RetroText("<< BACK", x + 20, y + 18, 16, color(255, 255, 0));
}

void mousePressed() {
  if (currentQuestion == -1) {
    for (int i = 0; i < buttons.length; i++)
      if (buttons[i].isMouseOver()) currentQuestion = i;

    if (exitButton.isMouseOver()) exit();
  } 
  else if (mouseX > 25 && mouseX < 145 && mouseY > 25 && mouseY < 75)
    currentQuestion = -1;
}
class Button {
  float x, y, w, h;
  String label;
  int index;
  color buttonColor;

  Button(float x, float y, float w, float h, String label, int index) {
    this.x=x; this.y=y; this.w=w; this.h=h;
    this.label=label; this.index=index;
    color[] colors={color(255,0,255),color(0,255,255),color(255,255,0),
                    color(0,255,0),color(255,100,0),color(100,100,255),
                    color(255,0,100),color(0,255,150)};
    buttonColor = colors[index%8];
  }

  Button(float x,float y,float w,float h,String label,int index,color c){
    this.x=x; this.y=y; this.w=w; this.h=h;
    this.label=label; this.index=index; buttonColor=c;
  }

  void display() {
    fill(10,5,25);
    noStroke();
    rect(x,y,w,h);
    stroke(buttonColor);
    noFill();
    rect(x,y,w,h);

    fill(buttonColor);
    textAlign(CENTER,CENTER);
    textSize(24);
    text(label,x+w/2,y+h/2);
  }

  void displayExit() { display(); }

  boolean isMouseOver() {
    return mouseX>x && mouseX<x+w && mouseY>y && mouseY<y+h;
  }
}

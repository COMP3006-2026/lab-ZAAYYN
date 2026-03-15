/*READ!! KINDLY ! !
Question 1    line 151 - Move 2 shapes with arrow keys
Question 2    line 215 - Drag shapes with mouse
Question 3    line 270 - Read & draw shapes from data.txt
Question 4    line 310 - Three line text editor
Question 5    line 370 - Analog clock
*/
int currentQuestion = -1; //in the menu
int numQuestions = 5;

float x1 = 200, y1 = 300;    //q1 shap1
float x2 = 550, y2 = 300;      //q2 shape 2
int selected = 1;            //shape selecting for q1
float pixelz = 5;            //q1 pixels per click for button

float q2_x1, q2_y1, q2_w1, q2_h1; //q2 rect
float q2_x2, q2_y2, q2_r2;        //q2 radius of circle
int q2_dragging = 0; //q2  choose 1:Rect 2:circle , 0none
float q2_offsetX, q2_offsetY;
boolean q2_initialized = false;

String[] q3_lines;     //q3
boolean q3_loaded = false; //q3 

String[] q4_lines = {"", "", ""}; //q4
int q4_currentLine = 0; //q4
int q4_maxChars = 70; // chars per line before auto_wrap

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
  RetroText("-- 5 --", width/2 - 60, titleY + 10, 28, color(0, 255, 255));
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
 // else if (currentQuestion == 5) question6();
 // else if (currentQuestion == 6) question7();
  //else if (currentQuestion == 7) question8();
  drawRetroBackButton();
}

//////////////////////////////question1
void question1() {
  
  RetroText("2 shaoes are here , you can move with the arrow keys", 30, 110, 13, color(255,255,0));
  RetroText("SELECTED : SHAPE " + selected, 30, 135, 13, color(255,255,0));
  RetroText("1 or 2 to select | arrow keys to move", 30, 158, 11, color(150,150,150));

  
  rectMode(CENTER);
  if (selected == 1) 
{ stroke(255,255,0); strokeWeight(3); } 
  else   
{ stroke(255,0,0,150); strokeWeight(1); }

  fill(255, 0, 0, selected == 1 ? 220 : 120);
  
  rect(x1, y1, 70, 70);
  
  fill(selected == 1 ? color(255,255,0) : color(255,100,100));
  
  textSize(11); textAlign(CENTER);
  text("SHAPE 1", x1, y1 + 48);
  
  rectMode(CORNER);

  if (selected == 2)
{ stroke(255,255,0); strokeWeight(3); }
  else              
{ stroke(0,200,255,150); strokeWeight(1); }

  fill(0, 180, 255, selected == 2 ? 220 : 120);
  
  ellipse(x2, y2, 70, 70);
  
  fill(selected == 2 ? color(255,255,0) : color(100,200,255));
  
  textSize(11); textAlign(CENTER);
  text("SHAPE 2", x2, y2 + 48);

}
void keyPressed() {
  // Question 1
  if (currentQuestion == 0) {
    if (key == '1') selected = 1;
    if (key == '2') selected = 2;
    
    if (keyCode == UP)    { if (selected == 1) y1 -= pixelz; else y2 -= pixelz; }
    if (keyCode == DOWN)  { if (selected == 1) y1 += pixelz; else y2 += pixelz; }
    if (keyCode == LEFT)  { if (selected == 1) x1 -= pixelz; else x2 -= pixelz; }
    if (keyCode == RIGHT) { if (selected == 1) x1 += pixelz; else x2 += pixelz; }
    
    x1 = constrain(x1, 35, width-35);
    y1 = constrain(y1, 35, height-35);
    x2 = constrain(x2, 35, width-35);
    y2 = constrain(y2, 35, height-35);
  }
  
  // Question 4
  if (currentQuestion == 3) {
    if (keyCode == BACKSPACE) {
      if (q4_lines[q4_currentLine].length() > 0) {
        q4_lines[q4_currentLine] = q4_lines[q4_currentLine].substring(0, q4_lines[q4_currentLine].length() - 1);
      } else if (q4_currentLine > 0) {
        q4_currentLine--;
      }
    } 
    else if (keyCode == ENTER || keyCode == RETURN) {
      if (q4_currentLine < 2) q4_currentLine++;
    }
    else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT &&
             keyCode != UP && keyCode != DOWN && keyCode != LEFT && keyCode != RIGHT) {
      if (q4_lines[q4_currentLine].length() < q4_maxChars) {
        q4_lines[q4_currentLine] += key;
      } else if (q4_currentLine < 2) {
        q4_currentLine++;
        q4_lines[q4_currentLine] += key;
      }
    }
  }
}
///////////////////Question 2
void question2(){
if (!q2_initialized) {
    q2_w1 = random(60, 120);
    q2_h1 = random(60, 120);
    q2_x1 = 250;
    q2_y1 = 300;
    q2_r2 = random(30, 70);
    q2_x2 = 550;
    q2_y2 = 300;
    q2_initialized = true;
  }
RetroText("click and drage the shape to move", 30, 110, 13, color(255, 255, 0));
 RetroText("DRAGGING: " + (q2_dragging == 0 ? "NONE" : "SHAPE " + q2_dragging), 30, 135, 13, color(255, 255, 0));

//shape 1 
rectMode(CORNER);
  if (q2_dragging == 1) { stroke(255, 255, 0); strokeWeight(3); }
  else                  { stroke(255, 0, 0, 180); strokeWeight(1); }
  fill(255, 0, 0, q2_dragging == 1 ? 220 : 140);
  rect(q2_x1 - q2_w1/2, q2_y1 - q2_h1/2, q2_w1, q2_h1);
  fill(q2_dragging == 1 ? color(255, 255, 0) : color(255, 120, 120));
  textSize(11); textAlign(CENTER);
  text("SHAPE 1", q2_x1, q2_y1 + q2_h1/2 + 14);
  
  //shape 2 
  if (q2_dragging == 2) { stroke(255, 255, 0); strokeWeight(3); }
  else                  { stroke(0, 200, 255, 180); strokeWeight(1); }
  fill(0, 180, 255, q2_dragging == 2 ? 220 : 140);
  ellipse(q2_x2, q2_y2, q2_r2 * 2, q2_r2 * 2);
  fill(q2_dragging == 2 ? color(255, 255, 0) : color(100, 200, 255));
  textSize(11); textAlign(CENTER);
  text("SHAPE 2", q2_x2, q2_y2 + q2_r2 + 14);
//realtime drag 
if (q2_dragging == 1) {
    q2_x1 = constrain(mouseX + q2_offsetX, q2_w1/2, width - q2_w1/2);
    q2_y1 = constrain(mouseY + q2_offsetY, q2_h1/2, height - q2_h1/2);
  }
if (q2_dragging == 2) {
    q2_x2 = constrain(mouseX + q2_offsetX, q2_r2, width - q2_r2);
    q2_y2 = constrain(mouseY + q2_offsetY, q2_r2, height - q2_r2);
}

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
//default and for q2
void mousePressed() {
  if (currentQuestion == -1) {
    for (int i = 0; i < buttons.length; i++)
      if (buttons[i].isMouseOver()) currentQuestion = i;
    if (exitButton.isMouseOver()) exit();
  } 
  else if (mouseX > 25 && mouseX < 145 && mouseY > 25 && mouseY < 75) {
    currentQuestion = -1;
  }
  else if (currentQuestion == 1) {
    if (mouseX > q2_x1 - q2_w1/2 && mouseX < q2_x1 + q2_w1/2 &&
        mouseY > q2_y1 - q2_h1/2 && mouseY < q2_y1 + q2_h1/2) {
      q2_dragging = 1;
      q2_offsetX = q2_x1 - mouseX;
      q2_offsetY = q2_y1 - mouseY;
    }
    else if (dist(mouseX, mouseY, q2_x2, q2_y2) < q2_r2) {
      q2_dragging = 2;
      q2_offsetX = q2_x2 - mouseX;
      q2_offsetY = q2_y2 - mouseY;
    }
  }
}
//q2
void mouseReleased() {
  if (currentQuestion == 1) q2_dragging = 0;
}
///////////////////////Question 3
void question3() {
  if (!q3_loaded) {
    q3_lines = loadStrings("data.txt");
    q3_loaded = true;
 }

  RetroText("reading shaprs from the text file(data.txt)",width/2 - 130, 110, 13, color(255, 255, 0));
 if (q3_lines == null || q3_lines.length == 0) {
    RetroText("ERROR:file not found!", 30, 160, 14, color(255, 0, 0));
    return;
 }

for (String line : q3_lines) {
    line = line.trim();
  if (line.length() == 0) continue;

   String[] parts = line.split(" ");
   String shapeType = parts[0];
  float[] vals = float(split(parts[1], ","));

   stroke(0, 255, 255);
   strokeWeight(2);
   fill(255, 0, 255, 120);

  if (shapeType.equals("ellipse")) {
  stroke(255, 0, 255);
  strokeWeight(2);
  fill(150, 0, 255, 150);
  ellipse(vals[0], vals[1], vals[2], vals[3]);
} 
else if (shapeType.equals("line")) {
  stroke(0, 255, 255);
  strokeWeight(3);
  line(vals[0], vals[1], vals[2], vals[3]);
} 
else if (shapeType.equals("rect")) {
  stroke(255, 255, 0);
  strokeWeight(2);
  fill(255, 100, 0, 120);
  rectMode(CORNER);
  rect(vals[0], vals[1], vals[2], vals[3]);
}
}
}
////////////////Question4
void question4() {
  RetroText("THREE_LINE TEXT EDITOR", 30, 110, 13, color(255, 255, 0));
  RetroText("Type whatever | ENTER = next line | BACKSPACE = delete/back-line", 30, 132, 11, color(150, 150, 150));

  for (int i = 0; i < 3; i++) {
    float bx = 60;
    float by = 200 + i * 100;
    float bw = 680;
    float bh = 60;

    //highlight active ones
    if (i == q4_currentLine) {
      fill(0, 255, 255, 20);
      stroke(0, 255, 255);
      strokeWeight(2);
    } else {
      noFill();
      stroke(100, 100, 150);
      strokeWeight(1);
    }
    rect(bx, by, bw, bh);


    RetroText("LINE " + (i + 1), 65, by + 8, 10, color(100, 100, 180));

 
    fill(255, 255, 255);
    textSize(18);
    textAlign(LEFT, CENTER);
    text(q4_lines[i], bx + 10, by + bh / 2);
//blinking animation for active one
    if (i == q4_currentLine && frameCount % 30 < 15) {
      float cursorX = bx + 10 + textWidth(q4_lines[i]);
      stroke(0, 255, 255);
      strokeWeight(2);
      line(cursorX, by + 12, cursorX, by + bh - 12);
    }
  }

//live status check
  if (q4_currentLine >= 2 && q4_lines[2].length() >= q4_maxChars) {
    RetroText(">> EDITOR FULL <<", width/2 - 80, 530, 14, color(255, 0, 0));
  } else {
    RetroText("Line " + (q4_currentLine + 1) + " | Chars: " + q4_lines[q4_currentLine].length() + "/" + q4_maxChars, 
              60, 530, 12, color(100, 200, 100));
  }
}
///////////////////////////////Question5 
void question5() {
  RetroText("ANALOG CLOCK", width/2 - 70, 110, 13, color(255, 255, 0));

  float cx = width / 2;
  float cy = height / 2 + 20;
  float r = 180;

 //clock
  stroke(0, 255, 255);
  strokeWeight(2);
  fill(10, 5, 25, 220);
  ellipse(cx, cy, r*2, r*2);

  //markers
  for (int i = 0; i < 12; i++) {
    float angle = map(i, 0, 12, -HALF_PI, TWO_PI - HALF_PI);
    float x1m = cx + cos(angle) * (r - 20);
    float y1m = cy + sin(angle) * (r - 20);
    float x2m = cx + cos(angle) * (r - 8);
    float y2m = cy + sin(angle) * (r - 8);
    stroke(0, 255, 255);
    strokeWeight(i % 3 == 0 ? 3 : 1);
    line(x1m, y1m, x2m, y2m);
  }

  //current time
  float s = second();
  float m = minute() + s / 60.0;
  float h = hour() % 12 + m / 60.0;

  // Angles starts from half pi so 12 is at top
  float secAngle  = map(s, 0, 60,  -HALF_PI, TWO_PI - HALF_PI);
  float minAngle  = map(m, 0, 60,  -HALF_PI, TWO_PI - HALF_PI);
  float hourAngle = map(h, 0, 12,  -HALF_PI, TWO_PI - HALF_PI);

  //Hour
  stroke(255, 100, 0);
  strokeWeight(6);
  line(cx, cy, cx + cos(hourAngle) * (r * 0.5), cy + sin(hourAngle) * (r * 0.5));

  //Minute 
  stroke(0, 255, 100);
  strokeWeight(4);
  line(cx, cy, cx + cos(minAngle) * (r * 0.75), cy + sin(minAngle) * (r * 0.75));

  //Second 
  stroke(255, 0, 100);
  strokeWeight(2);
  line(cx, cy, cx + cos(secAngle) * (r * 0.88), cy + sin(secAngle) * (r * 0.88));

  fill(255, 255, 0);
  noStroke();
  ellipse(cx, cy, 10, 10);

  // Legend
RetroText("HOUR",   width/2 - 120, 530, 11, color(255, 100, 0));
RetroText("MINUTE", width/2 - 10,  530, 11, color(0, 255, 100));
RetroText("SECOND", width/2 + 120, 530, 11, color(255, 0, 100));
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

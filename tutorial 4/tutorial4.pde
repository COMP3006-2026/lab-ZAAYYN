/*READ!! KINDLY !!
Question 1    line 150
Question 2    line 190
Question 3    line 338
Question 4    line 395
Question 5    line 457
Question 6    line 520
Question 7    line 564
Question 8    line 617
*/
int currentQuestion = -1; //in the menu
int numQuestions = 8;
int q2Mode = 0;
Button q2ToggleBtn;

String currentInput = "";   ///for q6
boolean isFloat = false;    ///for q6
PrintWriter outputFile;      ///for q6
String lastSaved = "";       ///for q6

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
q2ToggleBtn = new Button(620, 25, 155, 45, "OPTION A", 0, color(0, 255, 255));////q2

 outputFile = createWriter("test.txt");                                   ////q6
 
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
  RetroText("-= 4 =-", width/2 - 60, titleY + 10, 28, color(0, 255, 255));
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

///////////////////////////////////////////////////////////////////////////////question1
void question1() {
  RetroText("Translate() with 4 Rectangles", 20, 80, 18, color(255,255,0));

  pushMatrix();
  translate(100, 150);  //  origin
  drawAxes();
  rectMode(CENTER);
  noStroke();

  // all 4 stacked at same position
  fill(255, 0, 0);     rect(0, 0, 60, 60);
  fill(0, 255, 0);     rect(0, 0, 60, 60);
  fill(0, 0, 255);     rect(0, 0, 60, 60);
  fill(150, 150, 150); rect(0, 0, 60, 60);

  fill(255, 255, 255, 180);
  textSize(9); textAlign(CENTER);
  text("all 4 here\n(0,0)", 0, -42);

  // red
  pushMatrix();
    translate(200, 100);
    fill(255, 0, 0);
    rect(0, 0, 60, 60);
    fill(255, 100, 100);
    textSize(9); textAlign(CENTER);
    text("RED\n(200,100)", 0, -42);
  popMatrix();

  // green
  pushMatrix();
    translate(400, 100);
    fill(0, 255, 0);
    rect(0, 0, 60, 60);
    fill(100, 255, 100);
    textSize(9); textAlign(CENTER);
    text("GREEN\n(400,100)", 0, -42);
  popMatrix();

  // blue
  pushMatrix();
    translate(200, 300);
    fill(0, 0, 255);
    rect(0, 0, 60, 60);
    fill(100, 150, 255);
    textSize(9); textAlign(CENTER);
    text("BLUE\n(200,300)", 0, -42);
  popMatrix();

  // gray
  pushMatrix();
    translate(400, 300);
    fill(150, 150, 150);
    rect(0, 0, 60, 60);
    fill(200, 200, 200);
    textSize(9); textAlign(CENTER);
    text("GRAY\n(400,300)", 0, -42);
  popMatrix();

  rectMode(CORNER);
  popMatrix();
}

//////////////////////////////////////////////////////////////////////question2
void question2() {
q2ToggleBtn.label = (q2Mode == 0) ? "CLICK FOR optB" : "CLICK FOR optA";
  q2ToggleBtn.buttonColor = (q2Mode == 0) ? color(0, 255, 255) : color(255, 0, 255);
  q2ToggleBtn.display();

  if (q2Mode == 0) question2_optionA();
  else             question2_optionB();
}

/////// OPTION A 

void question2_optionA() {
  RetroText("Option A : rearrange 3, keep GRAY at (400,400)", 30, 110, 14, color(0,255,255));
  pushMatrix();
  translate(100, 150);   
  drawAxes();
  rectMode(CENTER);
  noStroke();

  // gray
  pushMatrix();
    translate(400, 400);
    fill(150, 150, 150);
    rect(0, 0, 60, 60);
    fill(200, 200, 200);
    textSize(9); textAlign(CENTER);
    text("GRAY\n(400,400)", 0, -52);
  popMatrix();

  // red
  pushMatrix();
    translate(500, 50);
    fill(255, 0, 0);
    rect(0, 0, 60, 60);
    fill(255, 100, 100);
    textSize(9); textAlign(CENTER);
    text("RED\n(500,50)", 0, -52);
  popMatrix();

  // green
  pushMatrix();
    translate(50, 200);
    fill(0, 255, 0);
    rect(0, 0, 60, 60);
    fill(100, 255, 100);
    textSize(9); textAlign(CENTER);
    text("GREEN\n(50,200)", 0, -52);
  popMatrix();

  // blue
  pushMatrix();
    translate(250, 220);
    fill(0, 0, 255);
    rect(0, 0, 60, 60);
    fill(100, 150, 255);
    textSize(9); textAlign(CENTER);
    text("BLUE\n(250,220)", 0, -52);
  popMatrix();

  rectMode(CORNER);
  popMatrix();
}

////////OPTION B 

void question2_optionB() {
  RetroText("Option B : different rearrangement, GRAY still at (400,400)", 30, 110, 14, color(255,0,255));
  pushMatrix();
  translate(100, 150);  
  drawAxes();
  rectMode(CENTER);
  noStroke();

  // gray
  pushMatrix();
    translate(400, 400);
    fill(150, 150, 150);
    rect(0, 0, 60, 60);
    fill(200, 200, 200);
    textSize(9); textAlign(CENTER);
    text("GRAY\n(400,400)", 0, -52);
  popMatrix();

  // red
  pushMatrix();
    translate(100, 100);
    fill(255, 0, 0);
    rect(0, 0, 60, 60);
    fill(255, 100, 100);
    textSize(9); textAlign(CENTER);
    text("RED\n(100,100)", 0, -52);
  popMatrix();

  // green
  pushMatrix();
    translate(480, 200);
    fill(0, 255, 0);
    rect(0, 0, 60, 60);
    fill(100, 255, 100);
    textSize(9); textAlign(CENTER);
    text("GREEN\n(480,200)", 0, -52);
  popMatrix();

  // blue
  pushMatrix();
    translate(100, 370);
    fill(0, 0, 255);
    rect(0, 0, 60, 60);
    fill(100, 150, 255);
    textSize(9); textAlign(CENTER);
    text("BLUE\n(100,370)", 0, -52);
  popMatrix();

  rectMode(CORNER);
  popMatrix();
}

void drawAxes() {
  strokeWeight(1);
  stroke(255, 80, 80);
  line(0, 0, 600, 0);
  fill(255, 80, 80); noStroke();
  triangle(603, 0, 595, -5, 595, 5);
  RetroText("X", 608, -8, 12, color(255, 80, 80));
  stroke(80, 255, 80);
  line(0, 0, 0, 420);
  fill(80, 255, 80); noStroke();
  triangle(0, 424, -5, 416, 5, 416);
  RetroText("Y", -8, 428, 12, color(80, 255, 80));
  stroke(255, 80, 80, 150); strokeWeight(1);
  for (int i = 100; i <= 500; i += 100) {
    line(i, -5, i, 5);
    fill(255, 80, 80, 180);
    textSize(10); textAlign(CENTER);
    text(i, i, 15);
  }
  stroke(80, 255, 80, 150);
  for (int i = 100; i <= 400; i += 100) {
    line(-5, i, 5, i);
    fill(80, 255, 80, 180);
    textSize(10); textAlign(RIGHT);
    text(i, -10, i + 4);
  }
  fill(255, 255, 255, 180);
  textSize(10); textAlign(LEFT);
  text("(0,0)", 5, -8);
}
/////////////////////////////////////////////////////////////////////////////////question 3
void question3() {
  RetroText("rotate() on the 4 Rectangles from Q1", 30, 110, 18, color(255,255,0));

  pushMatrix();
  translate(100, 150);
  drawAxes();
  rectMode(CENTER);
  noStroke();

  // red rotated 45 degrees
  pushMatrix();
    translate(200, 200);
    rotate(radians(45));
    fill(255, 0, 0);
    rect(0, 0, 60, 60);
    fill(255, 100, 100);
    textSize(9); textAlign(CENTER);
    text("RED\nrotate(45)", 0, -52);
  popMatrix();

  // green rotated 90 degrees
  pushMatrix();
    translate(400, 200);
    rotate(radians(90));
    fill(0, 255, 0);
    rect(0, 0, 60, 60);
    fill(100, 255, 100);
    textSize(9); textAlign(CENTER);
    text("GREEN\nrotate(90)", 0, -52);
  popMatrix();

  // blue rotated 135 degrees
  pushMatrix();
    translate(200, 400);
    rotate(radians(135));
    fill(0, 0, 255);
    rect(0, 0, 60, 60);
    fill(100, 150, 255);
    textSize(9); textAlign(CENTER);
    text("BLUE\nrotate(135)", 0, -52);
  popMatrix();

  // gray rotated 180 degrees 
  pushMatrix();
    translate(400, 400);
    rotate(radians(180));
    fill(150, 150, 150);
    rect(0, 0, 60, 60);
    fill(200, 200, 200);
    textSize(9); textAlign(CENTER);
    text("GRAY\nrotate(180)", 0, -52);
  popMatrix();

  rectMode(CORNER);
  popMatrix();
}
///////////////////////////////////////////////////////////////////////////////////////question4
void question4() {
  RetroText("scale() on GREEN rect - for loop", 30, 110, 18, color(255,255,0));

  pushMatrix();
  translate(width/2, height/2 + 30);
  drawAxes2();
  rectMode(CENTER);
  noStroke();

  for (int i = 5; i >= 1; i--) {
    pushMatrix();
      float s = i * 0.4;
      scale(s);
      fill(0, 255 - i * 30, 0, 180);
      rect(0, 0, 60, 60);
      fill(100, 255, 100);
      textSize(10 / s);
      textAlign(CENTER);
      text("scale(" + s + ")", 0, -38 / s);
    popMatrix();
  }

  rectMode(CORNER);
  popMatrix();
}

void drawAxes2() {
  strokeWeight(1);

  stroke(255, 80, 80);
  line(-width/2, 0, width/2, 0);
  fill(255, 80, 80); noStroke();
  triangle(width/2, 0, width/2 - 8, -5, width/2 - 8, 5);
  RetroText("X", width/2 + 5, -8, 12, color(255, 80, 80));

  stroke(80, 255, 80);
  line(0, -height/2, 0, height/2);
  fill(80, 255, 80); noStroke();
  triangle(0, -height/2, -5, -height/2 + 8, 5, -height/2 + 8);
  RetroText("Y", -8, -height/2 - 18, 12, color(80, 255, 80));

  stroke(255, 80, 80, 150); strokeWeight(1);
  for (int i = -300; i <= 300; i += 100) {
    line(i, -5, i, 5);
    fill(255, 80, 80, 180);
    textSize(10); textAlign(CENTER);
    text(i, i, 15);
  }

  stroke(80, 255, 80, 150);
  for (int i = -200; i <= 200; i += 100) {
    line(-5, i, 5, i);
    fill(80, 255, 80, 180);
    textSize(10); textAlign(RIGHT);
    text(i, -10, i + 4);
  }

  fill(255, 255, 255, 180);
  textSize(10); textAlign(LEFT);
  text("(0,0)", 5, -8);
}
//////////////////////////////////////////////////////////////////////////////////////////////question5
void question5() {
  RetroText("translate() + rotate() on shape 1 and 2", 30, 110, 18, color(255,255,0));
  pushMatrix();
  translate(100, 150);
  drawAxes();
  rectMode(CENTER);

  //SHAPE 1(RED)original
  pushMatrix();
    translate(150, 200);
    noFill();
    stroke(255, 0, 0, 120);
    strokeWeight(1);
    rect(0, 0, 60, 60);
    fill(255, 100, 100);
    noStroke();
    textSize(9); textAlign(CENTER);
    text("RED original", 0, -75);
  popMatrix();

  //SHAPE 1(RED) rotated 45° its own axis
  pushMatrix();
    translate(150, 200);   
    rotate(radians(45));  
    fill(255, 0, 0);
    noStroke();
    rect(0, 0, 60, 60);
    fill(255, 100, 100);
    textSize(9); textAlign(CENTER);
    text("RED\nrotate(45)\ncentre", 0, -90);
  popMatrix();

  // SHAPE 2 (GREEN)original
  pushMatrix();
    translate(350, 200);
    rectMode(CORNER);
    noFill();
    stroke(0, 255, 0, 120);
    strokeWeight(1);
    rect(0, 0, 60, 60);
    fill(100, 255, 100);
    noStroke();
    textSize(9); textAlign(CENTER);
    text("GREEN original", 30, -25);
  popMatrix();

  //SHAPE 2 (GREEN)rotated 90degree topleft corner
  pushMatrix();
    translate(350, 200);   
    rotate(radians(90));   
    rectMode(CORNER);
    fill(0, 255, 0);
    noStroke();
    rect(0, 0, 60, 60);
    fill(100, 255, 100);
    textSize(9); textAlign(CENTER);
    text("GREEN\nrotate(90)\nTOPleft", 30, -25);
  popMatrix();

  rectMode(CORNER);
  popMatrix();
}
/////////////////////////////////////////////////////////////////////////question6
void question6() {
  RetroText("Type numbers,      SPACE to save,      ENTER to exit", 30, 110, 14, color(255,255,0));
  RetroText("Current writings : " + currentInput, 30, 150, 14, color(255,255,255));
  RetroText("Type is       : " + (isFloat ? "FLOAT" : "INTEGER"), 30, 175, 14, color(255,0,255));
  if (lastSaved.length() > 0) {
    RetroText("Last saved    : [" + lastSaved + "]", 30, 200, 14, color(0,255,0));
  }
}
void keyPressed() {
  if (currentQuestion != 5) return;

  if ((key >= '0' && key <= '9') || (key == '-' && currentInput.length() == 0)) {
    currentInput += key;
  }
  else if (key == '.' && !currentInput.contains(".")) {
    currentInput += key;
    isFloat = true; }
  else if (key == BACKSPACE && currentInput.length() > 0) {
    currentInput = currentInput.substring(0, currentInput.length() - 1);
    isFloat = currentInput.contains(".");
  }
  else if (key == ' ' && currentInput.length() > 0) {
    String formatted = "";
    if (isFloat) {
      float val = float(currentInput);
      formatted = String.format("%10.4f", val);
    } else {
      int val = int(currentInput);
      formatted = String.format("%10d", val);
    }
    outputFile.println(formatted);
    outputFile.flush();        
    lastSaved = formatted;     
    currentInput = "";
    isFloat = false;
  }
  else if (key == ENTER || key == RETURN) {
    outputFile.flush();
    outputFile.close();
    exit();
  }
}

///////////////////////////////////////////////////////////////////////question7
void question7() {
  RetroText("Reading T4q7.csv", 30, 110, 18, color(255,255,0));

  String[] lines = loadStrings("T4q7.csv");

  int males       = 0;
  int females     = 0;
  int bornAfter2003 = 0;

 
  for (int i = 2; i < lines.length; i++) {
    if (lines[i].trim().length() == 0) continue;  

    String[] cols = lines[i].split(",");

    if (cols.length < 6) continue;  

    String gender = cols[4].trim();
    int birthYear = int(cols[5].trim());

    if (gender.equalsIgnoreCase("Male"))   males++;
    if (gender.equalsIgnoreCase("Female")) females++;
    if (birthYear > 2003)                  bornAfter2003++;
  }

  // display results
  int total = males + females;

  RetroText("Total people   : " + total,          30, 160, 16, color(255,255,255));
  RetroText("Males          : " + males,           30, 190, 16, color(100,180,255));
  RetroText("Females        : " + females,         30, 220, 16, color(255,100,200));
  RetroText("Born after 2003: " + bornAfter2003,   30, 250, 16, color(0,255,180));

  //simple bar chart
  float barW = 300;

  //males bar
  stroke(100,180,255); strokeWeight(2);
  fill(100,180,255,180); noStroke();
  rect(30, 290, map(males, 0, total, 0, barW), 30);
  RetroText("M " + males, 30 + map(males,0,total,0,barW) + 8, 293, 13, color(100,180,255));

  //females bar
  fill(255,100,200,180);
  rect(30, 330, map(females, 0, total, 0, barW), 30);
  RetroText("F " + females, 30 + map(females,0,total,0,barW) + 8, 333, 13, color(255,100,200));

  //born after 2003 
  fill(0,255,180,180);
  rect(30, 370, map(bornAfter2003, 0, total, 0, barW), 30);
  RetroText("After(2003) " + bornAfter2003, 30 + map(bornAfter2003,0,total,0,barW) + 8, 373, 13, color(0,255,180));
}
////////////////////////////////////////////////////////////////////////question8
void question8() {
  RetroText("T4q8.csv Subtotals:Weekday,Saturday,Sunday", 30, 110, 13, color(255,255,0));
  String[] lines = loadStrings("T4q8.csv");
 
  String[] headers = lines[0].split(",");
  int numQuarters = headers.length - 1;
  String[] quarters = new String[numQuarters];
  for (int i = 0; i < numQuarters; i++) {
    quarters[i] = headers[i + 1].trim();
  }

  int[] weekday  = new int[numQuarters];
  int[] saturday = new int[numQuarters];
  int[] sunday   = new int[numQuarters];

  for (int i = 1; i < lines.length; i++) {
    String line = lines[i].trim();
    if (line.startsWith("Subtotal - weekday")) {
      String[] cols = line.split(",");
      for (int j = 0; j < numQuarters; j++) weekday[j]  = int(cols[j+1].trim());
    }
    if (line.startsWith("Subtotal - Saturday")) {
      String[] cols = line.split(",");
      for (int j = 0; j < numQuarters; j++) saturday[j] = int(cols[j+1].trim());
    }
    if (line.startsWith("Subtotal - Sunday")) {
      String[] cols = line.split(",");
      for (int j = 0; j < numQuarters; j++) sunday[j]   = int(cols[j+1].trim());
    }
  }

  int maxVal = 0;
  for (int i = 0; i < numQuarters; i++) {
    maxVal = max(maxVal, max(weekday[i], max(saturday[i], sunday[i])));
  }

  float maxRadius = 45;
  float startX    = 90;
  float spacingX  = (width - startX - 40) / numQuarters;

  float rowWeekday  = 250;
  float rowSaturday = 380;
  float rowSunday   = 500;

  // labels aligned to row Y positions on the left
  RetroText("WEEKDAY",  30, rowWeekday  - 8, 11, color(100, 180, 255));
  RetroText("SATURDAY", 30, rowSaturday - 8, 11, color(255, 180, 100));
  RetroText("SUNDAY",   30, rowSunday   - 8, 11, color(180, 100, 255));

  for (int i = 0; i < numQuarters; i++) {
    float cx = startX + i * spacingX + spacingX / 2;

    fill(255, 255, 255, 180);
    textSize(9); textAlign(CENTER);
    text(quarters[i], cx, 185);

    // weekday blue
    float rW = sqrt(float(weekday[i]) / maxVal) * maxRadius;
    noStroke();
    fill(100, 180, 255, 180);
    ellipse(cx, rowWeekday, rW*2, rW*2);
    fill(200, 230, 255);
    textSize(8); textAlign(CENTER);
    text(weekday[i], cx, rowWeekday + rW + 10);

    // saturday orange
    float rSat = sqrt(float(saturday[i]) / maxVal) * maxRadius;
    fill(255, 180, 100, 180);
    ellipse(cx, rowSaturday, rSat*2, rSat*2);
    fill(255, 220, 180);
    textSize(8); textAlign(CENTER);
    text(saturday[i], cx, rowSaturday + rSat + 10);

    // sunday purple
    float rSun = sqrt(float(sunday[i]) / maxVal) * maxRadius;
    fill(180, 100, 255, 180);
    ellipse(cx, rowSunday, rSun*2, rSun*2);
    fill(220, 180, 255);
    textSize(8); textAlign(CENTER);
    text(sunday[i], cx, rowSunday + rSun + 10);
  }

  RetroText("circle size proportional to value", 30, 555, 11, color(150,150,150));
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
     else if (currentQuestion == 1) {
    if (q2ToggleBtn.isMouseOver()) q2Mode = (q2Mode == 0) ? 1 : 0;
  }
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

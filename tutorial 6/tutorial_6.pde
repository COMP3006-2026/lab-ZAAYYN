/*READ!! KINDLY!!
Question 1             line 135 
Question 2              line 182
Question 3              line 249
Question 4              line  292
Question 5               line  348
*/
int currentQuestion = -1;
int numQuestions = 5;


float time = 0;
Button[] buttons;
Button exitButton;

//Q1
PImage q1_imgA, q1_imgB, q1_canvas;
boolean q1_loaded = false;

//Q2
PImage q2_original, q2_rotated, q2_display;
boolean q2_loaded = false;
int q2_imgX, q2_imgY;

//Q3
PImage q3_img;
boolean q3_loaded   = false;
boolean q3_selecting  = false;
boolean q3_hasCopy    = false;
boolean q3_waitPaste  = false;
int q3_selX, q3_selY, q3_selW, q3_selH;
int q3_imgX = 100, q3_imgY = 130;
PImage q3_copied;

//Q4
PImage q4_src, q4_result;
boolean q4_loaded = false;

//Q5
String[] q5_lines       = {"", "", ""};
int      q5_currentLine = 0;
int      q5_maxChars    = 60;
int      q5_textSize    = 18;
boolean  q5_strikethrough = false;

void setup() {
  size(800, 600);
  textFont(createFont("Monospaced", 14));

  buttons  = new Button[numQuestions];
  int cols = 4, bW = 160, bH = 90, sp = 25;
  int totalW = cols * bW + (cols - 1) * sp;
  int startX = (width - totalW) / 2, startY = 200;

  for (int i = 0; i < numQuestions; i++) {
    int col = i % cols, row = i / cols;
    buttons[i] = new Button(startX + col*(bW+sp), startY + row*(bH+sp),
                            bW, bH, "Question " + (i+1), i);
  }
  exitButton = new Button(30, height-80, 160, 60, "EXIT", -1, color(255,0,0));
}


void draw() {
  time += 0.02;
  coolBackground();
  Scanlines();
  RetroText("M.ZAIN KHURRAM", width-160, 25, 14, color(0,255,255));

  if (currentQuestion == -1) Menu();
  else                        QuestionScreen();

  movingBorder();
}


void coolBackground() {
  background(10, 5, 25);
  stroke(50, 20, 80, 100); strokeWeight(2);
  for (int i = 0; i < width;  i += 40) line(i, 0, i, height);
  for (int i = 0; i < height; i += 40) line(0, i, width, i);
  noStroke();
  for (int i = 0; i < 50; i++) {
    float x = (i*123 + time*20) % width;
    float y = (i*456) % height;
    fill(255, 255, 255, 200);
    rect(x, y, (i%3)+1, (i%3)+1);
  }
}
void Scanlines() {
  stroke(0, 255, 255, 15);
  for (int i = 0; i < height; i += 3) line(0, i, width, i);
}
void movingBorder() {
  noFill(); strokeWeight(4);
  float o = sin(time)*5;
  stroke(255,0,255);   line(10+o,10,60,10);       line(10,10+o,10,60);
  stroke(0,255,255);   line(width-60,10,width-10-o,10); line(width-10,10+o,width-10,60);
  stroke(255,255,0);   line(10+o,height-10,60,height-10); line(10,height-60,10,height-10-o);
  stroke(0,255,0);     line(width-60,height-10,width-10-o,height-10); line(width-10,height-60,width-10,height-10-o);
}
void RetroText(String txt, float x, float y, int sz, color c) {
  fill(0); textAlign(LEFT,TOP); textSize(sz); text(txt, x+2, y+2);
  fill(c,150); text(txt, x-1, y-1); text(txt, x+1, y+1);
  fill(c);     text(txt, x, y);
}


void Menu() {
  float ty = 80 + sin(time*2)*5;
  RetroText("TUTORIAL",           width/2-100, ty-25,  32, color(255,0,255));
  RetroText("-- 6 --",            width/2-60,  ty+10,  28, color(0,255,255));
  RetroText(">> SELECT A QUESTION <<", width/2-140, 150, 16, color(255,255,0));
  for (Button b : buttons) b.display();
  exitButton.displayExit();
}
void QuestionScreen() {
  float ty = 70 + sin(time*2)*3;
  RetroText("QUESTION "+(currentQuestion+1), width/2-80, ty, 32, color(0,255,0));
  
  if   
  (currentQuestion == 0) question1();
  else if (currentQuestion == 1) question2();
  else if (currentQuestion == 2) question3();
  else if (currentQuestion == 3) question4();
  else if (currentQuestion == 4) question5();
  drawRetroBackButton();
}
void drawRetroBackButton() {
  noFill(); stroke(0,255,255); strokeWeight(3);
  rect(25, 25, 120, 50);
  RetroText("<< BACK", 45, 43, 16, color(255,255,0));
}

//Qestion1`````````````````````````````````````````````````````````````````````
void question1() {
  if (!q1_loaded) {
    q1_imgA = loadImage("imgA.jpg");
    q1_imgB = loadImage("imgB.jpg");
    if (q1_imgA == null || q1_imgB == null) {
      RetroText("Place imgA.jpg and imgB.jpg in the sketch folder!", 60, 150, 13, color(255,0,0));
      return;
    }
    q1_imgA.resize(300, 220);
    q1_imgB.resize(300, 220);
    q1_canvas = createImage(300, 220, RGB);
    q1_loaded = true;
  }
  if (q1_imgA == null || q1_imgB == null) {
    RetroText("Place imgA.jpg and imgB.jpg in the sketch folder!", 60, 150, 13, color(255,0,0));
    return;
  }

 //left to right
  int splitX = (int) map(mouseX, 0, width, 0, 300);
  splitX = constrain(splitX, 0, 300);

//copy left from imageA
  if (splitX > 0)
    q1_canvas.copy(q1_imgA, 0, 0, splitX, 220, 0, 0, splitX, 220);
//copy right from imageB
  if (splitX < 300)
    q1_canvas.copy(q1_imgB, splitX, 0, 300-splitX, 220, splitX, 0, 300-splitX, 220);

  int cx = width/2 - 150, cy = 150;
  image(q1_canvas, cx, cy);


  noFill(); stroke(0,255,255); strokeWeight(2);
  rect(cx, cy, 300, 220);
 
  RetroText("imgA", cx+10, cy+5, 11, color(255,200,0));
  RetroText("imgB", cx+230, cy+5, 11, color(0,200,255));

  stroke(255,255,0); strokeWeight(2);
  line(cx+splitX, cy, cx+splitX, cy+220);

  RetroText("Move your mouse to left OR right to see the 2 images", 100, 390, 13, color(255,255,0));
  RetroText("Split at pixel: " + splitX, 310, 415, 12, color(150,255,150));
}

//Question2```````````````````````````````````````````````````````````````````````
PImage rotateCW90(PImage src) {
  PImage dst = createImage(src.height, src.width, RGB);
  src.loadPixels(); dst.loadPixels();
  for (int y = 0; y < src.height; y++)
    for (int x = 0; x < src.width; x++)
      dst.pixels[x * dst.width + (dst.width - 1 - y)] = src.pixels[y * src.width + x];
  dst.updatePixels();
  return dst;
}

void question2() {
  if (!q2_loaded) {
    q2_original = loadImage("imgA.jpg");
    if (q2_original == null) {
      RetroText("Place imgA.jpg in the sketch folder!", 60, 150, 13, color(255,0,0));
      return;
    }
    q2_original.resize(260, 200);
    q2_rotated  = rotateCW90(q2_original);
    q2_display  = q2_rotated.copy();
    q2_loaded   = true;
  }
  if (q2_original == null) {
    RetroText("Place imgA.jpg in the sketch folder!", 60, 150, 13, color(255,0,0));
    return;
  }

  //centreing the image
  q2_imgX = width/2  - q2_display.width/2;
  q2_imgY = height/2 - q2_display.height/2 + 20;

  //rebuling each frame
  q2_display = q2_rotated.copy();

  //mouse checking
  if (mouseX >= q2_imgX && mouseX < q2_imgX + q2_display.width &&
      mouseY >= q2_imgY && mouseY < q2_imgY + q2_display.height) {

    int focusSize = 50;
    int lx = mouseX - q2_imgX - focusSize/2;
    int ly = mouseY - q2_imgY - focusSize/2;

    q2_display.loadPixels();
    for (int fy = max(0,ly); fy < min(q2_display.height, ly+focusSize); fy++) {
      for (int fx = max(0,lx); fx < min(q2_display.width, lx+focusSize); fx++) {
        int idx = fy * q2_display.width + fx;
        color c  = q2_display.pixels[idx];
        float r  = min(255, red(c)   * 1.6);
        float g  = min(255, green(c) * 1.6);
        float b  = min(255, blue(c)  * 1.6);
        q2_display.pixels[idx] = color(r, g, b);
      } }
    q2_display.updatePixels();

    noFill(); stroke(255,255,0); strokeWeight(2);
    rect(q2_imgX + lx, q2_imgY + ly, focusSize, focusSize);
  }

  image(q2_display, q2_imgX, q2_imgY);
  noFill(); stroke(0,255,255); strokeWeight(2);
  rect(q2_imgX, q2_imgY, q2_display.width, q2_display.height);

  RetroText("Image rotated 90 degrees clockwise", 240, 115, 13, color(255,255,0));
  RetroText("hover your mouse over the image to see the highlighted area 50x50", 160, 133, 12, color(150,255,150));
}

//Question3`````````````````````````````````````````````````````````````
void question3() {
  if (!q3_loaded) {
    q3_img = loadImage("imgA.jpg");
    if (q3_img == null) {
      RetroText("Place imgA.jpg in the sketch folder!", 60, 150, 13, color(255,0,0));
      return;
    }
    q3_img.resize(500, 320);
    q3_loaded = true;
  }
  if (q3_img == null) {
    RetroText("Place imgA.jpg in the sketch folder!", 60, 150, 13, color(255,0,0));
    return;
  }

  image(q3_img, q3_imgX, q3_imgY);
  noFill(); stroke(0,255,255); strokeWeight(1);
  rect(q3_imgX, q3_imgY, q3_img.width, q3_img.height);

  if (q3_selecting) {
    int curW = mouseX - q3_selX;
    int curH = mouseY - q3_selY;
    noFill(); stroke(255,255,0); strokeWeight(2);
    rect(q3_selX, q3_selY, curW, curH);
  }

  if (q3_hasCopy && !q3_selecting) {
    noFill(); stroke(255,255,0,180); strokeWeight(1);
    rect(q3_selX, q3_selY, q3_selW, q3_selH);
  }

  //Status
  if (!q3_hasCopy) {
    RetroText("Click and drag on the image to select an area", 120, 115, 13, color(255,255,0));
  } else if (q3_waitPaste) {
    RetroText("CLICK anywhere to PASTE the copied area", 160, 115, 13, color(0,255,150));
    RetroText("Copied: " + q3_selW + " x " + q3_selH + " px", 310, 133, 12, color(150,150,255));
  } else {
    RetroText("Drag to select again, or paste is done!", 160, 115, 13, color(150,255,255));
  }
}

//Question4`````````````````````````````````````````````````````````````````````````````
void question4() {
  if (!q4_loaded) {
    q4_src = loadImage("imgA.jpg");
    if (q4_src == null) {
      RetroText("Place imgA.jpg in the sketch folder!", 60, 150, 13, color(255,0,0));
      return;
    }
    q4_src.resize(480, 300);

    q4_result = q4_src.copy();
    q4_result.loadPixels();

    int totalPx  = q4_result.width * q4_result.height;
    int quarter  = totalPx / 4;

    //red tint to image
    for (int i = 0; i < totalPx; i++) {
      color c = q4_result.pixels[i];
      q4_result.pixels[i] = color(
        min(255, red(c) + 80),
        max(0, green(c) - 30),
        max(0, blue(c)  - 30)
      );
    }

    //replcae last to first quater
    for (int i = 0; i < quarter; i++) {
      q4_result.pixels[totalPx - quarter + i] = q4_result.pixels[i];
    }

    q4_result.updatePixels();
    q4_loaded = true;
  }
  if (q4_src == null) {
    RetroText("Place imgA.jpg in the sketch folder!", 60, 150, 13, color(255,0,0));
    return;
  }

  int ix = width/2 - q4_result.width/2;
  int iy = 145;
  image(q4_result, ix, iy);

  int totalPx = q4_result.width * q4_result.height;
  int quarter  = totalPx / 4;
  int splitRow = (totalPx - quarter) / q4_result.width;
  stroke(255,255,0); strokeWeight(2);
  line(ix, iy + splitRow, ix + q4_result.width, iy + splitRow);

  noFill(); stroke(0,255,255); strokeWeight(1);
  rect(ix, iy, q4_result.width, q4_result.height);

  RetroText("Red tint applied ", 230, 115, 13, color(255,100,100));
  RetroText("Yellow line = start of last quarter (replaced by first quarter)", 100, 460, 12, color(255,255,0));
}

//Qestion5````````````````````````````````````````````````````````````````
void question5() {

  // [A+]  [A-]  [S~]
  float btnY  = 115;
  float btnH  = 36;
  float btnW  = 90;

  //A+
  drawQ5Btn(60,  btnY, btnW, btnH, "A+  SIZE",  color(0,255,150));
  //A- 
  drawQ5Btn(160, btnY, btnW, btnH, "A-  SIZE",  color(255,150,0));
  //Strikethrough 
  color sCol = q5_strikethrough ? color(255,80,80) : color(180,180,255);
  drawQ5Btn(260, btnY, btnW, btnH, q5_strikethrough ? "STRIKE ON" : "STRIKE OFF", sCol);

  RetroText("Size: " + q5_textSize + "  |  Strike: " + (q5_strikethrough?"ON":"OFF"),
            370, btnY+8, 13, color(255,255,0));

  RetroText("Type | ENTER=next line | BACKSPACE=delete", 60, 163, 11, color(150,150,150));

  for (int i = 0; i < 3; i++) {
    float bx = 60, by = 195 + i * 105, bw = 680, bh = 70;

    if (i == q5_currentLine) {
      fill(0,255,255,20); stroke(0,255,255); strokeWeight(2);
    } else {
      noFill(); stroke(100,100,150); strokeWeight(1);
    }
    rect(bx, by, bw, bh);
    RetroText("LINE "+(i+1), 65, by+6, 10, color(100,100,180));
   
    fill(255);
    textSize(q5_textSize);
    textAlign(LEFT, CENTER);
    text(q5_lines[i], bx+10, by + bh/2);

    if (q5_strikethrough && q5_lines[i].length() > 0)
    {
      float tw = textWidth(q5_lines[i]);
      float midY = by + bh/2;
      stroke(255, 80, 80); strokeWeight(2);
      line(bx+10, midY, bx+10+tw, midY);   }
    if (i == q5_currentLine && frameCount % 30 < 15) {
      float cursorX = bx + 10 + textWidth(q5_lines[i]);
      stroke(0,255,255); strokeWeight(2);
      line(cursorX, by+12, cursorX, by+bh-12);
    }
  }


  if (q5_currentLine >= 2 && q5_lines[2].length() >= q5_maxChars) {
    RetroText(">> EDITOR FULL <<", width/2-80, 545, 14, color(255,0,0));
  } else {
    RetroText("Line "+(q5_currentLine+1)+" | Chars: "+q5_lines[q5_currentLine].length()+"/"+q5_maxChars,
              60, 545, 12, color(100,200,100));
  }
}

void drawQ5Btn(float x, float y, float w, float h, String lbl, color c) {
  fill(10,5,25); noStroke(); rect(x,y,w,h);
  stroke(c); noFill(); rect(x,y,w,h);
  fill(c); textAlign(CENTER,CENTER); textSize(11);
  text(lbl, x+w/2, y+h/2);
}


void mousePressed() {
  
  if (currentQuestion == -1) {
    for (int i = 0; i < buttons.length; i++)
      if (buttons[i].isMouseOver()) currentQuestion = i;
    if (exitButton.isMouseOver()) exit();
    return;
  }

  
  if (mouseX > 25 && mouseX < 145 && mouseY > 25 && mouseY < 75) {
    currentQuestion = -1;
    return;
  }

  // Q3
  if (currentQuestion == 2) 
  {
   if(q3_loaded && q3_img != null)
   {
      if (q3_waitPaste)
      {
 
        q3_img.copy(q3_copied, 0, 0, q3_copied.width, q3_copied.height,
                    mouseX - q3_imgX - q3_copied.width/2,
                    mouseY - q3_imgY - q3_copied.height/2,
                    q3_copied.width, q3_copied.height);
        q3_waitPaste = false;
        q3_hasCopy   = false;
      } else {
       
        q3_selecting = true;
        q3_selX = mouseX;
        q3_selY = mouseY;
      }
    }
  }

  //Q5button
  if (currentQuestion == 4) {
    //A+
    if (mouseX>=60 && mouseX<=150 && mouseY>=115 && mouseY<=151)
      q5_textSize = min(36, q5_textSize + 2);
    //A-
    if (mouseX>=160 && mouseX<=250 && mouseY>=115 && mouseY<=151)
      q5_textSize = max(10, q5_textSize - 2);
    // Strikethrough
    if (mouseX>=260 && mouseX<=350 && mouseY>=115 && mouseY<=151)
      q5_strikethrough = !q5_strikethrough;
  }
}

void mouseReleased() {
  // Q3
  if (currentQuestion == 2 && q3_selecting && q3_loaded && q3_img != null) {
    q3_selecting = false;
    int rx = min(q3_selX, mouseX);
    int ry = min(q3_selY, mouseY);
    int rw = abs(mouseX - q3_selX);
    int rh = abs(mouseY - q3_selY);

    int imgRight  = q3_imgX + q3_img.width;
    int imgBottom = q3_imgY + q3_img.height;
    rx = constrain(rx, q3_imgX, imgRight);
    ry = constrain(ry, q3_imgY, imgBottom);
    rw = constrain(rw, 0, imgRight  - rx);
    rh = constrain(rh, 0, imgBottom - ry);

    if (rw > 5 && rh > 5) {
      q3_selX = rx; q3_selY = ry;
      q3_selW = rw; q3_selH = rh;

      q3_copied = createImage(rw, rh, RGB);
      q3_copied.copy(q3_img,
                     rx - q3_imgX, ry - q3_imgY, rw, rh,
                     0, 0, rw, rh);
      q3_hasCopy   = true;
      q3_waitPaste = true;
    }
  }
}

void keyPressed() {
  // Q5editor
  if (currentQuestion == 4) {
    if (keyCode == BACKSPACE) {
      if (q5_lines[q5_currentLine].length() > 0) {
        q5_lines[q5_currentLine] = q5_lines[q5_currentLine].substring(0, q5_lines[q5_currentLine].length()-1);
      } else if (q5_currentLine > 0) {
        q5_currentLine--;
      }
    } else if (keyCode == ENTER || keyCode == RETURN) {
      if (q5_currentLine < 2) q5_currentLine++;
    } else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT &&
               keyCode != UP    && keyCode != DOWN    &&
               keyCode != LEFT  && keyCode != RIGHT) {
      if (q5_lines[q5_currentLine].length() < q5_maxChars) {
        q5_lines[q5_currentLine] += key;
      } else if (q5_currentLine < 2) {
        q5_currentLine++;
        q5_lines[q5_currentLine] += key;
      }
    }
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
    color[] cols = {color(255,0,255),color(0,255,255),color(255,255,0),
                    color(0,255,0),  color(255,100,0),color(100,100,255),
                    color(255,0,100),color(0,255,150)};
    buttonColor = cols[index % 8];
  }
  Button(float x,float y,float w,float h,String label,int index,color c){
    this.x=x;this.y=y;this.w=w;this.h=h;
    this.label=label;this.index=index;buttonColor=c;
  }
  void display() {
    fill(10,5,25); noStroke(); rect(x,y,w,h);
    stroke(buttonColor); noFill(); rect(x,y,w,h);
    fill(buttonColor); textAlign(CENTER,CENTER); textSize(18);
    text(label, x+w/2, y+h/2);
  }
  void displayExit() { display(); }
  boolean isMouseOver() {
    return mouseX>x && mouseX<x+w && mouseY>y && mouseY<y+h;
  }
}

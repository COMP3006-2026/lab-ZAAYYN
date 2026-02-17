class Button{
float x,y,w,h; String label;
color greycolor,hovercolor;

  
Button(float x,float y,float w,float h, color hovercolor, String label ){
    this.x= x;
    this.y=y;
    this.w=w;
    this.h=h;
    this.greycolor= color(128);
    this.hovercolor= hovercolor;
    this.label= label; }
  
boolean isMouse(){
    return mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y + h;
  }
  
  void display(){
    if(isMouse()){
      fill(hovercolor);
    }
    else{
      fill(greycolor);
    }
    
    stroke(0);
    strokeWeight(2);
    rect(x, y, w, h);
    
    
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(16);
    text(label, x + w/2, y + h/2);
  }
}

Button button1, button2, button3;

void setup() {
  size(600, 400);
  button1 = new Button(150, 100, 120, 60, color(255, 0, 0), "Button 1");
  button2 = new Button(150, 180, 120, 60, color(0, 255, 0), "Button 2");
  button3 = new Button(150, 260, 120, 60, color(0, 0, 255), "Button 3");
}

void draw() {
  background(220);
  
  fill(0);
  textAlign(CENTER);
  textSize(24);
  text("Roll-over effects of buttons", width/2, 40);
  
  textSize(14);
  text("move your cursor on the button and see the magic ", width/2, 350);
  
  button1.display();
  button2.display();
  button3.display();
  
  textAlign(LEFT);
  textSize(12);
  fill(0);
  text("Mouse Position: (" + mouseX + ", " + mouseY + ")", 350, 120);
  
  String hover = "Hovering None";
  
  if (button1.isMouse()) {
    hover = "On (Red) button ";  } else if (button2.isMouse()) {
    hover = "On (Green) button ";  } else if (button3.isMouse()) {
    hover= "On (Blue) button "; }
  text(hover, 350, 140);
}

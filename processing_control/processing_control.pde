import processing.serial.*;

Serial mySerial;

int x = 0;
int y = 0;
boolean ledon = true;
int windowsizex = 500;
int windowsizey = 500;

int currentMode = 0;
String[] modeNames = {"Mouse Click","Mouse Alw."};


void setup() {
  size (500, 500);
  
  
   String myPort = Serial.list() [0];
   mySerial = new Serial(this, myPort, 9600);
}

void draw() {
  x = int(map(mouseX, 0, width, 0, 180));
  y = int(map(mouseY, 0, height-height/10, 180, 0));
  
  if(mouseY < height-height/10){
    if(currentMode == 1) {
  mySerial.write("SERVOS "+x+" "+y+"\r\n");
    }
  }

  drawgui();
}

void mousePressed() {
  if(mouseY < height-height/10){
    if(currentMode == 0) {
  mySerial.write("SERVOS "+x+" "+y+"\r\n");
    }
  }
  //checks LED On Button
  if(mouseX > 0 && mouseX < width/5 && mouseY < height && mouseY > height-height/10) {
    if(ledon) {
    mySerial.write("LED "+1+"\r\n");
    } else {
    mySerial.write("LED "+0+"\r\n");
    }
    ledon = !ledon;
  }
  
  //checks MODE Button
   if(mouseX > width/5 && mouseX < width/5*2 && mouseY < height && mouseY > height-height/10) {
     if(currentMode >= modeNames.length-1) {
       currentMode = 0;
     } else {
    currentMode ++;
     }
   }
   

   
    
       }
    

  
void drawgui() {
  background(0);
  fill(200);
  
  
  noStroke();
  rect(0,height-height/10,width,height); //draw button bar
  
  if(!ledon){
    fill(255);
    fill(255,0,0);   
  } else {
    fill(255); 
    fill(50,0,0);
    
  }
  //draw LED button
  rect(0,height-height/10,width/5,height/10); 
  textSize(15);
  fill(255);
  text("LED On: "+!ledon, width/100, height-height/25);
   
  //draw MODE button
  fill(255);
  rect(width/5,height-height/10,width/5,height/10); 
  fill(0);
  text("M: "+modeNames[currentMode], width/5 + width/100, height-height/25);
  
  stroke(255);
  line(width/2,0,width/2,height/10*9);
  line(0,(height-height/10)/2,width,(height-height/10)/2);
}

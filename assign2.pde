PImage bgImag;
PImage soilImag;
PImage lifeImag;
PImage cabbageImag;
PImage gameoverImag;
PImage groundhogDownImag;
PImage groundhogIdleImag;
PImage groundhogLeftImag;
PImage groundhogRightImag;
PImage soldierImag;
PImage restartHoveredImag;
PImage restartNormalImag;
PImage startHoveredImag;
PImage startNormalImag;
PImage titleImag;//begin
int x = 0;//the soldier walk and go back use
int lightPos = 240;//the lightpos shoot and go back

int xpos = 240;
int ypos = 70;

void setup() {
  
  size(600,480,P2D);
  bgImag = loadImage("img\bg.jpg");
  soilImag = loadImage("img\soil.png");
  lifeImag = loadImage("img\life.png");
  cabbageImag = loadImage("img\cabbage.png");
  gameoverImag = loadImage("img\gameover.jpg");
  groundhogDownImag = loadImage("img\groundhogDown.png");
  groundhogIdleImag = loadImage("img\groundhogIdle.png");
  groundhogLeftImag = loadImage("img\groundhogLeft.png");
  groundhogRightImag = loadImage("img\groundhogRight.png");
  soldierImag = loadImage("img\soldier.png");
  restartHoveredImag = loadImage("img\restartHovered.png");
  restartNormalImag = loadImage("img\restartNormal.png");
  startHoveredImag = loadImage("img\startHovered.png");
  startNormalImag = loadImage("img\startNormal.png");
  titleImag = loadImage("img\title.jpg");
  
  
  soldierImag = loadImage("img\soldier.png");
  smooth();
}
void keyPressed() {
  
}

void draw() {
  
  image(bgImag, 0, 0);
  strokeWeight(15.0);//The above is the code for the grass. I put it here because it will block the groundhog's feet.
  strokeCap(SQUARE);
  stroke(124,204,25);
    line(0, 152, 800, 152);
    
  image(soilImag,0,160);
  image(lifeImag,10,10);
  image(lifeImag,80,10);
  image(cabbageImag,240,240);
  image(soldierImag,x,160);
  //image(titleImag,0,0);
  //simage(startHoveredImag,248,360);
  
  
  image(groundhogIdleImag,xpos,ypos);
  if(keyPressed){
   if (key == 'w') {
      ypos -= 2;
    }
   if(key == 's'){
       ypos += 2;
   }
   if(key == 'a'){
       xpos -= 2;
   }
   if(key == 'd'){
       xpos += 2;
   }
   
  }
  strokeWeight(10.0);//There code are used to let the lightPos can be action
    strokeCap(ROUND);
    stroke(255,0,0);//color
    
     x=x+2  ;//let the soldier action
    if(x>640){//let the soldier go back to the original location
     x = -80;
  }
    stroke(255,255,0);//the sun outside color
    fill(253,184,19);//the sun inside color
    ellipse(520, 30, 160,160);//the sun size and location
}

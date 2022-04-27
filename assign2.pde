PImage backImg;
PImage titleImg;
PImage gameOverImg;
PImage startB;
PImage startBH;
PImage resetB;
PImage resetBH;
PImage soilImg;
PImage heartImg;
PImage hogImg;
PImage hogDownImg;
PImage hogRightImg;
PImage hogLeftImg;
PImage soldierImg;
PImage cabbageImg;
float soldierX,soldierY,hogX,hogY,cabX,cabY;
final int HOGIDLE=0,HOGDOWN=1,HOGLEFT=2,HOGRIGHT=3;
final int GAMESTART=0,GAMERUN=1,GAMEOVER=2;
final int BTNWIDTH=160,BTNHEIGHT=90;
final int BLOCK=80;
boolean b;
int lifeCount,timer,gameStat,hogStat;

void setup() {
  size(640, 480, P2D);

  //Load Images
  backImg = loadImage("img/bg.jpg");//Background
  titleImg = loadImage("img/title.jpg");//titleimg
  gameOverImg = loadImage("img/gameover.jpg");//Gameover
  startB = loadImage("img/startNormal.png");//startBtn
  startBH = loadImage("img/startHovered.png");//hovered
  resetB = loadImage("img/restartNormal.png");//resetBtn
  resetBH = loadImage("img/restartHovered.png");//hovered
  soilImg = loadImage("img/soil.png");//soil
  heartImg = loadImage("img/life.png");//heart
  hogImg = loadImage("img/groundhogIdle.png");//hog
  hogDownImg = loadImage("img/groundhogDown.png");//hog
  hogLeftImg = loadImage("img/groundhogLeft.png");//hog
  hogRightImg = loadImage("img/groundhogRight.png");//hog
  soldierImg = loadImage("img/soldier.png");//soldier
  cabbageImg = loadImage("img/cabbage.png");//cabbage
  
  gameStat=GAMESTART;//set game stat
  
}

void draw() {
  // Switch Game State
  switch(gameStat){
    case GAMESTART:// Game Start
      image(titleImg,0,0);//draw titlebg
      
      if(mouseX>248&&mouseX<248+BTNWIDTH&&mouseY>360&&mouseY<360+BTNHEIGHT){//The start button change
        image(startBH,248,360);
      }else{
        image(startB,248,360);
      }
      
      break;
    case GAMERUN:// Game Run

        image(backImg,0,0);//Background        
        image(soilImg,0,160);//Soil
        noStroke();//Grass
        fill(124,204,25);//green
        rect(0,160,640,-15);//grass
        
        //Draw HP
        for(int i=0;i<lifeCount;i++)
        {
          image(heartImg,10+i*70,10);
        }
        

        stroke(255,255,0);//sun outside color
        strokeWeight(5);//sun Weight to 5
        fill(253,184,19);//set Sun color
        ellipse(590,50,120,120);//Draw Sun
        
        //check timer
        if(timer==15){//the groundHog move
          hogStat=HOGIDLE;
          if(hogY%BLOCK<30){
            hogY=hogY-hogY%BLOCK;
          }else{
            hogY=hogY-hogY%BLOCK+BLOCK;
          }
          if(hogX%BLOCK<30){
            hogX=hogX-hogX%BLOCK;
          }else{
            hogX=hogX-hogX%BLOCK+BLOCK;
          }
          println(hogX);
          println(hogY);
          timer=0;
        }
        
        //Hog
        switch(hogStat){
          case HOGIDLE:
            image(hogImg,hogX,hogY);
            break;
          case HOGDOWN:
            image(hogDownImg,hogX,hogY);
            timer+=1;
            hogY+=80.0/15;
            break;
          case HOGRIGHT:
            image(hogRightImg,hogX,hogY);
            timer+=1;
            hogX+=80.0/15;
            break;
          case HOGLEFT:
            image(hogLeftImg,hogX,hogY);
            timer+=1;
            hogX-=80.0/15;
            break;
        }
        
        //check timer
        if(timer==15){
          hogStat=HOGIDLE;
          if(hogY%BLOCK<30){//fix float point offset
            hogY=hogY-hogY%BLOCK;
          }else{
            hogY=hogY-hogY%BLOCK+BLOCK;
          }
          if(hogX%BLOCK<30){
            hogX=hogX-hogX%BLOCK;
          }else{
            hogX=hogX-hogX%BLOCK+BLOCK;
          }

          timer=0;
        }
        

        //Soldier
        image(soldierImg,soldierX-80,soldierY);//Draw Soldier
        soldierX+=3;//Move Soldier
        soldierX%=720;
        
        //Cab
        if(b){
          image(cabbageImg,cabX,cabY);
        
          //Cab collision detect
          if(hogX<cabX+BLOCK&&hogX+BLOCK>cabX&&hogY<cabY+BLOCK&&hogY+BLOCK>cabY){
            b=false;
            lifeCount++;
          }
        }
        
        //soldier collision detect
        if(hogX<soldierX-80+BLOCK&&hogX+BLOCK>soldierX-80&&hogY<soldierY+BLOCK&&hogY+BLOCK>soldierY){
          lifeCount--;
          hogStat=HOGIDLE;
          
          //hog pos
          hogX=4*BLOCK;
          hogY=BLOCK;
        }
        
        
        //game over
        if(lifeCount==0){
          gameStat=GAMEOVER;
        }
        
        break;
    case GAMEOVER:// Game Lose
      image(gameOverImg,0,0);//OVERbg
      
      if(mouseX>248&&mouseX<248+BTNWIDTH&&mouseY>360&&mouseY<360+BTNHEIGHT){//if hovered
        image(resetBH,248,360);
      }else{
        image(resetB,248,360);
      }
      break;
  }
}

void keyPressed(){
  if(key ==CODED){
    switch(keyCode){
      case DOWN:
        if(hogY+BLOCK<height&&hogStat==HOGIDLE){
          hogStat=HOGDOWN;
          timer=0;
        }
        break;
      case RIGHT:
        if(hogX+BLOCK<width&&hogStat==HOGIDLE){
          hogStat=HOGRIGHT;
          timer=0;
        }
        break;
      case LEFT:
        if(hogX>0&&hogStat==HOGIDLE){
          hogStat=HOGLEFT;
          timer=0;
        }
        break;
    }
  }
      
}

void keyReleased(){
}

void mouseClicked(){
  if(mouseX>248&&mouseX<248+BTNWIDTH&&mouseY>360&&mouseY<360+BTNHEIGHT&&(gameStat==GAMESTART||gameStat==GAMEOVER)){//if hovered
    //soldier coordinate
    soldierX=0;
    soldierY=BLOCK*(int(random(4)+2));
    
    //Cabbage coordinate
    cabX=BLOCK*int(random(8));
    cabY=BLOCK*(int(random(4))+2);
    
    //Cabbage Stat boolean
    b=true;
    
    //Life count
    lifeCount=2;
    
    //hog pos
    hogX=4*BLOCK;
    hogY=BLOCK;
    
    //hog stat
    hogStat=HOGIDLE;
    
    //START GAME
    gameStat=GAMERUN;
  }
}

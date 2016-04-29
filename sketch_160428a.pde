/********* VARIABLES *********/

// We control which screen is active by settings / updating
// gameScreen variable. We display the correct screen according
// to the value of this variable.
// 
// 0: Initial Screen
// 1: Game Screen
// 2: Game-over Screen 

int gameScreen = 0;
// scoring
int score = 0;
// walls settings
float wallsSpeed = 4;
int wallsInterval = 3000;
float lastAddTime = 0;
int minGapHeight = 200;
int maxGapHeight = 300;
int wallsWidth = 80;
color wallsColors = color(44, 62, 80);

/********* SETUP BLOCK *********/

void setup() {
  size(1280, 720);
  frameRate(60)
  ;
}


/********* DRAW BLOCK *********/

void draw() {
  // Display the contents of the current screen
  if (gameScreen == 0) { 
    initScreen();
  } else if (gameScreen == 1) { 
    gameScreen();
  } else if (gameScreen == 2) { 
    gameOverScreen();
  }
}


/********* SCREEN CONTENTS *********/

void initScreen() {
  background(236, 240, 241);
  textAlign(CENTER);
  fill(52, 73, 94);
  textSize(70);
  text("Mathpack OperationRide", width/2, height/2);
  textSize(15); 
  text("Click to Math", width/2, height-30);
}
void gameScreen() {
  background(236, 240, 241);
  wallAdder();
  wallHandler();
}
void gameOverScreen() {
  background(44, 62, 80);
  textAlign(CENTER);
  fill(236, 240, 241);
  textSize(12);
  text("Your Score", width/2, height/2 - 120);
  textSize(130);
  text(score, width/2, height/2);
  textSize(15);
  text("Click to Restart", width/2, height-30);
}


/********* INPUTS *********/

public void mousePressed() {
  // if we are on the initial screen when clicked, start the game 
  if (gameScreen==0) { 
    startGame();
  }
  if (gameScreen==2) {
    restart();
  }
}


/********* OTHER FUNCTIONS *********/

// This method sets the necessery variables to start the game  
void startGame() {
  gameScreen=1;
}
void gameOver() {
  gameScreen=2;
}
ez
void restart() {
  score = 0;

  lastAddTime = 0;

  gameScreen = 1;
}

class walls {
  add;
}
void wallAdder() {
  if (millis()-lastAddTime > wallsInterval) {
    int randHeight = round(random(minGapHeight, maxGapHeight));
    int randY = round(random(0, height-randHeight));
    // {gapWallX, gapWallY, gapWallWidth, gapWallHeight, scored}
    int[] randWall = {width, randY, wallsWidth, randHeight, 0}; 
    walls.add(randWall);
    lastAddTime = millis();
  }
}
void wallHandler() {
  for (int i = 0; i < walls.size(); i++) {
    wallRemover(i);
    wallMover(i);
    wallDrawer(i);

  }
}
void wallDrawer(int index) {
  int[] wall = walls.get(index);
  // get gap wall settings 
  int gapWallX = wall[0];
  int gapWallY = wall[1];
  int gapWallWidth = wall[2];
  int gapWallHeight = wall[3];
  // draw actual walls
  rectMode(CORNER);
  noStroke();
  strokeCap(ROUND);
  fill(wallsColors);
  rect(gapWallX, 0, gapWallWidth, gapWallY, 0, 0, 15, 15);
  rect(gapWallX, gapWallY+gapWallHeight, gapWallWidth, height-(gapWallY+gapWallHeight), 15, 15, 0, 0);
}
void wallMover(int index) {
  int[] wall = walls.get(index);
  wall[0] -= wallsSpeed ;
}
void wallRemover(int index) {
  int[] wall = walls.get(index);
  if (wall[0]+wall[2] <= 0) {
    walls.remove(index);
    ;
  }
}

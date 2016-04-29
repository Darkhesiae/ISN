//Définition des variables
int minGapHeight = 100;
int maxGapHeight = 200;
int wallsWidth = 80;
float wallSpeed = 2;
float lastAddTime = 0;
int wallsInterval = 6000;
int gameScreen = 0;
int score = 0;
color curseurColor = color(0);
int curseurSize = 40;
int curseurX, curseurY;
int curseurVitesse = 40;
float lastInput = 0;

//Définition des tableaux
ArrayList<int[]> walls = new ArrayList<int[]>();
ArrayList<int[]> numbers = new ArrayList<int[]>();
ArrayList<int[]> signs = new ArrayList<int[]>();

//Définition de l'affichage général
void setup() {
  size(853, 480);
  frameRate(60);
}

//Boucles du jeu
void draw() {
  if (gameScreen == 0) {
    initScreen();
  } else if (gameScreen == 1) {
    gameScreen();
  } else if (gameScreen == 2) { 
    gameOverScreen();
  }
}

//Définition de l'écran d'initialisation
void initScreen() {
  background(236, 240, 241);
  textAlign(CENTER);
  fill(52, 73, 94);
  textSize(70);
  text("Mathpack OperationRide", width/2, height/2);
  textSize(15); 
  text("Click to Math", width/2, height-30);
}

//Définition de l'écran de jeu
void gameScreen() {
  background(236, 240, 241);
  lastInput += 50; 
  wallAdder();
  wallHandler();
  drawCurseur();
}

//Définition de l'écran de Game Over
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
//Définition des instructions en fonction de l'écran si on clique
public void mousePressed() { 
  if (gameScreen==0) { 
    startGame();
  }
  if (gameScreen==2) {
    restart();
  }
}

//Définition des fonctions de changement d'écran
void startGame() {
  gameScreen=1;
}
void gameOver() {
  gameScreen=2;
}
void restart() {
  score = 0;
  wallSpeed = 2;
  lastAddTime = 0;
  wallsInterval = 6000;
  lastAddTime = 0;
  walls.clear();
  gameScreen = 1;
}

//Défintion de la fonction de déplacement du curseur
void mouseMoved(){
  curseurX = mouseX;
  curseurY = mouseY;
}
void keyPressed() {
   if (lastInput > 300){
      if (keyCode == DOWN){
         curseurY += curseurVitesse;
         lastInput = 0;}
      if (keyCode == UP){
         curseurY -= curseurVitesse;
         lastInput = 0;}
      if (keyCode == LEFT){
         curseurX -= curseurVitesse;
         lastInput = 0;}
      if (keyCode == RIGHT){
         curseurX += curseurVitesse;
         lastInput = 0;}
   }
}
//Définition de la fonction d'affichage du curseur
void drawCurseur() {
  smooth();
  fill(curseurColor);
  ellipse(curseurX, curseurY, curseurSize, curseurSize);
}
//Définition de la fonction d'apparition des murs
void wallAdder() {
    if (millis()-lastAddTime > wallsInterval) {
      int randHeight = round(random(minGapHeight, maxGapHeight));
      int randY = round(random(0, height-randHeight));
      float R = random(255);
      float G = random (255);
      float B = random (255);
      color wallColors = color(R, G, B);
      int[] randWall = {width, randY, wallsWidth, randHeight, 0, wallColors}; 
      walls.add(randWall);
      lastAddTime = millis();
    }
}

//Définition de la fonction de contrôle des murs
void wallHandler() {
  for (int i = 0; i < walls.size(); i++) {
    wallMover(i);
    wallDrawer(i);
    watchWallCollision(i);
    wallVariable();
  }
}

//Définition de la fonction d'affichage des murs
void wallDrawer(int index) {
  int[] wall = walls.get(index);
  // get gap wall settings 
  int gapWallX = wall[0];
  int gapWallY = wall[1];
  int gapWallWidth = wall[2];
  int gapWallHeight = wall[3];
  rectMode(CORNER);
  noStroke();
  strokeCap(ROUND);
  fill(wall [5]);
  rect(gapWallX, 0, gapWallWidth, gapWallY, 0, 0, 15, 15);
  rect(gapWallX, gapWallY+gapWallHeight, gapWallWidth, height-(gapWallY+gapWallHeight), 15, 15, 0, 0);
}

//Définition de la fonction de déplacement des murs
void wallMover(int index) {
  int[] wall = walls.get(index);
  wall[0] -= wallSpeed;
}

//Définition de la fonction de variation des vitesses et intervalles d'apparition des murs
void wallVariable() {
    if (wallSpeed < 5) {
    wallSpeed += 0.001;
    wallsInterval -= 0.025;
    println(wallSpeed, wallsInterval);
  } else {
    wallSpeed = 5;
    wallsInterval = 1000;
    println(wallSpeed, wallsInterval);
  }
}

//Définition de la fonction de détection de collisions entre le curseur et les murs
void watchWallCollision(int index) {
  int[] wall = walls.get(index);
  // get gap wall settings 
  int gapWallX = wall[0];
  int gapWallY = wall[1];
  int gapWallWidth = wall[2];
  int gapWallHeight = wall[3];
  int wallTopX = gapWallX;
  int wallTopY = 0;
  int wallTopWidth = gapWallWidth;
  int wallTopHeight = gapWallY;
  int wallBottomX = gapWallX;
  int wallBottomY = gapWallY+gapWallHeight;
  int wallBottomWidth = gapWallWidth;
  int wallBottomHeight = height-(gapWallY+gapWallHeight);

  //Collisions avec le mur supérieur
  if (
    (curseurX+(curseurSize/2)>wallTopX) &&
    (curseurX-(curseurSize/2)<wallTopX+wallTopWidth) &&
    (curseurY+(curseurSize/2)>wallTopY) &&
    (curseurY-(curseurSize/2)<wallTopY+wallTopHeight)
    ) {
      gameOver();      
  }
  //Collisions avec le mur 
  if (
    (curseurX+(curseurSize/2)>wallBottomX) &&
    (curseurX-(curseurSize/2)<wallBottomX+wallBottomWidth) &&
    (curseurY+(curseurSize/2)>wallBottomY) &&
    (curseurY-(curseurSize/2)<wallBottomY+wallBottomHeight)
    ) {
      gameOver();
  }
}

void keepInScreen() {

  if (curseurY+(curseurSize/2) > height) { 
    curseurY = height-(curseurSize/2);
  }
  // curseur hits ceiling
  if (curseurY-(curseurSize/2) < 0) {
    curseurY = (curseurSize/2);
  }
  // curseur hits left of the screen
  if (curseurX-(curseurSize/2) < 0) {
    curseurX = width-(curseurSize/2);
  }
  // curseur hits right of the screen
  if (curseurX+(curseurSize/2) > width) {
    curseurX = (curseurSize/2);
  }
}
//Défintion des variables de contrôle
int gameScreen = 0;
int score = 0;
float lastInput = 0;
String mode = "Init";
int place = 1;
//Définition des variables des murs
int minGapHeight = 100;
int maxGapHeight = 200;
int wallsWidth = 80;
float wallSpeed = 2;
float lastAddTime = 0;
float wallsInterval = 6000;
float lastNumber =0;
float numbersInterval = 0;
//Définition des variables
color curseurColor = color(0);
int curseurSize = 40;
int curseurX, curseurY;
int curseurVitesse = 40;

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

//Définition de l'écran de jeu et emploi des fonctions définies plus bas
void gameScreen() {
  background(236, 240, 241);
  lastInput += 50; 
  wallAdder();
  wallHandler();
  drawCurseur();
  numberAdder();
  numberHandler();
  keepInScreen();
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
   
    curseurY =  height/2;
    curseurX = width/4;
    startGameS();
    
  }
  if (gameScreen==2) {
    curseurY =  height/2;
    curseurX = width/4;
    restartS();
  }
}


//Définition des fonctions de changement d'écran
//Start mode Souris
void startGameS() {
  gameScreen=1;
  mode = "souris";
}
//Start mode Clavier
void startGame() {
  gameScreen=1;
}
void gameOver() {
  gameScreen=2;
}
//Restart en mode Clavier
void restart() {
  score = 0;
  wallSpeed = 2;
  lastAddTime = 0;
  wallsInterval = 6000;
  lastAddTime = 0;
  walls.clear();
  gameScreen = 1;
}
//Restart en mode Souris
void restartS() {
  score = 0;
  wallSpeed = 2;
  lastAddTime = 0;
  wallsInterval = 6000;
  lastAddTime = 0;
  walls.clear();
  gameScreen = 1;
  mode = "souris";
}
//Défintion de la fonction de déplacement du curseur
void mouseMoved(){
  if (mode == "souris") {
  curseurX = mouseX;
  curseurY = mouseY;}
  else if (mode == "clavier") {}
}
//Définition du choix de contrôle au clavier
public void keyPressed(){
   if (gameScreen==0) { 
    if (keyCode == ENTER){
            mode = "clavier";
            curseurY =  height/2;
            curseurX = width/4;
            startGame();
          }}
          else if (gameScreen==2) {
            if (keyCode == ENTER){
            mode = "clavier";
            curseurY =  height/2;
            curseurX = width/4;
            restart();
        }
            
      }
//Définition des contrôles au clavier 
  if (mode == "clavier") {
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
 else if (mode == "souris") {}}
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

void numberAdder() {
    if (millis()-lastNumber > numbersInterval) {
      int randY = round(random(0, height));
      int scoreN = round(random(0, 25));
      float R = random(150);
      float G = random (150);
      float B = random (150);
      color numberColors = color(R, G, B);
        int[] number = {width, randY, scoreN, 40, numberColors}; 
        numbers.add(number);
        lastNumber = millis();}
}

//Définition de la fonction d'affichage des numeros
 
void keepNumberInScreen(int index) {
    
    int[] numberS = numbers.get(index);
    int nbY = numberS[1];
    int nbT = numberS[3];
    float R = (255);
    float G = (0);
    float B = (127);
    color dcolor = color(R, G, B);
    if ((nbY+ nbT) > height) { 
      place = 0;
      numberS[1] = height-50;
      numberS[4] = dcolor;
      }
    else {
      place = 1;
      }
    if ((nbY - nbT) < 0) {
      place = 0;
      numberS[1] =+ 50; 
      numberS[4] = dcolor;
      
      }
    else  {
    place = 1;}
  
}
void numberDrawer(int index) {
  
    int[] number = numbers.get(index);
    // get gap wall settings 
    int NumberX = number[0];
    int NumberY = number[1];
    int colors = number[4];
     if (place == 1){
      smooth();
      noStroke();
      fill(colors);
      ellipseMode(CENTER);
      ellipse(NumberX, NumberY, curseurSize, curseurSize);}
}



void cirlceDrawer(int index) {
  int[] number = numbers.get(index);
  // get gap wall settings 
  int NumberX = number[0];
  int NumberY = number[1];
  int Width = number[2];
  int Height = number[3];
  textAlign(CENTER);
  textSize(25);
  text(Width, NumberX, NumberY+4,  Height) ;
}
//Définition de la fonction de déplacement des numéros (Same as wall)
void numberMover(int index) {
  int[] number = numbers.get(index);
  number[0] -= wallSpeed;
}

//Définition de la fonction de variation des vitesses et intervalles d'apparition des murs
void numberVariable() {
    if ((wallSpeed < 5) &&
    (wallsInterval > 3000)) {
    numbersInterval = round(random(1000, 3000));
    wallSpeed += 0.000025;
    println(wallSpeed, wallsInterval);
  } else {
    numbersInterval = round(random(3000, 30000));
    wallSpeed = 5;
    println(wallSpeed, wallsInterval);
    wallsInterval = round(random(2000, 20000));
  }
  if (wallsInterval > 3000) {
    wallsInterval -= 0.0025;
  }
  if (wallsInterval < 3000) {
    wallsInterval -= 0.0000025;}
}


void numberHandler() {
  for (int i = 0; i < numbers.size(); i++) {
    numberMover(i);
    numberDrawer(i);
    numberVariable();
    cirlceDrawer(i);
    keepNumberInScreen(i);
  }
}
//Définition de la fonction de contrôle des murs
void wallHandler() {
  for (int i = 0; i < walls.size(); i++) {
    wallMover(i);
    wallDrawer(i);
    watchWallCollision(i);
    numberVariable();

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


//Définition de la fonction de détection de collisions entre le curseur et les murs
void watchWallCollision(int index) {
  int[] wall = walls.get(index);
  int[] numberC = numbers.get(index);
  // get gap wall settings 
  int nbX =  numberC[0];
  int nbY = numberC[1];
  int nbT = numberC[3];
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
  if (
    (nbX+(nbT)>wallTopX) &&
    (nbX<wallTopX+wallTopWidth) &&
    (nbY+(nbT)>wallTopY) &&
    (nbY<wallTopY+wallTopHeight)
    ) {
      nbX += 50;      
  }
  //Collisions chiffre 
  if (
    (nbX+(nbT)>wallBottomX) &&
    (nbX<wallBottomX+wallBottomWidth) &&
    (nbY+(nbT)>wallBottomY) &&
    (nbY<wallBottomY+wallBottomHeight)
    ) {
      nbX +=50 ;
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
     curseurX = (curseurSize/2);
  }
  // curseur hits right of the screen
  if (curseurX+(curseurSize/2) > width) {
     curseurX = width-(curseurSize/2);
  }
}


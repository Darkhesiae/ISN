
//Défintion des variables de contrôle
int gameScreen = 0;
int score = 0;
float lastInput = 0;
String mode = "Init";
String playMode = "numbers";
int place = 0;
PFont mono;
PFont scored;
PFont signp;
int prise;
//Définition des variables des murs
int minGapHeight = 100;
int maxGapHeight = 200;
int wallsWidth = 80;
float wallSpeed = 2.0000;
float lastAddTime = 0;
float wallsInterval = 6000;
float lastNumber =0;
float lastSign =0;
float numbersInterval = 0;
float signsInterval = 0;
//Définition des variables
color curseurColor = color(150);
int curseurSize = 40;
int curseurX, curseurY;
int curseurVitesse = 40;
String A;
Float R,G,B;
//Définition des tableaux
ArrayList<int[]> walls = new ArrayList<int[]>();
ArrayList<int[]> numbers = new ArrayList<int[]>();
ArrayList<int[]> signs = new ArrayList<int[]>();

//Définition de l'affichage général
void setup() {
  keyPressed();
  size(853, 480);
  frameRate(60);
  mono = loadFont("Ravie-48.vlw");
  scored = loadFont("KristenITC-Regular-150.vlw");
  signp = loadFont("LithosPro-Black-48.vlw");
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
    
  if (playMode == "signs") {
     signHandler();
     signAdder();
     signCollision(); 
  }
  if (playMode == "numbers") {
    numberHandler();
    numberCollision();
    numberAdder();
  }
  
  drawCurseur();
  keepInScreen();
  
}

void numberVariable() {
    if ((wallSpeed < 5) &&
    (wallsInterval > 3000)) {
    signsInterval = round(random(3000, 6000));
    numbersInterval = round(random(3000, 6000));
    wallSpeed += 0.000025;
    println(wallSpeed, wallsInterval);
  } else {
    numbersInterval = round(random(2000, 50000));
    signsInterval = round(random(2000, 50000));
    wallSpeed = 5;
    println(wallSpeed, wallsInterval);
    wallsInterval = round(random(2000, 20000));
  }
  if (wallsInterval > 3000) {
    wallsInterval -= 0.025;
  }
  if (wallsInterval < 3000) {
    wallsInterval -= 0.0000025;}
}

//Définition de l'écran de Game Over
void gameOverScreen() {
 
  background(44, 62, 80);
  textFont(scored);
  textAlign(CENTER);
  fill(236, 240, 241);
  textSize(24);
  text("Your Score", width/2, height/2 - 120);
  textSize(130);
  smooth();
  text(score, width/2, height/2);
  textSize(25);
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
  playMode = "numbers";
}
//Start mode Clavier
void startGame() {
  gameScreen=1;
  playMode = "numbers";
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
  numbers.clear();
  signs.clear();
  gameScreen = 1;
  playMode = "numbers";
  
}
//Restart en mode Souris
void restartS() {
  score = 0;
  wallSpeed = 2;
  lastAddTime = 0;
  wallsInterval = 6000;
  lastAddTime = 0;
  walls.clear();
  signs.clear();
  numbers.clear();
  gameScreen = 1;
  prise = 0;
  mode = "souris";
  playMode = "numbers";
}
//Défintion de la fonction de déplacement du curseur
void mouseMoved(){
  if (mode == "souris") {
    if (prise == 0) {
      
      if (
    (mouseX > curseurX - (curseurSize / 2)) &&
    (mouseX < curseurX + (curseurSize / 2)) &&
    (mouseY > curseurY - (curseurSize / 2)) &&
    (mouseY < curseurY + (curseurSize / 2))
    )
    { 
      curseurX = mouseX;
      curseurY = mouseY;
      prise = 1;} 
}
  else if (prise ==1) {
    curseurX = mouseX;
      curseurY = mouseY;}
}
  else if (mode == "clavier") {}
}
//Définition du choix de contrôle au clavier
public void keyPressed(){
   if (gameScreen==0) { 
    if (keyCode == ' '){
            mode = "clavier";
            curseurY =  height/2;
            curseurX = width/5;
            startGame();
          }}
          else if (gameScreen==2) {
            if (keyCode == ENTER){
            mode = "clavier";
            curseurY =  height/2;
            curseurX = width/5;
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
  noStroke();
  fill(curseurColor);
  ellipseMode(CENTER);
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
      int scoreN = round(random(0, 9));
      float R = random(200);
      float G = random (200);
      float B = random (200);
      color roundColors = color(R, G, B);

      color numberColors = color(R, G, B, 500);
        int[] number = {width + 10 , randY, scoreN, 40, roundColors, numberColors}; 
        numbers.add(number);
        lastNumber = millis();}
}

void signAdder() {
    if (millis()-lastSign > signsInterval) {
      int randY = round(random(0, height));
      int signType = round(random(1, 4));
       
        if (signType == 1) {
          R = 162.0;
          G = 40.0;
          B = 40.0; }
        if (signType == 2) {
          R = 40.0;
          G = 40.0;
          B = 162.0;}
      if (signType == 3){
          R = 40.0;
          G = 162.0;
          B = 40.0;}
      if (signType == 4){
          R = 133.0;
          G = 30.0;
          B = 157.0;}
        color roundColors = color(R, G, B);
        color signColors = color(R, G, B, 500);
        int[] sign = {width + 10, randY, signType, 40, roundColors, signColors}; 
        signs.add(sign);
        lastSign = millis();}
}


          
void signDrawer(int index) {
  int[] sign = signs.get(index);
  int[] signc = signs.get(index);
  // get gap wall settings 
  int NumberX = sign[0];
  int NumberY = sign[1];
  int sT = sign[2];
  int Height = sign[3];
  int colors = sign[4];
  int ncolors = signc[5];
  String A = "Signe";
      if (sT == 1) {
          A = "-"; }
      if (sT == 2) {
          A = "X";}
      if (sT == 3){
          A = "+";}
      if (sT == 4){
          A = "/";}

      fill(colors, 50);
      stroke(colors);
      strokeWeight(3);
      ellipseMode(CENTER);
      ellipse(NumberX, NumberY, curseurSize, curseurSize);
      fill(ncolors, 900);
      
      textFont(signp);
      textAlign(CENTER);
      textSize(30);
      smooth();
      textAlign(CENTER, CENTER);
      text(A, NumberX, NumberY,  Height) ;


}

//Définition de la fonction d'affichage des numeros
 
void keepNumberInScreen(int index) {
    
    int[] numberS = numbers.get(index);
    int nbY = numberS[1];
    int nbT = numberS[3];

    if ((nbY+ nbT) > height) { 
      
      numberS[1] =- round(random(45, 150));
      
      place = 0;
      }
    
    else if ((nbY - nbT) < 0) {
      
      numberS[1] =+ round(random(45, 150)); 
      
      place = 0;
      
      }
    else  {
    place = 1;} 
  
}
void keepSignInScreen(int index) {
    
    int[] signS = signs.get(index);
    int sY = signS[1];
    int sT = signS[3];

    if ((sY+ sT) > height) { 
      
      signS[1] =- round(random(45, 150));
      
      place = 0;
      }
    
    else if ((sY - sT) < 0) {
      
      signS[1] =+ round(random(45, 150)); 
      
      place = 0;
      
      }
    else  {
    place = 1;} 
  
}





void cirlceDrawer(int index) {
  int[] number = numbers.get(index);
  int[] numberc = numbers.get(index);
  // get gap wall settings 
  int NumberX = number[0];
  int NumberY = number[1];
  int Width = number[2];
  int Height = number[3];
  int colors = number[4];
  int ncolors = numberc[5];
     if (place == 1){
      fill(colors, 50);
      stroke(colors);
      strokeWeight(3);
      ellipseMode(CENTER);
      ellipse(NumberX, NumberY, curseurSize, curseurSize);
      fill(ncolors, 900);
      
      textFont(mono);
      textAlign(CENTER);
      textSize(25);
      smooth();
      textAlign(CENTER, CENTER);
      text(Width, NumberX, NumberY-1,  Height) ;
      place = 0;}

}
//Définition de la fonction de déplacement des numéros (Same as wall)
void numberMover(int index) {
  int[] number = numbers.get(index);
  number[0] -= wallSpeed;
}

void signMover(int index) {
  int[] sign = signs.get(index);
  sign[0] -= wallSpeed;
}

//Définition de la fonction de variation des vitesses et intervalles d'apparition des murs

void signHandler() {
  for (int i = 0; i < signs.size(); i++) {
    signMover(i);
    numberVariable();
    signDrawer(i);
    signCursorCollision(i);
    keepSignInScreen(i);
  }
}

void numberHandler() {
  for (int i = 0; i < numbers.size(); i++) {
    numberMover(i);
    numberVariable();
    cirlceDrawer(i);
    numberCursorCollision(i);
    keepNumberInScreen(i);

  }
}
void numberCollision() {

     for (int i1 = 0; i1 < numbers.size(); i1++) {
      for (int i2 = 0; i2  < walls.size(); i2++) {
           watchNumberCollision(i2, i1);}}}
           
void signCollision() {
   for (int i3 = 0; i3 < signs.size(); i3++) {
      for (int i2 = 0; i2  < walls.size(); i2++) {
           watchSignCollision(i2, i3);}}}
    
void signCursorCollision(int index) {
    int[] signC = signs.get(index);
    int sX =  signC[0];
    int sY = signC[1];
    int sT = signC[3];
  
    if (
    (curseurX+(curseurSize/2)>sX - (sT /2)) &&
    (curseurX-(curseurSize/2)<sX+(sT/2)) &&
    (curseurY+(curseurSize/2)>sY - (sT /2)) &&
    (curseurY-(curseurSize/2)<sY+(sT/2 ))
    ) {
      gameOver();      
  }
  
}
void numberCursorCollision(int index) {
    int[] numberC = numbers.get(index);
    int nbX =  numberC[0];
    int nbY = numberC[1];
    int nbT = numberC[3];
   if (
    (curseurX+(curseurSize/2)>nbX - (nbT /2)) &&
    (curseurX-(curseurSize/2)<nbX+(nbT/2)) &&
    (curseurY+(curseurSize/2)>nbY - (nbT /2)) &&
    (curseurY-(curseurSize/2)<nbY+(nbT/2 ))
    ) {
      gameOver();      
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

void watchNumberCollision(int index1, int index2) {
  int[] walle = walls.get(index1);
  int[] numberC = numbers.get(index2);
  // get gap wall settings 
  int nbX =  numberC[0];
  int nbY = numberC[1];
  int nbT = numberC[3];
  int gapWallX = walle[0];
  int gapWallY = walle[1];
  int gapWallWidth = walle[2];
  int gapWallHeight = walle[3];
  int wallTopX = gapWallX;
  int wallTopY = 0;
  int wallTopWidth = gapWallWidth;
  int wallTopHeight = gapWallY;
  int wallBottomX = gapWallX;
  int wallBottomY = gapWallY+gapWallHeight;
  int wallBottomWidth = gapWallWidth;
  int wallBottomHeight = height-(gapWallY+gapWallHeight);

 if (nbX >= wallTopX+ (wallTopWidth /2)) {
    if (
    (nbX+(nbT)>wallTopX) &&
    (nbX-(nbT)<wallTopX+wallTopWidth) &&
    (nbY+(nbT)>wallTopY) &&
    (nbY-(nbT)<wallTopY+wallTopHeight)
    ) {
      
      numberC[0] += 1;  
    
  }
 
  else if (
    (nbX+(nbT)>wallBottomX) &&
    (nbX-(nbT)<wallBottomX+wallBottomWidth) &&
    (nbY+(nbT)>wallBottomY) &&
    (nbY-(nbT)<wallBottomY+wallBottomHeight)
    ) {
      
      numberC[0] +=1 ;
  
  }

 }
  if (nbX < wallTopX+ (wallTopWidth /2)) {
    if (
    (nbX+(nbT)>wallTopX) &&
    (nbX-(nbT)<wallTopX+wallTopWidth) &&
    (nbY+(nbT)>wallTopY) &&
    (nbY-(nbT)<wallTopY+wallTopHeight)
    ) {
      
      numberC[0] -= 1;  
    
  }
 
  else if (
    (nbX+(nbT)>wallBottomX) &&
    (nbX-(nbT)<wallBottomX+wallBottomWidth) &&
    (nbY+(nbT)>wallBottomY) &&
    (nbY-(nbT)<wallBottomY+wallBottomHeight)
    ) {
      
      numberC[0] -=1 ;  }
 }
}
void watchSignCollision(int index1, int index3) {
  int[] walle = walls.get(index1);
  int[] signC = signs.get(index3);
  // get gap wall settings 
  int sX =  signC[0];
  int sY = signC[1];
  int sT = signC[3];
  int gapWallX = walle[0];
  int gapWallY = walle[1];
  int gapWallWidth = walle[2];
  int gapWallHeight = walle[3];
  int wallTopX = gapWallX;
  int wallTopY = 0;
  int wallTopWidth = gapWallWidth;
  int wallTopHeight = gapWallY;
  int wallBottomX = gapWallX;
  int wallBottomY = gapWallY+gapWallHeight;
  int wallBottomWidth = gapWallWidth;
  int wallBottomHeight = height-(gapWallY+gapWallHeight);
 if (sX >= wallTopX+ (wallTopWidth /2)) {
    if (
    (sX+(sT)>wallTopX) &&
    (sX-(sT)<wallTopX+wallTopWidth) &&
    (sY+(sT)>wallTopY) &&
    (sY-(sT)<wallTopY+wallTopHeight)
    ) {
      
      signC[0] += 1;  
    
  }
 
  else if (
    (sX+(sT)>wallBottomX) &&
    (sX-(sT)<wallBottomX+wallBottomWidth) &&
    (sY+(sT)>wallBottomY) &&
    (sY-(sT)<wallBottomY+wallBottomHeight)
    ) {
      
      signC[0] +=1 ;
  
  }

 }
  if (sX < wallTopX+ (wallTopWidth /2)) {
    if (
    (sX+(sT)>wallTopX) &&
    (sX-(sT)<wallTopX+wallTopWidth) &&
    (sY+(sT)>wallTopY) &&
    (sY-(sT)<wallTopY+wallTopHeight)
    ) {
      
      signC[0] -= 1;  
    
  }
 
  else if (
    (sX+(sT)>wallBottomX) &&
    (sX-(sT)<wallBottomX+wallBottomWidth) &&
    (sY+(sT)>wallBottomY) &&
    (sY-(sT)<wallBottomY+wallBottomHeight)
    ) {
      
      signC[0] -=1 ;
  
  }

 }
}
void watchWallCollision(int index) {
  int[] wall = walls.get(index);
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

import processing.video.*;
import processing.sound.*;
//Défintion des variables de contrôle
Movie PLUS;
Movie MOINS;
SoundFile music;
SoundFile bruh;
int gameScreen = 0;
int score = 0;
float lastInput = 0;
String mode = "Init";
String playMode = "numbers";
int place = 0;
PFont mono;
PFont scored;
PFont signp;
PImage bg;
int Bruh = 0;
int c;
int T;
int c2;
int Music =0;
int Divide0 = 0;
float  Timer = 0.00;
float lastTimer = 0.00;
float lastTimerN = 0.00;
float lastTimerS = 0.00;
int pos = 0;
int Cv1 =0;
int Cv2 = 0;
int Cr = 0;
int Cg = 0;
int Cb = 0;
int signType;
int Lr = 0;
String TextScore;
int Lb = 0;
int Lg = 0;
int prise; 
int Bck = 0;
int Bckm = 0;
int ScoreT = 0;
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
int HighScore = 0;
Float R, G, B;
int S;
int signe = 1;
int W, H;
//Définition des tableaux
ArrayList<int[]> walls = new ArrayList<int[]>();
ArrayList<int[]> numbers = new ArrayList<int[]>();
ArrayList<int[]> signs = new ArrayList<int[]>();

//Définition de l'affichage général
void setup() {
  keyPressed();

  size(852, 480);
  frameRate(60);
  mono = loadFont("KristenITC-Regular-150.vlw");
  scored = loadFont("KristenITC-Regular-150.vlw");
  signp = loadFont("LithosPro-Black-48.vlw");
  bg = loadImage("13-blast-damage_1218012i.jpg");
  music = new SoundFile(this, "music.mp3");
  bruh = new SoundFile(this, "bruh.wav");
  PLUS = new Movie(this, "PLUS.mp4");
  image(PLUS, 0, 0, 853, 480);
  PLUS.width = 852;
  PLUS.height = 480;
  MOINS = new Movie(this, "MOINS.mp4");
  MOINS.width = 852;
  MOINS.height = 480;
  PLUS.play(); 
  PLUS.loop(); 
  MOINS.play();      
  MOINS.loop();
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
void movieEvent(Movie m) { 
  m.read();
} 
void background() {
  if (ScoreT > 0) {
    background(PLUS);
    if (Bck == 0) {
      Bck = 1;
      Bckm = 0;
    }
  } else if (ScoreT < 0) {
    background(MOINS);
    if (Bckm == 0) {
      Bckm = 1;
      Bck = 0;
    }
  } else background(236, 240, 241);
}

void affichageScore() {
  if (ScoreT == 0) {
    c = color(#3EDB69);
  }
  if (ScoreT > 0) {
    c = color(#DB3E3E);
  }
  if (ScoreT < 0) {
    c = color(#274BAA);
  }
  textSize(20);
  fill(c);
  smooth();
  textFont(signp);
  if ((ScoreT < 9999) && (ScoreT  > - 9999)) { 
    pos = width/10;
  } else if (ScoreT  > 999999) {
    pos = width/5;
  } else if (ScoreT  < -999999) {
    pos = width/5;
  } else if (ScoreT  > 9999999) {
    pos = width/4;
  } else if (ScoreT  < -9999999) {
    pos = width/4;
  } else if (ScoreT  > 99999999) {
    pos = width/3;
  } else if (ScoreT  < -99999999) {
    pos = width/3;
  } else {
    pos = width/7;
  }

  text(ScoreT, pos, height/20);
}

//Définition de l'écran de jeu et emploi des fonctions définies plus bas
void gameScreen() {
  background();
  if (Music == 0) {
    music.play();

    Music = 1;
  }
  //background(236, 240, 241);
  lastInput += 50; 
  music.amp(0.2);
  wallAdder();
  wallHandler();
  affichageScore();
  if (playMode == "signs") {
    signHandler();
    signAdder();
    signCollision();
    signRemoving();
    Timer = 15 - ((millis() - lastTimerS)/1000);
    if ((Timer < 15) && (Timer  > 10)) { 
      c = color(#54CB83);
    }
    if ((Timer < 10) && (Timer  > 6)) { 
      c = color(#C7D349);
    }         
    if ((Timer < 6) && (Timer  > 3)) { 
      c = color(#FF850A);
    }     
    if ((Timer < 3) && (Timer  > 0)) { 
      c = color(#FF3131);
    }               
    textSize(20);         
    fill(c);         
    smooth();         
    textFont(signp);      
    text(Timer, width - width/7, height/20);     
    if (Timer < 0.01) {
      gameOver();
    }         
    lastTimerN = millis();
  }


  if (playMode == "numbers") {
    if (signe == 1) {
      if ((S == 2)   
        || (S== 4)) {
        Timer = 10 - ((millis() - lastTimerN)/1000);
        if ((Timer < 10) && (Timer  > 6)) { 
          c = color(#54CB83);
        }        
        if ((Timer < 6) && (Timer  > 3)) { 
          c = color(#FF850A);
        }        
        if ((Timer < 3) && (Timer  > 0)) { 
          c = color(#FF3131);
        }        
        if (Timer < 0.01) {
          gameOver();
        }      
        textSize(20);      
        fill(c);      
        smooth();     
        textFont(signp);       
        text(Timer, width - width/7, height/20);
      }
    }       

    numberHandler();
    numberCollision();
    numberAdder();
    lastTimerS = millis();
  }

  drawCurseur();
  keepInScreen();
}

void numberVariable() {
  if ((wallSpeed < 6) &&
    (wallsInterval > 1000)) {
    signsInterval = round(random(2000, 4500));
    numbersInterval = round(random(2000, 4500));
    wallSpeed += 0.00025;
    println(wallSpeed, wallsInterval, lastTimer);
  } else {

    wallSpeed = 5;
    println(wallSpeed, wallsInterval);
    wallsInterval = round(random(1000, 5000));
  }
  if (wallsInterval > 3000) {
    wallsInterval -= 0.25;
  }
  if (wallsInterval < 3000) {
    wallsInterval -= 0.25;
  }
}

//Définition de l'écran de Game Over
void gameOverScreen() {
  if (Bruh == 0) {
    bruh.play();
    music.stop();
    Bruh = 1;
  }
  background(44, 62, 80);
  textFont(scored);
  textAlign(CENTER);
  fill(236, 240, 241);
  if (Divide0 == 1)
  {
    TextScore = "Vous ne pouvez pas diviser par "; 
    textSize(24);
    text("L'auriez vous oublié ?", width/2, height - 110);
  } else {
    TextScore = "Your Score";
  }
  textSize(24);

  text(TextScore, width/2, height/2 - 120);
  textSize(130);
  smooth();
  ScoreT = abs(ScoreT);
  text(ScoreT, width/2, height/2);
  if (ScoreT >= HighScore) {
    HighScore = ScoreT;
    textSize(25);
    text("Nouveau Record", width/2, height-110);
  }
  textSize(25);

  text("Record :"+ HighScore, width/2, height-70);
  textSize(25);
  text("Cliquez pour recommencer", width/2, height-30);
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
  Timer = 0.00;
  Divide0 =0;
  lastTimerS = 0.00;
  lastTimerN = 0.00;
  ScoreT = 0;
  wallSpeed = 2;
  lastAddTime = 0;
  wallsInterval = 6000;
  lastAddTime = 0;
  walls.clear();
  numbers.clear();
  signs.clear();
  gameScreen = 1;
  playMode = "numbers";
  S= 0;
  Bruh = 0;
  Music = 0;
  signe = 1;
}
//Restart en mode Souris
void restartS() {
  Timer = 0.00;
  Bruh = 0;
  Music = 0;

  Divide0 = 0;
  lastTimerN = 0.00;
  lastTimerS = 0.00;
  ScoreT = 0;
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
  S= 0;
  signe = 1;
}
//Défintion de la fonction de déplacement du curseur
void mouseMoved() {
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
        prise = 1;
      }
    } else if (prise ==1) {
      curseurX = mouseX;
      curseurY = mouseY;
    }
  } else if (mode == "clavier") {
  }
}
//Définition du choix de contrôle au clavier
public void keyPressed() {
  if (gameScreen==0) { 
    if (keyCode == ENTER) {
      mode = "clavier";
      curseurY =  height/2;
      curseurX = width/5;
      startGame();
    }
  } else if (gameScreen==2) {
    if (keyCode == ENTER) {
      mode = "clavier";
      curseurY =  height/2;
      curseurX = width/5;
      restart();
    }
  }
  //Définition des contrôles au clavier 
  if (mode == "clavier") {
    if (lastInput > 100) {
      if (keyCode == DOWN) {
        curseurY += curseurVitesse;
        lastInput = 0;
      }
      if (keyCode == UP) {
        curseurY -= curseurVitesse;
        lastInput = 0;
      }
      if (keyCode == LEFT) {
        curseurX -= curseurVitesse;
        lastInput = 0;
      }
      if (keyCode == RIGHT) {
        curseurX += curseurVitesse;
        lastInput = 0;
      }
    } else if (mode == "souris") {
    }
  }
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
    int scoreN = round(random(-9, 9));
    float R = random(200);
    float G = random (200);
    float B = random (200);
    color roundColors = color(R, G, B);

    color numberColors = color(R, G, B, 500);
    int[] number = {width + 10, randY, scoreN, 40, roundColors, numberColors}; 
    numbers.add(number);
    lastNumber = millis();
  }
}

void signAdder() {
  if (millis()-lastSign > signsInterval) {
    int randY = round(random(0, height));
    int signType = round(random(1, 4));

    if (signType == 1) {
      R = 162.0;
      G = 40.0;
      B = 40.0;
    }
    if (signType == 2) {
      R = 40.0;
      G = 40.0;
      B = 162.0;
    }
    if (signType == 3) {
      R = 40.0;
      G = 162.0;
      B = 40.0;
    }
    if (signType == 4) {
      R = 133.0;
      G = 30.0;
      B = 157.0;
    }

    color roundColors = color(R, G, B);
    color signColors = color(R, G, B, 500);
    int[] sign = {width + 10, randY, signType, 40, roundColors, signColors}; 
    signs.add(sign);
    lastSign = millis();
  }
  if (signType == 1) {
    R = 162.0;
    R += 1; 
    G = 40.0;
    B = 40.0;
    println(R);
  }
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
    A = "-";
    R = 162.0 + Cr;
    G = 40.0;
    B = 40.0;
    if ((R < 240.0) && (Lr == 0))
    { 
      Cr += 1.0;
      println(R);
    }
    if (R >= 240.0) 
    { 
      Lr = 1;
    }
    if (Lr == 1) {
      Cr -= 1.0;
      println(R);
    }
    if (R <= 162.0)
    { 
      Lr = 0;
      println(R);
    }
  }
  if (sT == 2) {
    A = "x";
    R = 80.0;
    G = 100.0;
    B = 162.0 + Cb;
    if ((R < 255) && (Lb == 0))
    { 
      Cb += 1.0;
      println(B);
    }
    if (B >= 255.0) 
    { 
      Lb = 1;
    }
    if (Lb == 1) {
      Cb -= 1.0;
      println(R);
    }
    if (B <= 162.0)
    { 
      Lb = 0;
      println(B);
    }
  }
  if (sT == 3) {
    A = "+";
    G = 162.0 + Cg;
    R = 40.0;
    B = 40.0;
    if ((G < 220.0) && (Lg == 0))
    { 
      Cg += 1.0;
      println(R);
    }
    if (G >= 220) 
    { 
      Lg = 1;
    }
    if (Lg == 1) {
      Cg -= 1.0;
      println(R);
    }
    if (G <= 162.0)
    { 
      Lg = 0;
      println(G);
    }
  }
  if (sT == 4) {
    A = "/";
    R = 162.0 + Cv1;
    G = 40.0;
    B = 120.0 + Cv2;
    if ((R < 240.0) && (Lr == 0))
    { 
      Cv1 += 1.0;
      Cv2 += 1.0;
      println(R);
    }
    if (R >= 240.0) 
    { 
      Lr = 1;
    }
    if (Lr == 1) {
      Cv1 -= 1.0;
      Cv2 -= 1.0;
      println(R);
    }
    if (R <= 162.0)
    { 
      Lr = 0;
      println(R);
    }
  }
  tint(0, 0, 0, 40);
  ncolors = color (R, G, B);
  colors = color (R, G, B);
  fill(colors, 50);
  stroke(colors);
  strokeWeight(4);
  ellipseMode(CENTER);
  ellipse(NumberX, NumberY, curseurSize, curseurSize);
  fill(ncolors, 900);

  textFont(signp);
  textAlign(CENTER);
  textSize(32);
  smooth();
  textAlign(CENTER, CENTER);
  text(A, NumberX, NumberY, Height) ;
}

//Définition de la fonction d'affichage des numeros

void keepNumberInScreen(int index) {
  int[] numberS = numbers.get(index);
  int nbY = numberS[1];
  int nbT = numberS[3];
  if ((nbY+ nbT) > height) { 
    numberS[1] =- round(random(45, 150));
    place = 0;
  } else if ((nbY - nbT) < 0) {
    numberS[1] =+ round(random(45, 150)); 
    place = 0;
  } else {
    place = 1;
  }
}
void keepSignInScreen(int index) {
  int[] signS = signs.get(index);
  int sY = signS[1];
  int sT = signS[3];
  if ((sY+ sT) > height) { 
    signS[1] =- round(random(45, 150));
    place = 0;
  } else if ((sY - sT) < 0) {
    signS[1] =+ round(random(45, 150)); 
    place = 0;
  } else {
    place = 1;
  }
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
  if (place == 1) {
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
    text(Width, NumberX, NumberY-1, Height) ;
    place = 0;
  }
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
void signRemoving() {
  for (int i = 0; i  < signs.size(); i++) {
    if (i > 1) {
      signRemover(i);
    }
  }
}

void signRemover(int index) {
  int[] sign = signs.get(index);
  if (sign[0]+sign[3] <= 0) {
    signs.remove(index);
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
      watchNumberCollision(i2, i1);
    }
  }
}

void signCollision() {
  for (int i3 = 0; i3 < signs.size(); i3++) {
    for (int i2 = 0; i2  < walls.size(); i2++) {
      watchSignCollision(i2, i3);
    }
  }
}

void signCursorCollision(int index) {
  int[] signC = signs.get(index);
  int sX =  signC[0];
  int sY = signC[1];
  int sT = signC[3];
  int sTy = signC[2];

  if (
    (curseurX+(curseurSize/2)>sX - (sT /2)) &&
    (curseurX-(curseurSize/2)<sX+(sT/2)) &&
    (curseurY+(curseurSize/2)>sY - (sT /2)) &&
    (curseurY-(curseurSize/2)<sY+(sT/2 ))
    ) {
    if (sTy == 1) {
      S = 1;
    }
    if (sTy == 2) {
      S = 2;
    }
    if (sTy == 3) {
      S = 3;
    }
    if (sTy == 4) {
      S = 4;
    }
    signe = 1;
    playMode = "numbers"; 
    numbers.clear();
  }
}
void numberCursorCollision(int index) {
  int[] numberC = numbers.get(index);
  int nbX =  numberC[0];
  int nbY = numberC[1];
  int nbT = numberC[3];
  int Score = numberC[2];


  if (
    (curseurX+(curseurSize/2)>nbX - (nbT /2)) &&
    (curseurX-(curseurSize/2)<nbX+(nbT/2)) &&
    (curseurY+(curseurSize/2)>nbY - (nbT /2)) &&
    (curseurY-(curseurSize/2)<nbY+(nbT/2 ))
    ) {
    if (signe == 1) {
      if (S == 1) {
        ScoreT = ScoreT - Score ;
      } else if (S == 2) {
        ScoreT = ScoreT *  Score ;
      } else if (S == 3) {
        ScoreT = ScoreT +  Score ;
      } else if (S == 4) {
        if (Score == 0) {
          ScoreT = 0;
          Divide0 = 1;
          gameOver();
        } else {
          ScoreT = ScoreT /  Score ;
        }
      } else {
        ScoreT = Score;
      } 
      signe = 0;
      playMode = "signs";
      signs.clear();
    }
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
    } else if (
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
    } else if (
      (nbX+(nbT)>wallBottomX) &&
      (nbX-(nbT)<wallBottomX+wallBottomWidth) &&
      (nbY+(nbT)>wallBottomY) &&
      (nbY-(nbT)<wallBottomY+wallBottomHeight)
      ) {

      numberC[0] -=1 ;
    }
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
    } else if (
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
    } else if (
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

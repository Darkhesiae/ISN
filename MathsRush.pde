import processing.video.*; //<>//
import processing.sound.*;
//Défintion des variables de contrôle
//Création des slots pour sons et vidéos
Movie PLUS; 
Movie MOINS;
SoundFile music; 
SoundFile bruh;
int Bruh = 0, Music = 0;
//Création des slots pour éléments graphiques
int colors, ncolors;
PFont CODEpetit, CODElc, CODE, signp, scored, mono;
int Cv1 =0, Cv2 = 0, Cr = 0, Cg = 0, Cb = 0, c, c2;      //Variations couleurs des signes
int Lg = 0, Lr = 0, Lb = 0;      // 
int Bck = 0, Bckm = 0;
//Défintion des variables d'écran
int gameScreen = 0;
//Définition des variables des contrôles C&S
boolean changeModeC = false;
boolean changeModeS = false;
float lastInput = 0;
int prise;
String mode = "Clavier";
//Définition des variables du score
int score = 0;
int PosScore;
String TextScore;
boolean restart = false;
int ScoreT = 0;
//Définition des variables de signes et nombres
String playMode = "numbers";
int Divide0 = 0;
float  Timer = 0.00;
float lastTimer = 0.00;
float lastTimerN = 0.00;
float lastTimerS = 0.00;
int signType;
int T;
int place = 0; 
color mouseOver1 = color(70, 90, 110);
color mouseOver2 = color(70, 90, 110);
//Définition des variables des murs
int minGapHeight = 100;
int maxGapHeight = 200;
int wallsWidth = 80;
float wallSpeed = 3.0000;
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
int curseurVitesse = 50;
String A;
int HighScore;
Float R, G, B;
int S, signe = 1;
int W, H, xselect = - 400, yselect = 600;
String scoreTable;

//Définition des tableaux
ArrayList<int[]> walls = new ArrayList<int[]>();
ArrayList<int[]> numbers = new ArrayList<int[]>();
ArrayList<int[]> signs = new ArrayList<int[]>();

//Définition de l'affichage général
void setup() {
  size(852, 480, JAVA2D);
  smooth(2);
  frameRate(60);
  mono = loadFont("KristenITC-Regular-150.vlw");
  scored = loadFont("Code-Pro-40.vlw");
  signp = loadFont("LithosPro-Black-48.vlw");
  CODE = loadFont("Code-Pro-255.vlw");
  CODElc =  loadFont("Code-Pro-LC-50.vlw");
  CODEpetit = loadFont("Code-Pro-15.vlw");
  music = new SoundFile(this, "music.mp3");
  bruh = new SoundFile(this, "bruh.wav");
  PLUS = new Movie(this, "PLUS.mp4");
  PLUS.width = 852; 
  PLUS.height = 480;
  MOINS = new Movie(this, "MOINS.mp4");
  MOINS.width = 852; 
  MOINS.height = 480;
  PLUS.loop(); 
  MOINS.loop();
}

//Boucles du jeu
void draw() {
  if (gameScreen == 0) {
    initScreen();
    if (changeModeS == true) {
      mode = "Souris";  
      changeModeC = false;
    }
    if (changeModeC == true) {
      mode = "Clavier";
      changeModeS = false;
    }
  } else if (gameScreen == 1) {
    gameScreen();
    loadHighscore();
  } else if (gameScreen == 2) { 
    gameOverScreen();
  }
}

//Définition de l'écran d'initialisation
void initScreen() { 
  background(236, 240, 241);
  textAlign(CENTER);
  strokeWeight(1);
  stroke(52, 73, 94);
  line(10, height/2.25, width - width/10, height/2.25);
  strokeWeight(8);
  stroke(52, 73, 94);
  line(width/2.85, height/3.70, width - width/2.2, height/3.70);
  fill(52, 73, 94);
  textFont(CODE);
  textSize(150);
  text("Maths", width/3.5, height/4); //Titre
  textSize(125);
  text("Rush", width/5.45, height/2.25);
  textFont(CODElc);
  textSize(50);
  text("X / - +", width/2.2, height/2.40);
  textFont(CODEpetit);
  textSize(15); 
  if (xselect < width/2) 
  {
    xselect +=40;
  } else {
    xselect = width/2;
  }
  text("Sélectionnez votre mode de jeu avec les flèches directionnelles", xselect, height-100); //Instructions
  noStroke();
  fill(#D5E3E0);
  rect(0, height - 75, 112, 100);
  textSize(10);
  fill(52, 73, 94);
  text("Si vous ne parvenez pas à séléctionner votre mode de jeu, cliquez de nouveau sur l'écran", 6, height-70, 100, 100);  
  textFont(scored);
  textSize(20);   
  text("Mode  "+"< " + mode  + " >", width/2, height-70);
  println(mode);
  textSize(25);
  if (yselect >= height-30) //Texte défilant
  {
    yselect -=10;
  }
  if (mode == "Souris") {
    text("Cliquez pour commencer", width/2, yselect);
  } else if (mode == "Clavier") {
    text("Appuyez sur ''Entrée'' pour commencer", width/2, yselect);
  }
}
//Fonction de lecture du fond animé
void movieEvent(Movie m) { 
  m.read();
} 
//Changement (booléen) de background selon le signe du score
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
//Définition de l'affichage du score (Placement / couleur)
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
  
  fill(c);
  textFont(signp);
  
  text(ScoreT, PosScore, height/20);
  if ((ScoreT < 9999) && (ScoreT  > - 9999)) { 
    PosScore = width/10;
  } else if ((ScoreT  > 999999) || (ScoreT  < -999999)) {
    PosScore = width/5;
  } else if ((ScoreT  > 9999999) || (ScoreT  < -9999999)) {
    PosScore = width/4;
  } else if ((ScoreT  > 99999999) || (ScoreT  < -99999999)) {
    PosScore = width/3;
  } else {
    PosScore = width/7;
  }
}

//Définition de l'écran de jeu et emploi des fonctions définies plus bas
void gameScreen() {
  background();
  if (prise == 1) { //Musique
    if (Music == 0) {
      music.loop();    
      Music = 1;
    }
    music.amp(0.2);
    wallAdder();
    wallHandler();
    if (playMode == "signs") { //Mode de Jeu
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
             
          textFont(signp);       
          text(Timer, width - width/7, height/20);
        }
      }       

      numberHandler();
      numberCollision();
      numberAdder();
      lastTimerS = millis();
    }
  } else if (prise == 0) {  
    fill(#67817E);
    textFont(CODEpetit);
    textSize(15); 
    text("Empoignez votre curseur vers une Maths'venture", width - width/2.25, height-237);
  }
  affichageScore();
  drawCurseur();
  keepInScreen();
}
//Variables correspondant à la vitesse et l'espacement des murs 
void numberVariable() {
  if ((wallSpeed < 6) &&
    (wallsInterval >1000)) {
    signsInterval = round(random(2000, 4500));
    numbersInterval = round(random(2000, 4500));
    wallSpeed += 0.00050;
    wallsInterval -= 0.50;
    println(wallSpeed, wallsInterval, lastTimer);
  } else {
    wallsInterval -= 0.50;
    wallSpeed = 5;
    wallsInterval = round(random(1500, 4000));
  }
}
//Mise à jour de "Record" dans un .dat
void updateHighscore() {
  String[] HScore = {str(HighScore)};
  saveStrings("data/highscore.txt", HScore);
}
//Recherche du record dans le .dat
void loadHighscore() {
  String hscore[] = loadStrings("highscore.txt");
  for (int j = 0; j < hscore.length; j++) {
    HighScore = int(hscore[j]);
  }
}
//Définition de l'écran de Game Over
void gameOverScreen() {
  if (Bruh == 0) {
    bruh.amp(0.5);
    bruh.play();
    
    music.stop();
    Bruh = 1;
  }
  prise = 0;
  cursor();
  background(44, 62, 80);
  fill(mouseOver1);
  rect(0, 0, 105, 46);
  fill(mouseOver2);
  rect(width  - 100, 0, 105, 46);
  textFont(scored);
  textAlign(CENTER);
  fill(236, 240, 241);
  if (Divide0 == 1) //En cas de division pas 0
  {
    TextScore = "Vous ne pouvez pas diviser par "; 
    textSize(24);
    text("L'auriez vous oublié ?", width/2, height - 110);
  } else {
    TextScore = "Your Score";
  }
  textSize(24);
  text(TextScore, width/2, height/2 - 120);
  
  ScoreT = abs(ScoreT);
  textFont(CODE);
  textSize(130);
  text(ScoreT, width/2, height/2);
  if (ScoreT >= HighScore) {
    HighScore = ScoreT;
    updateHighscore();
    textFont(scored);
    textSize(25);
    text("Nouveau Record", width/2, height-110);
  }


  textFont(CODEpetit);
  textSize(13);
  text("Appuyez sur ''Echap'' pour quitter", 3, 5, 100, 50);
  text("Retour au menu principal", width- 100, 5, 100, 50);
  textFont(scored);
  textSize(25);
  text("Record : "+ HighScore, width/2, height-70);
  if (mode == "Clavier") {
    text("Appuyez sur ''Entrée'' pour recommencer", width/2, height-30);
  }
  if (mode == "Souris") {
    text("Cliquez pour recommencer", width/2, height-30);
  }
}
//Définition des instructions en fonction de l'écran si on clique
void mousePressed() { 
  if (mode == "Souris") {
    if (gameScreen==0) {
      startGame();
    }
    if (gameScreen==1) {
    }}
    if (gameScreen==2) {
      if (
        (mouseX > 0) &&
        (mouseX < 105) &&
        (mouseY > 0) &&
        (mouseY < 46))
          {exit();}
      else if (
        (mouseX > width - 100) &&
        (mouseX < width) &&
        (mouseY > 0) &&
        (mouseY < 46))
        {gameScreen = 0; restart(); }
      else {
      if (mode == "Souris"){
      restart = true;
      restart();}}
    }
  
}
//Définition des fonctions de changement d'écran
void startGame() {
  curseurY =  height/2;
  curseurX = width/4;
  playMode = "numbers";
  gameScreen=1;
}
void gameOver() {
  gameScreen=2;
}
void restart() {
  Timer = 0.00;
  xselect = - 400; yselect = 600;
  Divide0 =0;
  lastTimerS = 0.00;
  lastTimerN = 0.00;
  ScoreT = 0;
  wallSpeed = 3.0000;
  lastAddTime = 0;
  wallsInterval = 6000;
  lastAddTime = 0;
  walls.clear();
  numbers.clear();
  signs.clear();
  if (restart == true) {
    gameScreen = 1;
  } else {
    gameScreen = 0;
  }
  playMode = "numbers";
  S= 0;
  prise = 0;
  Bruh = 0;
  Music = 0;
  signe = 1;
  curseurY =  height/2;
  curseurX = width/4;
  restart = false;
}
//Permet au curseur de suivre la souris même si on effectue un clic
void mouseDragged() {
  if (mode == "Souris") {
    if (gameScreen == 1) {
      if (prise ==1) {
        curseurX = mouseX;
        curseurY = mouseY;
        noCursor();
      }
    }
  }
}
//Défintion de la fonction de déplacement du curseur
public void mouseMoved() {
  if (mode == "Souris") {
    if (gameScreen == 1) {
    if (prise == 0) {
      cursor();
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
      noCursor();
    }
  }
  }
  if (gameScreen == 2){
    if (
        (mouseX > 0) &&
        (mouseX < 105) &&
        (mouseY > 0) &&
     
        (mouseY < 46)){mouseOver1 = color(33, 50, 67);}
    else if  (
        (mouseX > width - 100) &&
        (mouseX < width-1) &&
        (mouseY > 0) &&
        (mouseY < 46))
          {mouseOver2 = color(33, 50, 67);}
          
    else {mouseOver1 = color(70, 90, 110);
          mouseOver2 = color(70, 90, 110);}
        }
  }
//Définition du choix de contrôle au clavier
public void keyPressed() {
  if (keyCode == ENTER) {
    if (mode == "Clavier") {
      if (gameScreen == 0) {
        startGame();
        prise = 1;
      } else if (gameScreen == 2) {
        restart = true;
        restart();
        prise = 1;
      }
    }
  }
  if (keyCode == BACKSPACE) {
    if (gameScreen == 2) {
      restart = false;
      restart();
      prise = 1;
    }
  }

  if (key == CODED) {
    if (gameScreen == 0) {

      if (((keyCode == LEFT || keyCode == RIGHT)) ) {
        if (mode == "Clavier") {
          changeModeS = true;
        } else if (mode == "Souris") {
          changeModeC = true;
        }
      }
    }
  }
  //Définition des contrôles au clavier 
  if (gameScreen == 1) {
    if (mode == "Clavier") {
      noCursor();
      if (keyCode == DOWN) {
        curseurY += curseurVitesse;
      }
      if (keyCode == UP) {
        curseurY -= curseurVitesse;
      }
      if (keyCode == LEFT) {
        curseurX -= curseurVitesse;
      }
      if (keyCode == RIGHT) {
        curseurX += curseurVitesse;
      }
    }
  }
}
public void keyReleased() {
  if (key == CODED) {
    if (gameScreen == 0) {
      if (((keyCode == LEFT || keyCode == RIGHT)) ) {
        changeModeC = false;
        changeModeS = false;
      }
    }
  }
}

//Définition de la fonction d'affichage du curseur
void drawCurseur() {
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
    int[] sign = {width + 10, randY, signType, 40}; 
    signs.add(sign);
    lastSign = millis();
  }
}
void signDrawer(int index) {
  int[] sign = signs.get(index);
  // get gap wall settings 
  int NumberX = sign[0];
  int NumberY = sign[1];
  int sT = sign[2];
  int Height = sign[3];
  String A = "Signe";
  if (sT == 1) {
    A = "-";
    R = 162.0 + Cr;
    G = 40.0;
    B = 40.0;
    if ((R < 240.0) && (Lr == 0))
    { 
      Cr += 1.0;
    }
    if (R >= 240.0) 
    { 
      Lr = 1;
    }
    if (Lr == 1) {
      Cr -= 1.0;
    }
    if (R <= 162.0)
    { 
      Lr = 0;
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
    }
    if (B >= 255.0) 
    { 
      Lb = 1;
    }
    if (Lb == 1) {
      Cb -= 1.0;
    }
    if (B <= 162.0)
    { 
      Lb = 0;
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
    }
    if (G >= 220) 
    { 
      Lg = 1;
    }
    if (Lg == 1) {
      Cg -= 1.0;
    }
    if (G <= 162.0)
    { 
      Lg = 0;
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
    }
    if (R >= 240.0) 
    { 
      Lr = 1;
    }
    if (Lr == 1) {
      Cv1 -= 1.0;
      Cv2 -= 1.0;
    }
    if (R <= 162.0)
    { 
      Lr = 0;
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
//Permet aux signes de ne pas sortir de l'écran
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
//Affichage des nombres
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
//Nettoyage des tableaux pour éviter l'accumulation
void signRemoving() {
  for (int i = 0; i  < signs.size(); i++) {
    if (i > 1) {
      signRemover(i);
    }
  }
}
void wallRemoving() {
  for (int i = 0; i  < walls.size()-1; i++) {
    wallRemover(i);
  }
}
void wallRemover(int index) {
  int[] wall = walls.get(index);
  if (wall[0]+wall[2] <= 0) {

    walls.remove(index);
  }
}
void signRemover(int index) {
  int[] sign = signs.get(index);
  if (sign[0]+sign[3] <= 0) {
    signs.remove(index);
  }
}
//Affichage des chiffres
void numberHandler() {
  for (int i = 0; i < numbers.size(); i++) {
    numberMover(i);
    numberVariable();
    cirlceDrawer(i);
    numberCursorCollision(i);
    keepNumberInScreen(i);
  }
}
//Collisions entre les murs et les chiffres
void numberCollision() {

  for (int i1 = 0; i1 < numbers.size(); i1++) {
    for (int i2 = 0; i2  < walls.size(); i2++) {
      watchNumberCollision(i2, i1);
    }
  }
}
//Collisions entre les murs et les signes
void signCollision() {
  for (int i3 = 0; i3 < signs.size(); i3++) {
    for (int i2 = 0; i2  < walls.size(); i2++) {
      watchSignCollision(i2, i3);
    }
  }
}
//Collisions entre les signes et le curseur
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
//Collisions entre les chiffres et le curseur
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
    if (i > 2) {
      wallRemoving();
    }
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
//Permet au curseur de ne pas sortir de l'écran
void keepInScreen() {
  //Bas
  if (curseurY+(curseurSize/2) > height) { 
    curseurY = height-(curseurSize/2);
  }//Haut
  if (curseurY-(curseurSize/2) < 0) {
    curseurY = (curseurSize/2);
  }
  //Gauche de l'écran
  if (curseurX-(curseurSize/2) < 0) {
    curseurX = (curseurSize/2);
  }
  //Droite de l'écran
  if (curseurX+(curseurSize/2) > width) {
    curseurX = width-(curseurSize/2);
  }
}
//Collisions entre les nombres et les murs
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

      numberC[0] += 2;
    } else if (
      (nbX+(nbT)>wallBottomX) &&
      (nbX-(nbT)<wallBottomX+wallBottomWidth) &&
      (nbY+(nbT)>wallBottomY) &&
      (nbY-(nbT)<wallBottomY+wallBottomHeight)
      ) {

      numberC[0] += 2;
    }
  }
  if (nbX < wallTopX+ (wallTopWidth /2)) {
    if (
      (nbX+(nbT)>wallTopX) &&
      (nbX-(nbT)<wallTopX+wallTopWidth) &&
      (nbY+(nbT)>wallTopY) &&
      (nbY-(nbT)<wallTopY+wallTopHeight)
      ) {

      numberC[0] -= 2;
    } else if (
      (nbX+(nbT)>wallBottomX) &&
      (nbX-(nbT)<wallBottomX+wallBottomWidth) &&
      (nbY+(nbT)>wallBottomY) &&
      (nbY-(nbT)<wallBottomY+wallBottomHeight)
      ) {

      numberC[0] -= 2 ;
    }
  }
}
//Collisions entre les signes et les murs
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
      signC[0] += 2;
    } else if (
      (sX+(sT)>wallBottomX) &&
      (sX-(sT)<wallBottomX+wallBottomWidth) &&
      (sY+(sT)>wallBottomY) &&
      (sY-(sT)<wallBottomY+wallBottomHeight)
      ) {
      signC[0] += 2;
    }
  }
  if (sX < wallTopX+ (wallTopWidth /2)) {
    if (
      (sX+(sT)>wallTopX) &&
      (sX-(sT)<wallTopX+wallTopWidth) &&
      (sY+(sT)>wallTopY) &&
      (sY-(sT)<wallTopY+wallTopHeight)
      ) {
      signC[0] -= 2;
    } else if (
      (sX+(sT)>wallBottomX) &&
      (sX-(sT)<wallBottomX+wallBottomWidth) &&
      (sY+(sT)>wallBottomY) &&
      (sY-(sT)<wallBottomY+wallBottomHeight)
      ) {
      signC[0] -= 2 ;
    }
  }
}
//Collisions entre les murs et le curseur
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
//On assure la fermeture de Java quand on quitte le jeu
void stop() {
  super.stop();
  super.exit();
} 

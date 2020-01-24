 //<>//

/* VARIABLES */

final int POSITION_FINALE = 63;
int mouseIsPressed = 0;
int widthScreen = 1450;
int heightScreen = 1000;
int victoireScreen =0;

PImage bg;

PImage frodo;
PImage gandalf;
PImage aragorn;
PImage gimli;
PImage arwen;

PImage beauf;
PImage beauf1;
PImage beauf2;
PImage beauf3;
PImage beauf4;

PImage case_oie_img;
PImage case_puit_img;
PImage case_victoire_img;


//myFont = createFont(anir.ttf, 32);

/* PLATEAU */

float posX_plateau = widthScreen/63, posY_plateau = heightScreen/10, caseHeight =heightScreen/15, caseWidth= widthScreen / 15;
int case_hotel = 19;
int temp_caseHotel = 2;
int case_laby = 42;
int tete_mort = 58;
int switchPuit = 0;
int switchPrison = 0;
int centreCase [] = {((width*10)/63)};
int centreCaseY [] = {((int)posY_plateau)};


/* JEU */

int jouer = 0;
int nombreDePas=0;
int victoire = 0;
int tour_de_jeu = 0;

/* JOUEUR */

float posX_joueur [] = {10};
float posY_joueur [] = {posY_plateau + (caseHeight/5)};
int couleur_joueur [] = {(int)random(0, 500)};
int nombre_de_joueurs = 5;
int joueurs[] = {0}; //POSITIONS DES JOUEURS//
int joueurs_position_precedente[] = {0};
int joueurs_puit[] = {0}; //S'ILS SONT DANS LE PUIT OU NON//
int compteur_joueur =0;

String infos = "";
String infos1 = "";

void setup() {
  size(1500, 1000); 
  frameRate(600);
  bg = loadImage("background.jpg");

  frodo = loadImage("frodo.png");
  gandalf = loadImage("gimli.png");
  aragorn = loadImage("gandalf.png");
  gimli = loadImage("arwen.png");
  arwen = loadImage("aragorn.png");

  beauf = loadImage("beauf.png");
  beauf1 = loadImage("beauf1.png");
  beauf2 = loadImage("beauf2.png");
  beauf3 = loadImage("beauf3.png");
  beauf4 = loadImage("beauf4.png");

  case_oie_img = loadImage("case_oie.jpg");
  case_puit_img = loadImage("case_puit.jpg");
  case_victoire_img = loadImage("case_victoire.jpg");


  println (caseHeight + " et " + caseWidth);


  coordCase(POSITION_FINALE); //CREATION DU TABLEAU DES CASES DE JEU//
  joueurs(nombre_de_joueurs); //CREATION DES DIFFERENTS TABLEAUX CONTENANT INFOS DE JEU//
}



/* PARTIE GRAPHIQUE */

void draw() {
  if(victoireScreen == 1) {
   victoryScreen(); 
  }
  
  cleanScreen();
  gameScreen();

}

void cleanScreen() {
  background(bg);
}

/* FONCTIONS */

void gameScreen() {
  drawButton();
  dessinerPlateau();

  jeu_de_loie(nombre_de_joueurs);
}

public void mouseReleased() {
  mouseIsPressed = 0;
}

public void mousePressed() {
  mouseIsPressed = 1;
}

void jouerBouton() {
  jouer = 1;
}



/*********DESSIN*********/

/* Plateau */

void dessinerPlateau() {
  drawCase(POSITION_FINALE);
  caseLaby();
  caseOies(9);
  caseHotel();
  caseMort();
  casePrison();
  casePuit();
}

void drawCase(int nombre_de_cases) {
  int i = 0, posX;
  posX = (int)posX_plateau;
  while (i <= nombre_de_cases) {
    fill(#FFEEA7);
    if (i==0 || i == nombre_de_cases) {
      fill(247, 85, 57);
    }
    rect(centreCase[i], centreCaseY[i], caseWidth, caseHeight);

    if (i==nombre_de_cases) {
      rect(centreCase[i], centreCaseY[i], caseWidth*3, caseHeight*3);
      image(case_victoire_img, centreCase[i], centreCaseY[i]);
    }

    fill(0);
    textSize(50);
    text(i, centreCase[i] + (caseWidth/2), centreCaseY[i] + (caseHeight/1.5));
    i++;
    posX = (int)(posX + caseWidth);
  }
}

void caseOies(int multiple) {
  for (int i =  9; i < POSITION_FINALE; i+=9) {
    fill(255, 155, 0);
    rect(centreCase[i], centreCaseY[i], caseWidth, caseHeight);

    image(case_oie_img, centreCase[i], centreCaseY[i]);
  }
}

void caseHotel() {
  fill (#101ccc);
  rect(centreCase[case_hotel], centreCaseY[case_hotel], caseWidth, caseHeight);
}

void caseLaby () {
  fill (#10cc61);
  rect(centreCase[case_laby], centreCaseY[case_laby], caseWidth, caseHeight);
}

void caseMort() {
  fill (0);
  rect(centreCase[tete_mort], centreCaseY[tete_mort], caseWidth, caseHeight);
}

void casePuit() {
  fill (75);
  rect(centreCase[3], centreCaseY[3], caseWidth, caseHeight);
  image(case_puit_img, centreCase[3], centreCaseY[3]);
}

void casePrison() {
  fill (150);
  rect(centreCase[52], centreCaseY[52], caseWidth, caseHeight);
}

void drawButton() {
  int posX = 20, posY = 20;

  fill(#2faf38);

  if (mouseIsPressed == 1 && mouseX>posX && mouseX<(posX+100) && mouseY>posY && mouseY<posY + 50) {
    fill(100, 200, 200); 
    jouer = 1;
  }

  rect(posX, posY, 100, 50); 
  fill(0, 0, 0);
  textSize(15);
  textAlign(CENTER);
  text("JOUER", posX + 40, posY + 30);
}

/* Joueurs */

void drawPlayers(int nombre_de_joueurs) {
  for (int i=0; i < nombre_de_joueurs; i++) {
    animateJeton(i);
  }
}

void drawJeton(int joueur) {
  if (joueur ==0) {
    image(beauf, posX_joueur[joueur], posY_joueur[joueur] - (caseHeight/2));
  }

  if (joueur ==1) {
    image(beauf1, posX_joueur[joueur], posY_joueur[joueur] - (caseHeight/2));
  }
  if (joueur ==2) {
    image(beauf2, posX_joueur[joueur], posY_joueur[joueur] - (caseHeight/2));
  }
  if (joueur ==3) {
    image(beauf3, posX_joueur[joueur], posY_joueur[joueur] - (caseHeight/2));
  }
  if (joueur ==4) {
    image(beauf4, posX_joueur[joueur], posY_joueur[joueur] - (caseHeight/2));
  }

  if (joueur ==5) {
    image(frodo, posX_joueur[joueur], posY_joueur[joueur] - (caseHeight/2));
  }

  if (joueur ==6) {
    image(aragorn, posX_joueur[joueur], posY_joueur[joueur] - (caseHeight/2));
  }
  if (joueur ==7) {
    image(arwen, posX_joueur[joueur], posY_joueur[joueur] - (caseHeight/2));
  }
  if (joueur ==8) {
    image(gimli, posX_joueur[joueur], posY_joueur[joueur] - (caseHeight/2));
  }
  if (joueur ==9) {
    image(gandalf, posX_joueur[joueur], posY_joueur[joueur] - (caseHeight/2));
  }
}

void animateJeton(int joueur) {
  drawJeton(joueur);
  if (posX_joueur[joueur]<centreCase[joueurs[joueur]]) {
    posX_joueur[joueur]+=1;
  } else if (posX_joueur[joueur]>centreCase[joueurs[joueur]]) {
    posX_joueur[joueur] -= 1;
  }

  if (posY_joueur[joueur]<(centreCaseY[joueurs[joueur]] + joueur*(caseHeight/nombre_de_joueurs)) ) {
    posY_joueur[joueur]+=1;
  } else if (posY_joueur[joueur]>(centreCaseY[joueurs[joueur]] + joueur*(caseHeight/nombre_de_joueurs))) {
    posY_joueur[joueur] -= 1;
  }
}


/* Texte */

void drawTextInfo(int joueur, int pos_joueur) {
  fill(#FFDC4D);
  textSize(30);
  text("Le joueur " + joueur + " est à la position " + pos_joueur, 400, 50);
  text("C'est le " + (tour_de_jeu+1) +  "eme tour.", 400, 80);
}

void drawTextBlabla(String info ) {
  fill(#FFDC4D);
  textSize(30);
  text(info, 1000, 50);
}

void drawTextBla(String info ) {
  fill(#FFDC4D);
  textSize(30);
  text(info, 1000, 75);
}

void victory() {
  if (victoire ==1) {
    fill(200, 200, 200);
    textSize(100);
    textAlign(CENTER);
    text("VICTOIRE !!", widthScreen/2, heightScreen/2);
    drawPlayers(nombre_de_joueurs);
    victoireScreen = 1;
  }
}

void victoryScreen() {
  noLoop();
}

/*********** FONCTIONS DE JEU ***********/


void jeu_de_loie(int nombre) {

  //AFFICHE LE TEXTE//
  drawTextInfo(compteur_joueur + 1, joueurs[compteur_joueur]);    
  drawTextBlabla(infos);
  drawTextBla(infos1);
  drawPlayers(nombre_de_joueurs);



  if (compteur_joueur < nombre && joueurs[compteur_joueur] != POSITION_FINALE) {

    if (jouer==1) {

      debut_de_tour(compteur_joueur);

      //HOTEL//
      if (joueurs[compteur_joueur] ==case_hotel) {
        regle_hotel();

        //PUIT//
      } else if (joueurs[compteur_joueur] == 3 && joueurs_puit[compteur_joueur] == 1) {  
        coince_puit();

        //PRISON//
      } else if (joueurs[compteur_joueur] == 52 && switchPrison ==1) {
        coince_prison();

        //NORMAL//
      } else {
        joueurs[compteur_joueur] = jouer(joueurs[compteur_joueur], compteur_joueur);

        delay(120);
        infos1 = "Le joueur avance a la position " + joueurs[compteur_joueur];
      }  

      //POSITION FINALE ??//
      fin_de_tour_joueur();
    } 
    //FIN DU TOUR DU JOUEUR//
  } else {//FIN DU TOUR// 

    compteur_joueur=0; 
    tour_de_jeu++;
    println("C'EST LE TOUR " + (tour_de_jeu+1) + " ZEBIIII!!!");
  }
}

int jouer(int position, int compteur) {
  int dices [] = lancer_dice();  
  joueurs_position_precedente[compteur] = joueurs[compteur];  

  println("Le joueur lance les dés");
  println("Il fait un " + dices[0] + " et un " + dices[1]);
  println("");


  if (tour_de_jeu == 0) { //REGLES DE COMMENCEMENT//
    position= commencement_regles(dices[0], dices[1]);
  } else { //JEU NORMAL// 

    position = avancer(position, dices[2]);

    if (position>POSITION_FINALE) { //DEPASSEMENT//
      position = depassement(position, POSITION_FINALE);
      jouer = 0;
    }

    if (position%9==0 && position != POSITION_FINALE && position != 0 && jouer == 1) { //CASES OIES//
      position = regle_oie(position, dices[2]);
    }
  } //FIN TOUR DE JEU

  //position = 4;  //TESTEUR//

  if (position ==POSITION_FINALE) {//VICTOIRE ?//
    println("VICTOIRE");
    infos = "VICTOIRE";
    victoire = 1;
    victory();

  }

  //INTERACTION ENTRE JOUEURS//
  position = interaction_entre_joueurs(position, compteur);



  position = regles_speciales(position, compteur);

  //FIN DU TOUR DU JOUEUR//      
  jouer = 0;
  return position;
}


int [] lancer_dice() { 

  int dice1 = (int)(random(1, 7));
  int dice2 = (int)(random(1, 7));
  int [] dices = {dice1, dice2, (dice1 + dice2)};
  nombreDePas = dices[2];

  return dices;
}

int avancer(int position, int nombre) {
  return (position + nombre);
}

void regle_hotel () {
  if (temp_caseHotel>0) {  
    println("Vous êtes coincé en case Hotel pour " + temp_caseHotel + " tours.");
    temp_caseHotel--;
  } else if (joueurs[compteur_joueur]==case_hotel && temp_caseHotel == 0) {
    println("Vous sortez enfin de l'hotel et pouvez jouer");
    joueurs[compteur_joueur] = jouer(joueurs[compteur_joueur], compteur_joueur);
    temp_caseHotel = 2;
  }
}

void coince_puit () {
  println("Vous restez coincé dans le puit poto"); 
  infos1 = "Vous restez coincé dans le puit poto";
}

void coince_prison () {
  println("Vous êtes en prison, passez votre tour");
  infos1 = "Vous êtes en prison, passez votre tour";
}

void fin_de_tour_joueur () {
  if (joueurs[compteur_joueur] ==POSITION_FINALE) {
    println("VICTOIRE");
    infos = "VICTOIRE";
    victoire = 1;
  } else {
    println("Il est maintenant à la case " + joueurs[compteur_joueur]);
    compteur_joueur++;

    println("===========*********=======");
    println("");
  }
}

int regle_oie (int x, int y) {
  println("Vous êtes sur une case oie, avancez du même nombre de case, soit de " + y + " cases.");
  x = avancer(x, y);
  delay(150);
  return x;
}

int interaction_entre_joueurs(int position, int compteur) {
  boolean meme_position =false;
  int ancienne_position=0;
  for (int c = 0; c < nombre_de_joueurs; c++) {
    if (position == joueurs[c] && compteur != c ) {
      meme_position = true;
      ancienne_position = joueurs_position_precedente[c];
    }
  }

  if (meme_position==true && position != 52 && position != 3 && position !=42) {
    println("Et merde vous êtes tombé sur la même case qu'un collègue, retourner à la case ou ce conios était avant d'arriver là, soit la case " + ancienne_position + " , peace");

    position = ancienne_position;
  }

  return position;
}

void debut_de_tour (int compteur) {
  println("===========*********=======");
  println("C'est le tour du joueur " + (compteur+1));
  println("Il est à la case " + joueurs[compteur]);
  println("");
  infos = "C'est le tour du joueur " + (compteur+1);
}


/****REGLES*****/

void regle_puit (int compteur) {
  if (joueurs_puit[compteur] ==0 && switchPuit == 0) { //SI LE JOUEUR TOMBE DANS LE PUIT//
    println("Vous êtes tombé dans le puits, vous devez attendre que quelqu'un d'autre vous sauve. Vous passez votre tour.");
    joueurs_puit[compteur] = 1;
    switchPuit = 1;
  } else if (joueurs_puit[compteur] == 0 && switchPuit == 1) { //SI UN JOUEUR TOMBE DANS LE PUIT ALORS QU'UN AUTRE Y EST DEJA//
    println("Vous liberer l'ancien troudballe et tombez à sa place dans le puit");

    /* boucle pour libérer tout le monde */
    for (int c =0; c < nombre_de_joueurs; c++) {
      if (joueurs_puit[c] == 1) {
        joueurs_puit[c] = 0;
        println("Le joueur " + (c + 1) + " est libéré.");
      }
    }

    /* puis il tombe dans le puit */
    joueurs_puit[compteur] = 1;
    println("Le joueur " + (compteur + 1) + " tombe dans le puit");
  }
}

int commencement_regles(int x, int y) {
  int position=0;

  if (x+y ==9) {
    if (x == 6 || x == 3) {
      position = 26;
      println("Avancez case 26");
    } else {
      position = 53;
      println("Avancez case 53");
    }
  } else if (x+y ==6) {
    position = 12;
    println("La chance, vous avez fait 6 ! Avancer case 12 ");
  } else {
    position = x + y;
  }

  return position;
}

int regles_speciales(int position, int compteur) {

  if (position == 3) { // PUIT ? //
    regle_puit(compteur);

    //PRISON//
  } else if (position == 52 && switchPrison ==0) {
    println("Vous êtes mis en prison, vous devez attendre que quelqu'un d'autre vous sauve. Vous passez votre tour.");
    switchPrison = 1;
  } else if (position == 52 && switchPrison == 1) {
    println("Vous liberer l'ancien troudballe");
    switchPrison = 0;

    //LABYRINTHE//
  } else if (position == case_laby) {
    position = 30;
    println("Vous vous êtes perdu dans un labyrinthe, retourner en case 30");

    //HOTEL//
  } else if (position == case_hotel) {
    println("Lol vous êtes a l'hotel");

    //TETE DE MORT//
  } else if (position == tete_mort) {
    position = 0;
    println("Vous êtes tombé sur la case tête de mort, recommencez la partie...");
  }

  return position;
}

int depassement(int position, int finale) {
  int difference = position - finale;
  position = finale - difference;
  println("Le joueur a dépassé la dernière case, il avance case " + POSITION_FINALE + " et recule de " + difference + " pas.. Il est maintenant case " + position); 
  //posX_joueur = position;
  return position;
}


/***** TABLEAU *******/

void coordCase(int nombre_de_cases) {
  int posX;
  posX = (int)posX_plateau;
  int posY = (int)posY_plateau;
  int multi = 1;
  for (int i  = 0; i <= nombre_de_cases; i++) {

    posY = (int)(posY_plateau) + (int)caseHeight;
    posX = (int)(posX + (multi * caseWidth));


    if (i>13) {
      posY = (int)(posY_plateau) + 2*(int)caseHeight;
      posX = (int)(posX - (multi * caseWidth));
    }

    if ( i > 14) {
      posY = (int)(posY_plateau) + 3 *(int)caseHeight;
    }

    if (i > 15) {
      posX = (int)(posX - (multi * caseWidth));
    }

    if (i>29) {
      posY = (int)(posY_plateau) + 4*(int)caseHeight;
      posX = (int)(posX + (multi * caseWidth));
    }

    if (i>30) {
      posY = (int)(posY_plateau) + 5 * (int)caseHeight;
    }

    if (i>31) {
      posX = (int)(posX + (multi * caseWidth));
    }

    if (i > 45) {
      posY = (int)(posY_plateau) + 6 * (int)caseHeight;
      posX = (int)(posX - (multi * caseWidth));
    }

    if (i>46) {
      posY = (int)(posY_plateau) + 7 * (int)caseHeight;
    }

    if (i>47) {
      posX = (int)(posX - (multi * caseWidth));
    }

    if (i>57) {
      posY = (int)(posY_plateau) + 8*(int)caseHeight;
      posX = (int)(posX + (multi * caseWidth));
    }

    if (i>58) {
      posY = (int)(posY_plateau) + 9 * (int)caseHeight;
    }

    if (i>59) {
      posX = (int)(posX + (multi * caseWidth));
    }

    centreCase = splice(centreCase, posX, i);    
    centreCaseY = splice(centreCaseY, posY, i);
  }
}


void joueurs(int nombre) {
  int i = 0;
  while (i < nombre) {
    joueurs = splice(joueurs, 0, i);
    joueurs_position_precedente = splice(joueurs_position_precedente, 0, i);
    joueurs_puit = splice (joueurs_puit, 0, i);
    posX_joueur = splice(posX_joueur, centreCase[0], i);

    posY_joueur = splice(posY_joueur, centreCaseY[0] + i*(caseHeight/nombre_de_joueurs), i);

    couleur_joueur = splice(couleur_joueur, color((int)random(0, 256), (int)random(0, 256), (int)random(0, 256)), i);
    i++;
  }
}

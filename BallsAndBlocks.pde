Menu menu;
Play play;
String currScreen;
PImage im;
color[] colors = new color[]{#355070, #6D5976, #B56576, #E56B6F, #EAAC8B};

void setup() {
  size(600, 400);
  currScreen = "menu";

  menu = new Menu();
  play = new Play();
  im = loadImage("ocean-background.png");
}

void draw() {
  image(im, 0, 0, width, height);

  // set current screen to main menu
  if (currScreen == "menu") {
    menu.display();
  } 
  // set current screen to play mode
  else if (currScreen == "play") {
    play.display();
  } 
  // set current screen to leaderboard page
  else if (currScreen == "leaderboard") {
    background(#6B7BB7);
    text("LEADERBOARD", width/2, height/2);
  }
  // set current screen to gameover page
  else if (currScreen == "gameover") {
    background(#B76B6C);
    text("GAMEOVER :(", width/2, height/2);
  }
}

void keyPressed() {
  if (key == ' ') {
    currScreen = "menu";
    play = new Play();
  }
}

void mousePressed() {
  // menu's button functionality
  if (currScreen == "menu") {
    if (menu.playBtn.mouseOver()) {
      currScreen = "play";
    }
    if (menu.leaderboardBtn.mouseOver()) {
      currScreen = "leaderboard";
    }
    if (menu.diffBtn.mouseOver()) {
      menu.changeDifficulty();
    }
  }
}
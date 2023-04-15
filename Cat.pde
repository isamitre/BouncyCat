class Cat {
  float x, y, vy, vx, g;
  float speed;
  float diam;
  float angle;
  PImage icon;
  float barX, barY;
  float spinSpeed;
  boolean isEasy;
  boolean gameover;

  // Cat constructor
  public Cat(float x, float y, float bx, float by, boolean isEasy) {
    this.x = x;
    this.y = y;
    barX = bx;
    barY = by;
    this.isEasy = isEasy;
    gameover = false;
    // update Difficulty
    if (isEasy)
    {
      g = 0.3;
      speed = -10;
      spinSpeed = 0.1;
    } else {
      g = 0.4;
      speed = -15;
      spinSpeed = 0.3;
    }
    vy = 0;
    vx = 0;
    diam = 25;
    angle = random(0, TWO_PI);
    icon = loadImage("cat1.png");
  }

  // update cat location and check for bar/wall collisions
  void update() {
    y += vy;
    vy +=g;
    x += vx;

    //Check for bar collision
    if (y + diam >=height) {
      gameover = true; //IS THIS NECESSARY?
    } else if (y + diam/2>= mouseY-barY/2-10 && y + diam/2 <= mouseY+barY/2+10
      && x>=mouseX-barX/2 && x<=mouseX+barX/2 && vy>0) {
      vy = speed;
      y = mouseY-barY/2-diam/2;
      vx = map(x, mouseX-barX/2, mouseX+barX/2, -5, 5);
    }

    //Wall collision
    if ((x-diam/2) <= 0 || (x+diam/2) >= width) {
      vx = -vx;
    }

    //Add angle to have cat rotating
    angle += spinSpeed;
  }

  //Draw the cat
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    imageMode(CENTER);
    image(icon, 0, 0, diam, diam);
    popMatrix();
  }

  // change cat direction based on block collisions
  void handleBlockCollisions(ArrayList<Block> blocks) {
    for (Block currBlock : blocks) {
      if ( (x+diam/2) >= currBlock.x
        && (x-diam/2) <= (currBlock.x+currBlock.diam)
        && (y+diam/2) >= currBlock.y
        && (y-diam/2) <= (currBlock.y+currBlock.diam)) {
        // vertical block collision with cat, change cat's y direction
        vy = -vy;
      }
      if ( (y+diam/2) >= currBlock.y
        && (y-diam/2) <= (currBlock.y+currBlock.diam)
        && (x+diam/2) >= currBlock.x
        && (x-diam/2) <= (currBlock.x+currBlock.diam)) {
        // horizontal block collision with cat, change cat's x direction
        vx = -vx;
      }
    }
  }
}

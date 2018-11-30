class Stage {

  Player player;
  Enemy[] enemies;
  int enemyNum;

  float groundY = 500;

  float initX = 200;
  float transX = initX;
  float transY = 0;

  Stage() {
    player = new Player(initX, groundY-80, 80, groundY);
    enemyNum = 20;
    enemies = new Enemy[enemyNum];
    for(int i=0; i<enemyNum; i++) {
      enemies[i] = new Enemy();
    }
  }

  void step() {
    if (shouldAddEnemy()) {
      addEnemy();
    }

    player.step();
    for(int i=0; i<enemyNum; i++) {
      if (enemies[i].x+200 < player.centerX) {
        enemies[i].clear();
      }
      enemies[i].step();
    }

    for(int i=0; i<enemyNum; i++) {
      Enemy e = enemies[i];
      if (e.isActive) {
        if (player.collide(e)) {
          e.clear();
          break;
        }
      }
    }
  }

  void draw() {
    // ground
    stroke(220, 160, 180);
    strokeWeight(4);
    noFill();
    line(0, groundY, WINDOW_WIDTH, groundY);

    // player & enemies
    pushMatrix();
    translate(transX-player.centerX, 0);
    player.draw();
    for(int i=0; i<enemyNum; i++) {
      enemies[i].draw();
    }
    popMatrix();

    // player rest
    {
      float s = 40;
      stroke(40, 150, 190);
      fill(0, 10, 50);
      strokeWeight(2);
      for(int i=0; i<player.rest; i++) {
        float x = WINDOW_WIDTH - 10 - s*1.2*(i+0.5);
        float y = 10 + s/2;
        ellipse(x, y, s, s);
      }
    }

    // score
    {
      textAlign(LEFT);
      textSize(50);
      fill(255);
      String str = "dist: " + score();
      text(str, 10, 50);
    }
  }

  int score() {
    return (int)(player.centerX-initX);
  }

  boolean isGameOver() {
    return player.rest == 0;
  }

  float ____x = 200;
  boolean shouldAddEnemy() {
    if (____x<player.centerX) {
      ____x += 300;
      return true;
    }
    return false;
  }

  int enemyIndex = 0;
  void addEnemy() {
    Enemy e = enemies[enemyIndex];
    int n = min(8, 3+frameCount/60/10);
    e.set(player.centerX + WINDOW_WIDTH, random(groundY-e.radius*n, groundY-e.radius));
    enemyIndex = (enemyIndex + 1)%enemyNum;
  }
}

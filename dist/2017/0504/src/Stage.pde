class Stage {

  int score = 0;

  int count = 0;

  float left = 0;
  float top = 0;

  float PLAYER_X = STAGE_WIDTH/2f;
  float PLAYER_Y = 50f;

  Background background;

  Player player;

  int WALL_NUM = 20;
  int wallIndex = 0;
  Wall[] walls = new Wall[WALL_NUM];

  Stage() {
    background = new Background();
    player = new Player(PLAYER_X, PLAYER_Y);
    for(int i=0; i<WALL_NUM; i++) {
      walls[i] = new Wall();
    }
  }

  void step() {

    if (count % 120 == 0) {
      addWall();
    }


    background.step();
    player.step();
    for(int i=0; i<WALL_NUM; i++) {
      if (walls[i].isActive) {
        walls[i].step();
      }
    }

    for(int i=0; i<WALL_NUM; i++) {
      if (walls[i].isActive) {
        Wall w = walls[i];
        boolean isHit = segmentAndSegment(player.preX, player.preY, player.x, player.y, w.x1, w.y1, w.x2, w.y2);
        if (isHit) {
          player.isHit = true;
        }
      }
    }

    if (!player.isHit) {
      for(int i=0; i<WALL_NUM; i++) {
        Wall w = walls[i];
        if (w.isActive && !w.isOK) {
          if (w.y1 < player.y && w.y2 < player.y) {
            w.isOK = true;
            score++;
          }
        }
      }
    }

    top = player.y - PLAYER_Y;

    count++;
  }

  void draw() {
    background.draw(left, top);
    for(int i=0; i<WALL_NUM; i++) {
      if (walls[i].isActive) walls[i].draw(left, top);
    }
    player.draw(left, top);
  }

  void addWall() {
    float x1 = 0;
    float y1 = top + STAGE_HEIGHT + 20;
    float x2 = 0;
    float y2 = y1;

    if (random(2) < 1) {
      x1 = -50;
      x2 = x1+50+150+random(0, 40);
    } else {
      x1 = STAGE_WIDTH+50;
      x2 = x1-50-150-random(0, 40);
    }
    walls[wallIndex].set(x1, y1, x2, y2);
    wallIndex = (wallIndex + 1) % WALL_NUM;
  }

  boolean segmentAndSegment(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
    float tx1 = x2-x1;
    float ty1 = y2-y1;
    float tx2 = x4-x3;
    float ty2 = y4-y3;
    float tx3 = x3-x1;
    float ty3 = y3-y1;

    float c = tx1*ty2 - ty1*tx2;
    if (c == 0) return false;

    float c1 = tx3*ty1 - ty3*tx1;
    float c2 = tx3*ty2 - ty3*tx2;
    float t1 = c2/c;
    float t2 = c1/c;

    return 0<t1 && t1<1 && 0<t2 && t2<1;
  }

  boolean isGameOver() {
    return player.isHit;
  }
}

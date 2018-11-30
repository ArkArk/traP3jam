
class StageManager {
  
  int score = 0;
  int playtime = 0;
  
  Player player;
  Path path;
  Point[] pointAry = new Point[POINT_NUM];
  
  SideMenu sideMenu;
  
  GameOver gameOver;
  
  StageManager() {
    path = new Path();
    player = new Player(STAGE_WIDTH/2, STAGE_HEIGHT/2, pointAry, path);
    for(int i=0; i<POINT_NUM; i++) {
      pointAry[i] = new Point(i, player, pointAry);
    }
    sideMenu = new SideMenu();
    gameOver = new GameOver();
    
    setPoints();
  }
  
  void step() {
    if (checkFinished()) {
      gameOver.step();
    } else {
      player.step(playtime);
      path.step();
      for(int i=0; i<POINT_NUM; i++) {
        pointAry[i].step();
      }
      sideMenu.step();
      if (player.poyoFlg) {
        player.poyoFlg = false;
        score++;
      }
      playtime++;
    }
    sideMenu.score = score;
    sideMenu.playtime = playtime;
    gameOver.score = score;
    gameOver.playtime = playtime;
    for(int i=0; i<POINT_NUM; i++) {
      pointAry[i].playtime = playtime;
    }
  }
  
  void draw() {
    for(int i=0; i<POINT_NUM; i++) {
      pointAry[i].draw();
    }
    if (path.isActive) path.draw();
    player.draw();
    sideMenu.draw();
    if (checkFinished()) {
      gameOver.draw();
    }
  }
  
  boolean checkFinished() {
    
    if (player.isDead) return true;
    return false;
  }
  
  void setPoints() {
    for(int i=0; i<POINT_NUM; i++) {
      pointAry[i].replace();
    }
  }
  
}
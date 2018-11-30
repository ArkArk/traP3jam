
class StageManager {
  
  boolean isFinished = false;
  
  int score;
  int playtime;
  
  float[] yAry;
  
  Player player;
  BorderLine border;
  SideMenu sideMenu;
  Background background;
  GameOver gameOver;
  
  EnemyManager enemyManager;
  
  StageManager() {
    player = new Player(STAGE_WIDTH/2, BORDER_HEIGHT);
    border = new BorderLine();
    sideMenu = new SideMenu(player);
    
    int num = 7;
    yAry = new float[num];
    yAry[0] = 0f;
    float h = BORDER_HEIGHT;
    for(int i=1; i<num; i++) {
      h /= 2f;
      yAry[i] = yAry[i-1]+h;
    }
    yAry[num-1] = BORDER_HEIGHT;
    
    background = new Background(yAry);
    enemyManager = new EnemyManager();
    gameOver = new GameOver();
    score = 0;
    playtime = 0;
  }
  
  void step() {
    if (checkFinished()) {
      gameOver.step();
      isFinished = true;
    } else {
      background.step();
      border.step();
      player.step();
      sideMenu.step();
      enemyManager.step();
      collide();
      checkEnemy();
      
      if (player.hp>0)playtime++;
    }
    sideMenu.score = score;
    sideMenu.playtime = playtime;
    gameOver.score = score;
    gameOver.playtime = playtime;
  }
  
  boolean checkFinished() {
    if (player.hp<0) return true;
    if (player.hp>0) return false;
    Enemy[] enemyArray = enemyManager.enemyArray;
    for(int i=0; i<enemyArray.length; i++) {
      Enemy enemy = enemyArray[i];
      if(enemy.isDead && enemy.isActive) {
        return false;
      }
    }
    return true;
  }
  
  void draw() {
    background.draw();
    border.draw();
    player.draw();
    sideMenu.draw();
    enemyManager.draw();
    if (checkFinished()) {
      gameOver.draw();
    }
  }
  
  void collide() {
    Enemy[] enemyArray = enemyManager.enemyArray;
    Bullet[] bulletArray = player.bulletArray;
    for(int i=0; i<enemyArray.length; i++) {
      Enemy enemy = enemyArray[i];
      if (enemy.isDead) continue;
      
      for(int j=0; j<bulletArray.length; j++) {
        Bullet bullet = bulletArray[j];
        if (!bullet.isActive) continue;
        
        float x = bullet.x-enemy.x;
        float y = bullet.y-enemy.y;
        float r = bullet.r+enemy.r;
        if (x*x + y*y < r*r) {
          addScore(enemy);
          enemy.kill();
          bullet.kill();
        }
      }
    }
  }
  
  void checkEnemy() {
    Enemy[] enemyArray = enemyManager.enemyArray;
    for(int i=0; i<enemyArray.length; i++) {
      Enemy enemy = enemyArray[i];
      if (enemy.isDead) continue;
      
      if (enemy.y > STAGE_HEIGHT) {
        player.hp--;
        enemy.explode();
      }
    }
  }
  
  void addScore(Enemy enemy) {
    int nowS = 0;
    for(int i=1; i<yAry.length; i++) {
      if (enemy.y<=yAry[i]+enemy.r) {
        nowS = i*i*i*i;
        break;
      }
    }
    enemy.score = nowS;
    score += nowS;
  }
}
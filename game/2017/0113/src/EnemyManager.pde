
class EnemyManager {
  
  Enemy[] enemyArray = new Enemy[ENEMY_MAX_NUM];
  private int enemyIndex = 0;
  
  private int time;
  
  EnemyManager() {
    for(int i=0; i<enemyArray.length; i++) {
      enemyArray[i] = new Enemy();
    }
    time = 0;
  }
  
  void step() {
    
    if (time < 600) {
      if (time%80==0) {
        int id = 0;
        float x = getRandomX();
        float y = 0f;
        float speed = 2f;
        enemyArray[enemyIndex].set(id, x, y, speed);
        enemyIndex = (enemyIndex+1)%enemyArray.length;
      }
    } else if (time<1200) {
      if (time%60==0 && time%120!=0) {
        int id = 0;
        float x = getRandomX();
        float y = 0f;
        float speed = 2f;
        enemyArray[enemyIndex].set(id, x, y, speed);
        enemyIndex = (enemyIndex+1)%enemyArray.length;
      }
      if (time%120==0) {
        int id = 1;
        float x = getRandomX();
        float y = 0f;
        float speed = 2f;
        enemyArray[enemyIndex].set(id, x, y, speed);
        enemyIndex = (enemyIndex+1)%enemyArray.length;
      }
    } else if (time<2400) {
      if (time%60==0 && time%120!=0) {
        int id = 0;
        float x = getRandomX();
        float y = 0f;
        float speed = 3f;
        enemyArray[enemyIndex].set(id, x, y, speed);
        enemyIndex = (enemyIndex+1)%enemyArray.length;
      }
      if (time%120==0) {
        int id = 1;
        float x = getRandomX();
        float y = 0f;
        float speed = 2f;
        enemyArray[enemyIndex].set(id, x, y, speed);
        enemyIndex = (enemyIndex+1)%enemyArray.length;
      }
    } else if (time<4800) {
      if (time%60==0 && time%120!=0) {
        int id = 0;
        float x = getRandomX();
        float y = 0f;
        float speed = 5f;
        enemyArray[enemyIndex].set(id, x, y, speed);
        enemyIndex = (enemyIndex+1)%enemyArray.length;
      }
      if (time%120==0) {
        int id = 1;
        float x = getRandomX();
        float y = 0f;
        float speed = 3f;
        enemyArray[enemyIndex].set(id, x, y, speed);
        enemyIndex = (enemyIndex+1)%enemyArray.length;
      }
    } else {
      if (time%60==0 && time%120!=0) {
        int id = 0;
        float x = getRandomX();
        float y = 0f;
        float speed = 8f;
        enemyArray[enemyIndex].set(id, x, y, speed);
        enemyIndex = (enemyIndex+1)%enemyArray.length;
      }
      if (time%120==0) {
        int id = 1;
        float x = getRandomX();
        float y = 0f;
        float speed = 4f;
        enemyArray[enemyIndex].set(id, x, y, speed);
        enemyIndex = (enemyIndex+1)%enemyArray.length;
      }
    }
    
    for(int i=0; i<enemyArray.length; i++) {
      Enemy enemy = enemyArray[i];
      if (enemy.isActive) enemy.step();
    }
    
    time++;
  }
  
  float getRandomX() {
    return random(20f, STAGE_WIDTH-20f);
  }
  
  void draw() {
    for(int i=0; i<enemyArray.length; i++) {
      Enemy enemy = enemyArray[i];
      if (enemy.isActive) enemy.draw();
    }
  }
}
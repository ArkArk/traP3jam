
class Player {
  
  float x;
  float y;
  float r = 10;
  int hp;
  
  private Bullet[] bulletArray = new Bullet[BULLET_MAX_NUM];
  private int bulletIndex = 0;
  
  private int BULLET_DURATION = 10;
  private int bulletTimeCount = 0;
  
  private boolean isActive = true;
  
  Player(float x, float y) {
    this.x = x;
    this.y = y+r;
    this.hp = PLAYER_HP;
    for(int i=0; i<bulletArray.length; i++) {
      bulletArray[i] = new Bullet();
    }
  }
  
  void step() {
    input();
    
    for(int i=0; i<bulletArray.length; i++) {
      Bullet bullet = bulletArray[i];
      if (bullet.isActive) bullet.step();
    }
    
    if (x+r>STAGE_WIDTH) {
      x = STAGE_WIDTH-r;
    }
    if (x-r<0) {
      x = r;
    }
    bulletTimeCount++;
  }
  
  void input() {
    if (isActive) {
      if (keyPressed && key == ' ' && bulletTimeCount>=BULLET_DURATION) {
        addBullet();
      }
      if (mousePressed) {
        x = mouseX;
      }
    }
  }
  
  void addBullet() {
    bulletArray[bulletIndex].set(this.x, this.y-5);
    bulletIndex = (bulletIndex+1)%bulletArray.length;
    bulletTimeCount = 0;
  }
  
  void draw() {
    stroke(100, 230, 150);
    fill(110, 210, 130);
    ellipse(x, y, 2*r, 2*r);
    
    for(int i=0; i<bulletArray.length; i++) {
      Bullet bullet = bulletArray[i];
      if (bullet.isActive) bullet.draw();
    }
  }
}
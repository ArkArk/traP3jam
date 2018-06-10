
class Player {
  
  float centerX;
  float centerY;
  float r = 0;
  float theta = 90;
  
  float radius = 10f;
  
  float getX() {
    return centerX + r*cos(radians(theta));
  }
  float getY() {
    return centerY + r*sin(radians(theta));
  }
  
  boolean isDead = false;
  
  Path path;
  Point[] pointAry;
  
  private boolean isActive = true;
  
  Player(float x, float y, Point[] pointAry, Path path) {
    this.centerX = x;
    this.centerY = y;
    this.pointAry = pointAry;
    this.path = path;
  }
  
  void step(int playtime) {
    if (isActive) {
      float speed = pow(playtime/100f + 1, 0.2f);
      if (leftPressed)  theta += 2f*speed;
      if (rightPressed) theta -= 2f*speed;
      r += 0.5f*speed;
      
      checkCollide();
    }
  }
  
  void draw() {
    
    // line
    
    strokeWeight(5f);
    stroke(100, 230, 150, 100);
    fill(110, 210, 130, 100);
    line(centerX, centerY, getX(), getY());
    
    if (!path.isActive) {
      // center
      strokeWeight(3f);
      stroke(100, 230, 150, 150);
      fill(110, 210, 130, 150);
      ellipse(centerX, centerY, 10, 10);
    }
    
    
    // player
    strokeWeight(3f);
    stroke(150, 230, 200);
    fill(110, 210, 130);
    float x = getX();
    float y = getY();
    ellipse(x, y, 2*radius, 2*radius);
    
  }
  
  boolean poyoFlg = false;
  void checkCollide() {
    float x = getX();
    float y = getY();
    
    if (x-radius<0 || x+radius>STAGE_WIDTH || y-radius<0 || y+radius>STAGE_HEIGHT) {
      isDead = true;
      isActive = false;
    }
    
    for(int i=0; i<POINT_NUM; i++) {
      Point point = pointAry[i];
      if (!point.isDead) {
        float diffX = getX()-point.getX();
        float diffY = getY()-point.getY();
        float d = radius + point.radius;
        if (diffX*diffX + diffY*diffY < d*d) {
          path.set(centerX, centerY, point.getX(), point.getY(), 20);
          centerX = point.getX();
          centerY = point.getY();
          r = 0f;
          point.replace();
          poyoFlg = true;
          break;
        }
      }
    }
    
  }
}
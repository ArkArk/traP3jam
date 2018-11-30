
class Point {
  int id;
  int playtime;
  
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
  
  boolean isDead = true;
  
  Player player;
  Point[] pointAry;
  
  Point(int id, Player player, Point[] pointAry) {
    this.id = id;
    this.player = player;
    this.pointAry = pointAry;
  }
  
  void set(float x, float y) {
    this.centerX = x;
    this.centerY = y;
    isDead = false;
    theta = random(0f, 360f);
  }
  
  void step() {
    float t = 60f * 10;
    float po = pow((playtime-t)/60f + 5f, 0.2f);
    if (playtime > t) {
      theta += 1f*po;
      r = sin(radians(playtime-t)) * po * 10f;
    }
  }
  
  void draw() {
    
    if (!isDead) {
      strokeWeight(3f);
      stroke(250, 250, 200);
      fill(210, 160, 80);
      float x = getX();
      float y = getY();
      ellipse(x, y, 2*radius, 2*radius);
    }
    
  }
  
  void replace() {
    boolean flg = true;
    float x = 0f;
    float y = 0f;
    while(flg) {
      flg = false;
      float r = player.radius*4f + pow(random(0, 1f), 2f) * (STAGE_WIDTH+STAGE_HEIGHT)/4f;
      float theta = random(0, 360f);
      x = player.getX() + r*cos(radians(theta));
      y = player.getY() + r*sin(radians(theta));
      if (x-radius<0+30f || x+radius>STAGE_WIDTH-30f || y-radius<0+30f || y+radius>STAGE_HEIGHT-30f) {
        flg = true;
      }
      for(int i=0; i<POINT_NUM; i++) {
        Point point = pointAry[i];
        if (id == point.id) continue;
        float diffX = x-point.getX();
        float diffY = y-point.getY();
        float d = radius + point.radius;
        if (diffX*diffX + diffY*diffY < d*d) {
          flg = true;
        }
      }
    }
    set(x, y);
  }
}
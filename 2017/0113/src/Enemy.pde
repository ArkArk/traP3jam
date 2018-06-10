
class Enemy {
  
  int typeID;
  float x;
  float y;
  float r;
  float speed;
  
  int direction = 1;
  
  int score;
  
  boolean isActive = false;
  boolean isDead = true;
  
  boolean explosionFlg = false;
  int explosionCount;
  int explosionDuration = 60;
  
  int collapseCount;
  int collapseDuration = 60;
  
  void set(int id, float x, float y, float speed) {
    this.typeID = id;
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.r = 10f;
    isActive = true;
    isDead = false;
    explosionFlg = false;
    explosionCount = 0;
    collapseCount = 0;
  }
  
  void step() {
    if (isDead) {
      if (explosionFlg) {
        if (explosionCount >= explosionDuration) {
          isActive = false;
        }
        explosionCount++;
      } else {
        if (collapseCount >= collapseDuration) {
          isActive = false;
        }
        collapseCount++;
      }
    } else {
      switch(typeID) {
        case 0: {
          y += speed;
        } break;
        case 1: {
          y += speed;
          x += direction*speed/4f;
          if (x+r>STAGE_WIDTH) {
            x = STAGE_WIDTH-r;
            direction *= -1;
          }
          if (x-r<0) {
            x = r;
            direction *= -1;
          }
        } break;
      }
    }
  }
  
  void draw() {
    if (isDead) {
      if (explosionFlg) {
        stroke(230, 180, 150);
        noFill();
        ellipse(x, y, 2*r*(1+explosionCount), 2*r*(1+explosionCount));
      } else {        
        textAlign(LEFT);
        textSize(20);
        fill(230, 200, 50);
        String str = "+"+nf(score);
        float textW = textWidth(str);
        text(str, x-textW/2f, y);
      }
    } else {
      stroke(230, 180, 150);
      fill(200, 100, 90);
      ellipse(x, y, 2*r, 2*r);
    }
  }
  
  void kill() {
    isDead = true;
  }
  
  void explode() {
    explosionFlg = true;
    kill();
  }
}

class Bullet {
  
  float x;
  float y;
  float preY;
  float r = 5;
  
  boolean isActive = false;
  
  void set(float x, float y) {
    this.x = x;
    this.y = y;
    this.preY = y;
    isActive = true;
  }
  
  void kill() {
    isActive = false;
  }
  
  void step() {
    preY = y;
    y -= 10;
    
    if (y<0) {
      kill();
    }
  }
  
  void draw() {
    stroke(255);
    fill(100);
    ellipse(x, y, 2*r, 2*r);
  }
}
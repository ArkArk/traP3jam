class Enemy {
  float x;
  float y;
  
  float radius = 10;
  
  boolean isActive;
  
  Enemy() {
    clear();
  }
  void set(float x, float y) {
    this.x = x;
    this.y = y;
    isActive = true;
  }
  
  void clear() {
    isActive = false;
  }
  
  void step() {
    if(isActive) {
      
    }
  }
  
  void draw() {
    if (isActive) {
      stroke(200, 50, 20);
      strokeWeight(2);
      fill(80, 20, 10);
      ellipse(x, y, radius*2, radius*2);
    }
  }
}
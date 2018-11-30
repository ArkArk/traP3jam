class Wall {
  
  boolean isActive = false;
  boolean isOK = true;
  float x1, y1, x2, y2;
  
  Wall() {
    isActive = false;
  }
  
  void set(float x1, float y1, float x2, float y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.isActive = true;
    this.isOK = false;
  }
  
  void step() {
    
  }
  
  void draw(float left, float top) {
    if (!isActive) return;
    
    stroke(240, 230, 200);
    strokeWeight(5);
    line(x1-left, y1-top, x2-left, y2-top);
  }
  
}

class Goal {
  
  float x;
  float y;
  float w;
  float h;
  
  boolean isGoal;
  
  Goal(float x, float y, float w, float h, boolean isGoal) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.isGoal = isGoal;
  }
  
  void step() {
    if (!isGoal) return;
    
  }
  
  void draw() {
    if (!isGoal) return;
    
    strokeWeight(10);
    noFill();
    stroke(240, 120, 10);
    float po = TILE_SIZE*0.6;
    ellipse(x, y, po, po);
  }
}
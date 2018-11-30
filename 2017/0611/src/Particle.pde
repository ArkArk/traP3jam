class Particle {
  
  Player parent;
  
  float x;
  float y;
  
  Particle(Player parent, float radian, float radius) {
    this.parent = parent;
    x = parent.centerX + cos(radian) * radius;
    y = parent.centerY + sin(radian) * radius;
  }
  
  float getRadius() {
    float diffX = x-parent.centerX;
    float diffY = y-parent.centerY;
    return sqrt(diffX*diffX + diffY*diffY);
  }
  
  void multRadius(float r) {
    x = (x-parent.centerX)*r + parent.centerX;
    y = (y-parent.centerY)*r + parent.centerY;
  }
  
}

class Path {
  
  boolean isActive = false;
  
  int time = 0;
  int duration = -1;
  
  float x1;
  float y1;
  float x2;
  float y2;
  
  float getT() {
    float t = time/float(duration);
    
    t *= 2f;
    if (t < 1) return 0.5*t*t;
    t -= 1f;
    return -0.5 * (t*(t-2) - 1);
  }
  
  float nowX() {
    float t = getT();
    return x1*(1-t) + x2*t;
  }
  
  float nowY() {
    float t = getT();
    return y1*(1-t) + y2*t;
  }
  
  Path() {
    
  }
  
  void set(float x1, float y1, float x2, float y2, int duration) {
    isActive = true;
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    time = 0;
    this.duration = duration;
  }
  
  void step() {
    time++;
    if (time>duration) isActive = false;
  }
  
  void draw() {
    strokeWeight(5f);
    stroke(100, 230, 150, 100);
    fill(110, 210, 130, 100);
    line(nowX(), nowY(), x2, y2);
    
    strokeWeight(3f);
    stroke(100, 230, 150, 150);
    fill(110, 210, 130, 150);
    ellipse(nowX(), nowY(), 10, 10);
  }
  
}
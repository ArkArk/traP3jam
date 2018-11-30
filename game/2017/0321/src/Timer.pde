class Timer {
  
  float x, y, w, h;
  
  int duration;
  int nowT;
  Timer(float x, float y, float w, float h, int duration) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.duration = duration;
    nowT = 0;
  }
  
  void step() {
    nowT++;
  }
  
  void draw() {
    
    float r = nowT/float(duration);
    stroke(10, 180, 60, 150);
    strokeWeight(4);
    fill(40, 230, 130, 100);
    pushMatrix();
    translate(x, y);
    line(0, 0, 0, -h/2);
    rotate(-r*2f*PI - PI/2f);
    arc(0, 0, w, h, 0, r*2f*PI);
    line(0, 0, w/2, 0);
    popMatrix();
  }
  
  boolean done() {
    return nowT >= duration;
  }
  
}

class Player {
  
  int N = 36; // particleの数
  float centerX;
  float centerY;
  
  float groundY;
  
  float averageRadius;
  
  Particle[] particles;
  
  int rest = 5;
  
  boolean hitFlag;
  int hitTime;
  int hitDuring = 90;
  
  Player(float centerX, float centerY, float averageRadius, float groundY) {
    this.centerX = centerX;
    this.centerY = centerY;
    this.groundY = groundY;
    this.averageRadius = averageRadius;
    
    particles = new Particle[N];
    for(int i=0; i<N; i++) {
      float rad = radians(360f*i/N);
      particles[i] = new Particle(this, rad, averageRadius);
    }
    
    hitFlag = false;
    hitTime = hitDuring;
    
  }

  void step() {
    
    // hit に関する処理
    hitTime++;
    if (hitTime>=hitDuring) {
      hitFlag = false;
    }
    
    // extend radius
    {
      Particle p = particles[getMaximumIndex()];
      
      float d = 1.0;
      float len = p.getRadius();
      if (spacePressed) {
        p.multRadius((len + d)/len);
      } else {
        p.multRadius(max(1e-5, (len - d)/len));
      }
    }
    
    // adjust y
    {
      float maxY = getMaximumY();
      addY(groundY-maxY);
    }
    
    // rotate
    {
      Particle p = particles[getMaximumIndex()];
      float deltaTheta = 2.0*PI/720.0;
      rot(p.x, p.y, deltaTheta);
    }
    
    // adjust y
    {
      float maxY = getMaximumY();
      addY(groundY-maxY);
    }
    
    // normalize radius
    normalizeRadius();
    
    // adjust y
    {
      float maxY = getMaximumY();
      addY(groundY-maxY);
    }
      
  }
  
  void draw() {
    
    // particles
    strokeWeight(4);
    if (hitFlag) {
      stroke(40, 150, 190, 100);
      fill(0, 10, 50, 100);
    } else {
      stroke(40, 150, 190);
      fill(0, 10, 50);
    }
    beginShape();
    for(int i=0; i<=N; i++) {
      Particle p = particles[i%N];
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
  }
  
  boolean collide(Enemy e) {
    if (hitFlag) return false; // 衝突後はしばらく無敵
    
    float a = e.radius * e.radius;
    for(int i=0; i<N; i++) {
      Particle p1 = particles[i];
      Particle p2 = particles[(i+1)%N];
      boolean flag = segmentAndCircle(p1.x, p1.y, p2.x, p2.y, e.x, e.y, e.radius);
      if (flag) {
        setHit();
        return true;
      }
    }
    return false;
  }
  
  boolean segmentAndCircle(float x1, float y1, float x2, float y2, float cx, float cy, float r) {
    float dx1 = cx-x1;
    float dy1 = cy-y1;
    float dx2 = cx-x2;
    float dy2 = cy-y2;
    float dx = x2-x1;
    float dy = y2-y1;
    {
      float d = sqrt(dx*dx + dy*dy);
      dx/=d;
      dy/=d;
    }
    
    float d = abs(dx*dy1 - dy*dx1);
    if (d > r) return false;
    
    float d1 = dx1*dx + dy1*dy;
    float d2 = dx2*dx + dy2*dy;
    
    if (d1*d2 < 0) {
      return true;
    }
    if (r*r > dx1*dx1 + dy1*dy1) {
      return true;
    }
    if (r*r > dx2*dx2 + dy2*dy2) {
      return true;
    }
    return false;
  }
  
  void setHit() {
    hitFlag = true;
    hitTime = 0;
    rest--;
  }
  
  float getMaximumY() {
    float maxY = -1e10;
    for(int i=0; i<N; i++) {
      Particle p = particles[i%N];
      maxY = max(maxY, p.y);
    }
    return maxY;
  }
  
  int getMaximumIndex() {
    float maxY = -1e10;
    int index = 0;
    for(int i=0; i<N; i++) {
      Particle p = particles[i%N];
      if (p.y > maxY) {
        maxY = p.y;
        index = i;
      }
    }
    return index;
  }
  
  void addY(float diffY) {
    centerY += diffY;
    for(int i=0; i<N; i++) {
      particles[i].y += diffY;
    }
  }
  
  void rot(float rotX, float rotY, float radian) {
    float c = cos(radian);
    float s = sin(radian);
    
    for(int i=0; i<N; i++) {
      Particle p = particles[i];
      float x = p.x - rotX;
      float y = p.y - rotY;
      p.x = c*x - s*y + rotX;
      p.y = s*x + c*y + rotY;
    }
    
    float x = centerX - rotX;
    float y = centerY - rotY;
    centerX = c*x - s*y + rotX;
    centerY = s*x + c*y + rotY;
  }
  
  void normalizeRadius() {
    float sRadius = 0;
    for(int i=0; i<N; i++) {
      sRadius += particles[i].getRadius();
    }
    for(int i=0; i<N; i++) {
      particles[i].multRadius(averageRadius*N/sRadius);
    }
  }

}
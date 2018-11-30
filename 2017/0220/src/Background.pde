
class Background {
  
  float x;
  float y;
  float w;
  float h;
  
  float[] yAry;
  
  Background(float[] yAry) {
    x = STAGE_WIDTH/2f;
    y = STAGE_HEIGHT/2f;
    w = STAGE_WIDTH;
    h = STAGE_HEIGHT;
    this.yAry = yAry;
  }
  
  void step() {
    
  }
  
  void draw() {
    stroke(10, 10, 10);
    fill(0, 0, 0);
    rect(x, y, w, h);
    for(int i=1; i<yAry.length; i++) {
      float r = i/(float)yAry.length;
      stroke(50*r, 100*r, 130*r);
      fill(50*r, 100*r, 130*r);
      rect(x, (yAry[i]+yAry[i-1])/2f, w, yAry[i]-yAry[i-1]);
    }
  }
}
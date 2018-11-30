
class Background {
  
  float oneHeight = 80;
  
  Background() {
    
  }
  
  void step() {
    
  }
  
  void draw(float left, float top) {
    noStroke();
    
    int num = 4;
    float x = STAGE_WIDTH / 2f;
    float y = ((int) (top / oneHeight))*oneHeight - 1*oneHeight + oneHeight/2f;
    float w = STAGE_WIDTH;
    float h = oneHeight;
    int i = ((int) (top / oneHeight)) % num;
    while(y - top < STAGE_HEIGHT + 2*oneHeight) {
      float r = (i+1) / (float) num;
      fill(10 + 10 * r, 15 + 10 * r, 30 + 20 * r);
      rect(x-left, y-top, w, h);
      y += oneHeight;
      i = (i+1) % num;
    }
  }
}
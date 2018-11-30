
class SideMenu {
  
  float x;
  float y;
  float w;
  float h;
  
  float left;
  float top;
  
  int score;
  
  SideMenu() {
    x = (WINDOW_WIDTH+STAGE_WIDTH)/2f;
    y = STAGE_HEIGHT/2f;
    w = WINDOW_WIDTH-STAGE_WIDTH;
    h = STAGE_HEIGHT;
    left = STAGE_WIDTH;
    top = 0;
  }
  
  void step() {
    
  }
  
  void draw() {
    
    // background
    strokeWeight(1);
    stroke(120, 150, 255);
    fill(100, 110, 230);
    rect(x, y, w, h);
    
    // score
    {
      fill(255);
      textAlign(LEFT);
      textSize(20);
      String str = "score: "+(score);
      text(str, STAGE_WIDTH + 10f, STAGE_HEIGHT-10f);
    }
    
    //// stage name
    //{
    //  fill(255);
    //  textAlign(LEFT);
    //  textSize(40);
    //  fill(255);
    //  text(stageName, STAGE_WIDTH + 20f, 60f);
    //}
    
  }
}
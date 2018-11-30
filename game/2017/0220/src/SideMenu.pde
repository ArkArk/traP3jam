
class SideMenu {
  
  float x;
  float y;
  float w;
  float h;
  
  float left;
  float top;
  
  String stageName = "";
  int stageCount;
  
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
    
    // stage name
    {
      fill(255);
      textAlign(LEFT);
      textSize(40);
      fill(255);
      text(stageName, STAGE_WIDTH + 20f, 60f);
    }
    
    // stage name
    {
      fill(255);
      textAlign(LEFT);
      textSize(40);
      fill(255);
      text(stageName, STAGE_WIDTH + 20f, 60f);
    }
    
    // count
    {
      fill(255);
      textAlign(LEFT);
      textSize(40);
      fill(255);
      text("あと"+nf(stageCount, 2)+"回", STAGE_WIDTH + 20f, WINDOW_HEIGHT-80f);
    }
    
  }
}
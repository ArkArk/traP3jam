
class SideMenu {
  
  float x;
  float y;
  float w;
  float h;
  
  float left;
  float top;
  
  int score;
  int playtime;
  
  private Player player;
  
  SideMenu(Player player) {
    x = (WINDOW_WIDTH+STAGE_WIDTH)/2f;
    y = STAGE_HEIGHT/2f;
    w = WINDOW_WIDTH-STAGE_WIDTH;
    h = STAGE_HEIGHT;
    left = STAGE_WIDTH;
    top = 0;
    this.player = player;
  }
  
  void step() {
    
  }
  
  void draw() {
    // background
    stroke(120, 150, 255);
    fill(100, 110, 230);
    rect(x, y, w, h);
    
    // player hp
    for(int i=0; i<player.hp; i++) {
      float x = left + w*(i+0.5f)/PLAYER_HP;
      float y = top + 40f;
      float r = player.r;
      stroke(100, 230, 150);
      fill(90, 200, 100);
      ellipse(x, y, 2*r, 2*r);
    }
    
    // score
    {
      textAlign(LEFT);
      textSize(20);
      fill(255);
      text("score: ", left+5f, top+100f);
      
      textAlign(LEFT);
      textSize(20);
      fill(255);
      
      String str = nf(score);
      float textW = textWidth(str);
      text(str, left+w-5f-textW, top+130f);
    }
    
    // playtime
    
    {
      textAlign(LEFT);
      textSize(20);
      fill(255);
      text("playtime: ", left+5f, top+160f);
      
      textAlign(LEFT);
      textSize(20);
      fill(255);
      
      String str = nf(playtime);
      float textW = textWidth(str);
      text(str, left+w-5f-textW, top+190f);
    }
  }
}
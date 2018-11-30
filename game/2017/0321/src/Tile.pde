class Tile {
  float x;
  float y;
  float w;
  float h;
  
  int indexX;
  int indexY;
  
  int burningTime = 0;
  
  // flags
  boolean isBomb = false;
  boolean isBombActive = true;
  boolean isBombStart = false;
  boolean isBurningVis = false;
  boolean isBurning = false;
  boolean isPreBurning = false;
  boolean isDman = false;
  boolean isGopher = false;
  
  Tile(int indexX, int indexY, float x, float y, float w, float h) {
    this.indexX = indexX;
    this.indexY = indexY;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void step() {
    if (isBurning) burningTime++;
  }
  
  void draw() {
    if (isBomb) {
      if (isBombStart) {
        stroke(250, 140, 10, 220);
        strokeWeight(2);
        fill(230, 140, 10, 200);
        ellipse(x, y, w*0.7f, h*0.7f);
      }
      if (!isBombActive) tint(255, 100);
      image(bombImg, x, y, w, h);
      tint(255, 255);
    }
    if (isBurningVis) {
      tint(255, 70);
      image(fireImg, x, y, w, h);
      tint(255, 255);
    }
    if (isBurning) {
      tint(255, 200);
      image(fireImg, x, y, w, h);
      tint(255, 255);
    }
    if (isDman) {
      pushMatrix();
      translate(x, y);
      rotate(radians(burningTime*30));
      scale(pow((float)Math.E, min(2.5f, burningTime/10f)));
      image(dmanImg, 0, 0, w, h);
      popMatrix();
    }
    if (isGopher) {
      pushMatrix();
      translate(x, y);
      rotate(radians(burningTime*30));
      scale(pow((float)Math.E, -min(2.5f, burningTime/10f)));
      image(gopherImg, 0, 0, w, h);
      popMatrix();
    }
  }
  
}
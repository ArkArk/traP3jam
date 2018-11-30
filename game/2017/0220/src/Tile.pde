class Tile {
  float x;
  float y;
  float w;
  float h;
  
  // debug variables
  int initIndexX;
  int initIndexY;
  int nextInitIndexX;
  int nextInitIndexY;
  
  // rotation variavles
  float rotationX;
  float rotationY;
  int rotationT;
  int rotationDuration = 40;
  boolean rotationDir;
  
  // next variables
  boolean nextIsRotator;
  boolean nextIsTarget;
  
  // flags
  boolean isRotator = false;
  boolean isSelected = false;
  boolean isRotating = false;
  boolean isTarget = false;
  
  Tile(int indexX, int indexY, float x, float y, float w, float h) {
    initIndexX = indexX;
    initIndexY = indexY;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void step() {
    if (isRotating) {
      if (rotationT >= rotationDuration) {
        isRotating = false;
        isRotator = nextIsRotator;
        isTarget = nextIsTarget;
        initIndexX = nextInitIndexX;
        initIndexY = nextInitIndexY;
      } else {
        rotationT++;
      }
    }
  }
  
  void draw() {
    float s = TILE_SIZE*NUM;
    float two = TILE_SIZE*2;
    _draw(0, 0);
    if (x<two) _draw(s, 0);
    if (x>s-two) _draw(-s, 0);
    if (y<two) _draw(0, s);
    if (y>s-two) _draw(0, -s);
    if (x<two && y<two) _draw(s, s);
    if (x<two && y>s-two) _draw(s, -s);
    if (x>s-two && y<two) _draw(-s, s);
    if (x>s-two && y>s-two) _draw(-s, -s);
  }
  
  private void _draw(float diffX, float diffY) {
    pushMatrix();
    translate(diffX, diffY);
    translate(rotationX, rotationY);
    rotate(getAngle());
    translate(-rotationX, -rotationY);
    image(isSelected ? tileRevImg : tileImg, x, y, w, h);
    if (isRotator) image(isSelected ? rotatorRevImg : rotatorImg, x, y, w, h);
    if (isTarget) {
      strokeWeight(3);
      fill(250, 190, 60);
      stroke(240, 160, 30);
      float po = TILE_SIZE*0.4;
      ellipse(x, y, po, po);
    }
    popMatrix();
  }
  
  void initRotation(float x, float y, boolean direction, boolean nextIsRotator, boolean nextIsTarget, int nextInitIndexX, int nextInitIndexY) {
    isRotating = true;
    rotationT = 0;
    rotationX = x;
    rotationY = y;
    rotationDir = direction;
    this.nextIsRotator = nextIsRotator;
    this.nextIsTarget = nextIsTarget;
    this.nextInitIndexX = nextInitIndexX;
    this.nextInitIndexY = nextInitIndexY;
  }
  
  float getAngle() {
    if (!isRotating) return 0;
    float t = rotationT / float(rotationDuration);
    return radians(90 * easeQuadInOut(t) * (rotationDir ? 1:-1));
  }
  
  float easeQuadInOut(float t) {
    t *= 2;
    if (t < 1) return 0.5*t*t;
    t -= 1;
    return -0.5 * (t*(t-2) - 1);
  }
  
}
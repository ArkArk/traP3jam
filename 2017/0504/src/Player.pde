
class Player {

  int count = 0;

  boolean isHit = false;

  float preX;
  float preY;

  float x;
  float y;
  float vx;
  float vy;
  float theta = 0; // \in [-70, +70]

  float radius = 10;

  Player(float x, float y) {
    this.x = x;
    this.y = y;
    this.preX = x;
    this.preY = y;
    this.vx = 0;
    this.vy = 0;
  }

  void step() {

    if (isHit) {

    } else {
      preX = x;
      preY = y;

      float po = 75;
      if (leftPressed) {
        theta = max(-po, min(po, theta+2));
        //leftPressed = false;
      }
      if (rightPressed) {
        theta = max(-po, min(po, theta-2));
        //rightPressed = false;
      }

      float r = 0.6+count*0.0001f;
      float _vx = r*0.1*radius*sin(radians(theta));
      float _vy = r*0.1*radius*cos(radians(theta));

      x = max(0, min(STAGE_WIDTH, x+_vx+vx));
      y = y + _vy + vy;

      vx = r*0.2*radius*sin(radians(theta));
      vy = min(vy + r*0.08, r*1.0*radius*cos(radians(theta)));
    }

    count++;

  }

  void draw(float left, float top) {
    strokeWeight(2);

    float x1 = x-left;
    float y1 = y-top;
    float x2 = x1 + 3*radius*sin(radians(theta));
    float y2 = y1 + 3*radius*cos(radians(theta));

    strokeWeight(4);
    stroke(90, 240, 180, 100);
    line(x1, y1, x2, y2);

    strokeWeight(2);
    stroke(80, 220, 180);
    fill(90, 200, 130, 220);
    ellipse(x1, y1, 2*radius, 2*radius);

    strokeWeight(1);
    stroke(80, 220, 180, 200);
    fill(90, 210, 130, 150);
    ellipse(x2, y2, radius, radius);
  }

}

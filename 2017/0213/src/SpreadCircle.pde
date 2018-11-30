StageManager manager;

int WINDOW_WIDTH;
int WINDOW_HEIGHT;
int STAGE_WIDTH;
int STAGE_HEIGHT;

int POINT_NUM = 5;

boolean leftPressed = false;
boolean rightPressed = false;

boolean gameStartFlg = false;

void setup() {
  WINDOW_WIDTH = 800;
  WINDOW_HEIGHT = 600;
  STAGE_WIDTH = 600;
  STAGE_HEIGHT = WINDOW_HEIGHT;
  size(800, 600);
  imageMode(CENTER);
  rectMode(CENTER);

  manager = new StageManager();
}

void draw() {
  background(0);

  if (gameStartFlg) manager.step();
  manager.draw();
}

void mouseClicked() {
  gameStartFlg = true;
}

void keyPressed() {
  boolean r = (key==CODED) && (keyCode==LEFT);
  boolean l = (key==CODED) && (keyCode==RIGHT);
  if (r || l) {
    rightPressed = r;
    leftPressed = l;
  }
  //if (keyCode=='z') {
  //  leftPressed = false;
  //  rightPressed = true;
  //}
}

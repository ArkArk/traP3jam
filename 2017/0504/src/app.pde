StageManager manager;

int WINDOW_WIDTH;
int WINDOW_HEIGHT;
int STAGE_WIDTH;
int STAGE_HEIGHT;

boolean leftPressed = false;
boolean rightPressed = false;

boolean gameStartFlg = false;

void setup() {
  size(400, 600);
  WINDOW_WIDTH = 400;
  WINDOW_HEIGHT = 600;
  STAGE_WIDTH = 300;
  STAGE_HEIGHT = WINDOW_HEIGHT;
  imageMode(CENTER);
  rectMode(CENTER);

  refresh();
}

void draw() {
  background(6, 8, 20);

  if (gameStartFlg) {
    manager.step();
    manager.draw();
  }
}

void refresh() {
  manager = new StageManager();
  rightPressed = false;
  leftPressed = false;
}

void mouseClicked() {
  if (gameStartFlg) manager.mouseClicked();
  gameStartFlg = true;
}


void keyPressed() {
  boolean r = (key==CODED) && (keyCode==LEFT);
  boolean l = (key==CODED) && (keyCode==RIGHT);
  if (r || l) {
    rightPressed = r;
    leftPressed = l;
  }
  if (key == ENTER) {
    if (gameStartFlg && manager.finishFlg && manager.gameOver.count>10) refresh();
  }
  //if (keyCode=='z') {
  //  leftPressed = false;
  //  rightPressed = true;
  //}
}
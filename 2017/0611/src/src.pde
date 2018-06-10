StageManager manager;

int WINDOW_WIDTH;
int WINDOW_HEIGHT;

boolean spacePressed = false;
boolean gameStartFlg = false;

void setup() {
  size(800, 600);
  WINDOW_WIDTH = 800;
  WINDOW_HEIGHT = 600;
  imageMode(CENTER);
  rectMode(CENTER);

  refresh();
}

void draw() {
  background(0);

  if (gameStartFlg) {
    manager.step();
    manager.draw();
  }
}

void refresh() {
  manager = new StageManager();
  spacePressed = false;
}

void mouseClicked() {
  if (gameStartFlg) manager.mouseClicked();
  gameStartFlg = true;
}


void keyPressed() {
  if (key == ' ') {
    spacePressed = true;
  }
  if (key == ENTER) {
    if (gameStartFlg && manager.finishFlg && manager.gameOver.count>10) refresh();
  }
}

void keyReleased() {
  if (key==' ') {
    spacePressed = false;
  }
}
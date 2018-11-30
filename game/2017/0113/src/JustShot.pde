StageManager manager;

int WINDOW_WIDTH;
int WINDOW_HEIGHT;
int STAGE_WIDTH;
int STAGE_HEIGHT;
int BORDER_HEIGHT;

int PLAYER_HP = 3;

int BULLET_MAX_NUM = 30;
int ENEMY_MAX_NUM = 50;

boolean gameStartFlg = false;

void setup() {
  WINDOW_WIDTH = 400;
  WINDOW_HEIGHT = 600;
  STAGE_WIDTH = 300;
  STAGE_HEIGHT = WINDOW_HEIGHT;
  BORDER_HEIGHT = STAGE_HEIGHT-50;
  size(400, 600);
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

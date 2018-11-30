StageManager manager;

int WINDOW_WIDTH;
int WINDOW_HEIGHT;
int STAGE_WIDTH;
int STAGE_HEIGHT;

int NUM = 10;
int TILE_SIZE;

PImage tileImg;
PImage tileRevImg;
PImage bombImg;
PImage fireImg;
PImage dmanImg;
PImage gopherImg;

PGraphics tilePG;

int[] dx = {-3, -2, -1, 1, 2, 3, 0, 0, 0, 0, 0, 0};
int[] dy = {0, 0, 0, 0, 0, 0, -1, -2, -3, 1, 2, 3};

boolean gameStartFlg = false;

void setup() {
  size(400, 320);
  WINDOW_WIDTH = 400;
  WINDOW_HEIGHT = 32*NUM;
  STAGE_WIDTH = 32*NUM;
  STAGE_HEIGHT = WINDOW_HEIGHT;
  TILE_SIZE = STAGE_WIDTH/NUM;
  imageMode(CENTER);
  rectMode(CENTER);

  tileImg = loadImage("images/tile.gif");
  tileRevImg = loadImage("images/tile_rev.gif");
  bombImg = loadImage("images/bomb.gif");
  fireImg = loadImage("images/fire.gif");
  dmanImg = loadImage("images/dman.gif");
  gopherImg = loadImage("images/gopher.gif");

  tilePG = createGraphics(width, height);

  tilePG.beginDraw();
  for(int i=0; i<NUM; i++) {
    for(int j=0; j<NUM; j++) {
      tilePG.image(tileImg, TILE_SIZE*i, TILE_SIZE*j, TILE_SIZE, TILE_SIZE);
    }
  }
  tilePG.endDraw();

  refresh();
}

void draw() {
  background(100, 110, 230);

  image(tilePG, WINDOW_WIDTH/2, WINDOW_HEIGHT/2);
  if (gameStartFlg) {
    manager.step();
    manager.draw();
  } else {
    tilePG.beginDraw();
    for(int i=0; i<NUM; i++) {
      for(int j=0; j<NUM; j++) {
        tilePG.image(tileImg, TILE_SIZE*i, TILE_SIZE*j, TILE_SIZE, TILE_SIZE);
      }
    }
    tilePG.endDraw();
  }
}

void refresh() {
  manager = new StageManager();
}

void mouseClicked() {
  if (gameStartFlg) manager.mouseClicked();
  gameStartFlg = true;
}

void keyPressed() {
  if (key == ENTER) {
    if (gameStartFlg && manager.finishFlg && manager.gameOver.count>10) refresh();
  }
}

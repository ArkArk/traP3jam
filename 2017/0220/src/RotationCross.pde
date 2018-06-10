StageManager manager;

int WINDOW_WIDTH;
int WINDOW_HEIGHT;
int STAGE_WIDTH;
int STAGE_HEIGHT;

int NUM = 10;
int TILE_SIZE;

boolean leftPressed = false;
boolean rightPressed = false;

PImage tileImg;
PImage tileRevImg;
PImage rotatorImg;
PImage rotatorRevImg;

void setup() {
  WINDOW_WIDTH = 800;
  WINDOW_HEIGHT = 600;
  STAGE_WIDTH = 600;
  STAGE_HEIGHT = WINDOW_HEIGHT;
  TILE_SIZE = STAGE_WIDTH/NUM;
  size(800, 600);
  imageMode(CENTER);
  rectMode(CENTER);

  tileImg = loadImage("images/tile.gif");
  tileRevImg = loadImage("images/tile_rev.gif");
  rotatorImg = loadImage("images/rotator.gif");
  rotatorRevImg = loadImage("images/rotator_rev.gif");
  manager = new StageManager();
}

void draw() {
  background(0);

  manager.step();
  manager.draw();
}

void mouseClicked() {
  manager.mouseClicked();
}
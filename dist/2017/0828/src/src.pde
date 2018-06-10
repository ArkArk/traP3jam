StageManager manager;

int WINDOW_WIDTH;
int WINDOW_HEIGHT;

boolean gameStartFlg = false;

void setup() {
    size(400, 400);
    WINDOW_WIDTH = 400;
    WINDOW_HEIGHT = 400;
    imageMode(CENTER);
    rectMode(CENTER);

    refresh();
}

void draw() {
    background(0);

    if (gameStartFlg) {
        manager.step();
    }
    manager.draw();
}

void refresh() {
    manager = new StageManager();
}

void keyPressed() {
    if (key == ENTER || key == ' ') {
        if (gameStartFlg && manager.finishFlg && manager.gameOver.count > 10) {
            refresh();
        } else {
            gameStartFlg = true;
        }
    }
}

void mouseClicked() {
    gameStartFlg = true;
}

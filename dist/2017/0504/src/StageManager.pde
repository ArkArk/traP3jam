
class StageManager {
  Stage stage = new Stage();
  SideMenu sideMenu;

  boolean finishFlg = false;
  GameOver gameOver;

  StageManager() {
    sideMenu = new SideMenu();
    gameOver = new GameOver();
  }

  void step() {
    if (finishFlg) {
      gameOver.step();
    } else {
      stage.step();
      if (stage.isGameOver()) {
        finishFlg = true;
      }
    }
    sideMenu.step();
    gameOver.score = stage.score;
    sideMenu.score = stage.score;
  }

  void draw() {
    stage.draw();
    sideMenu.draw();
    if (finishFlg) gameOver.draw();
  }

  void mouseClicked() {
    
  }
}
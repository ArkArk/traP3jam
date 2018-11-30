
class StageManager {
  Stage stage = new Stage();

  boolean finishFlg = false;
  GameOver gameOver;

  StageManager() {
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
    gameOver.score = stage.score();
  }

  void draw() {
    stage.draw();
    if (finishFlg) gameOver.draw();
  }

  void mouseClicked() {
    
  }
}
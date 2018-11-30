
class StageManager {
  Stage stage;
  SideMenu sideMenu;
  int stageIndex = 0;

  boolean fadeFlg = false;
  int fadeTime;
  int fadeDuration = 10;

  boolean finishFlg = false;
  GameOver gameOver;
  
  StageGenerator stageGenerator = new StageGenerator();

  StageManager() {
    sideMenu = new SideMenu();
    gameOver = new GameOver();
    setStage();
  }

  void step() {
    if (finishFlg) {
      gameOver.step();
    } else {
      if (fadeFlg) {
        fadeTime++;
        if (fadeTime == fadeDuration/2) {
          stageIndex++;
          setStage();
        }
        if (fadeTime == fadeDuration) {
          fadeFlg = false;
          fadeTime = 0;
        }
      } else {
        stage.step();
        if (stage.isFinished()) {
          fadeFlg = true;
          if (stage.isGameOver()) {
            gameOver.stageIndex = stageIndex;
            finishFlg = true;
          }
        }
      }
    }

    sideMenu.stageIndex = stageIndex;
    sideMenu.step();
  }

  void draw() {
    stage.draw();
    if (fadeFlg && !finishFlg) {
      float r = 1 - abs(fadeTime-fadeDuration/2)/float(fadeDuration/2);
      fill(0, 255*r);
      rect(width/2, height/2, width*1.5, height*1.5);
    }
    sideMenu.draw();
    if (finishFlg) gameOver.draw();
  }
  
  void setStage() {
    stage = stageGenerator.get(stageIndex);
  }

  void mouseClicked() {
      stage.mouseClicked();
  }
}
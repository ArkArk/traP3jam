
class StageManager {
  Stage stage;
  SideMenu sideMenu;
  int stageIndex = 0;

  boolean fadeFlg = false;
  int fadeTime;
  int fadeDuration = 10;

  boolean finishFlg = false;
  GameOver gameOver;

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
        if (stage.checkClear()) {
          fadeFlg = true;
        }
      }
    }

    sideMenu.stageCount = stage.stageCount;
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

  void mouseClicked() {
    if (mouseButton == LEFT) {
      stage.mouseClicked();
    } else if (mouseButton == RIGHT) {
      if (stage.checkRotating()) return;
      setStage();
    }
  }

  void setStage() {
    int[][] stageData = new int[NUM][NUM];
    boolean[][] goalData = new boolean[NUM][NUM];
    int stageCount = 0;
    boolean debugMode = false;

    for(int i=0; i<NUM; i++) {
      for(int j=0; j<NUM; j++) {
        stageData[i][j] = 0;
        goalData[i][j] = false;
      }
    }

    // stageIndex = -1; // debug

    switch(stageIndex) {
      case -1: {
        // debug stage
        stageCount = 10;
        debugMode = true;
      } break;
      case 0: {
        stageData[5][4] = 2;
        stageData[7][4] = 1;
        goalData[5][2] = true;
        stageCount = 1;
      } break;
      case 1: {
        stageData[7][6] = 1;
        stageData[5][6] = 2;
        stageData[3][4] = 2;
        goalData[3][2] = true;
        stageCount = 2;
      } break;
      case 2: {
        stageData[2][4] = 1;
        stageData[6][4] = 2;
        stageData[6][6] = 2;
        goalData[4][6] = true;
        stageCount = 3;
      } break;
      case 3: {
        stageData[6][6] = 1;
        stageData[4][5] = 2;
        stageData[4][6] = 2;
        goalData[3][5] = true;
        stageCount = 4;
      } break;
      case 4: {
        stageData[6][4] = 1;
        stageData[4][5] = 2;
        stageData[5][5] = 2;
        goalData[4][6] = true;
        stageCount = 4;
      } break;
      case 5: {
        stageData[6][8] = 1;
        stageData[4][6] = 1;
        stageData[6][6] = 2;
        goalData[8][6] = true;
        goalData[6][4] = true;
        stageCount = 2;
      } break;
      case 6: {
        stageData[2][4] = 1;
        stageData[7][5] = 1;
        stageData[6][5] = 2;
        stageData[4][4] = 2;
        goalData[4][2] = true;
        goalData[4][6] = true;
        stageCount = 2;
      } break;
      case 7: {
        stageData[3][7] = 1;
        stageData[4][7] = 1;
        stageData[3][5] = 2;
        stageData[3][6] = 2;
        stageData[4][6] = 2;
        goalData[4][4] = true;
        goalData[5][4] = true;
        stageCount = 3;
      } break;
      case 8: {
        stageData[1][4] = 1;
        stageData[3][2] = 1;
        stageData[5][2] = 2;
        stageData[4][5] = 2;
        stageData[5][5] = 2;
        goalData[3][6] = true;
        goalData[1][4] = true;
        stageCount = 4;
      } break;
      case 9: {
        stageData[4][8] = 1;
        stageData[2][6] = 1;
        stageData[2][4] = 2;
        stageData[3][4] = 2;
        stageData[3][3] = 2;
        goalData[6][6] = true;
        goalData[4][8] = true;
        stageCount = 4;
      } break;
      case 10: {
        stageData[5][7] = 1;
        stageData[2][4] = 1;
        stageData[4][5] = 2;
        stageData[3][5] = 2;
        stageData[3][4] = 2;
        stageData[3][6] = 2;
        goalData[7][5] = true;
        goalData[3][5] = true;
        stageCount = 4;
      } break;
      default: {
        finishFlg = true;
        return;
      }
    }

    stage = new Stage(stageData, goalData, stageCount, debugMode);
    sideMenu.stageName = "No."+(stageIndex);
    sideMenu.stageCount = stageCount;
  }
}

class Stage {  
  Tile[][] tileArray = new Tile[NUM][NUM];
  
  Timer timer;
  
  // fire variables
  int fireTimeCount = 0;
  final int fireTimeInterval = 30;
  boolean changingFlag = false;
  boolean fireFinishedFlag = false;
  
  Stage(int[][] stageData, int restTime) {
    timer = new Timer(STAGE_WIDTH/2f, STAGE_HEIGHT/2f, STAGE_WIDTH*0.75f, STAGE_HEIGHT*0.75f, restTime);
    
    for(int i=0; i<NUM; i++) {
      for(int j=0; j<NUM; j++) {
        tileArray[i][j] = new Tile(i, j, (i+0.5)*TILE_SIZE, (j+0.5)*TILE_SIZE, TILE_SIZE, TILE_SIZE);
      }
    }
    
    for(int i=0; i<NUM; i++) {
      for(int j=0; j<NUM; j++) {
        if (stageData[i][j] == 1) tileArray[i][j].isBomb = true;
        if (stageData[i][j] == 2) tileArray[i][j].isDman = true;
        if (stageData[i][j] == 3) tileArray[i][j].isGopher = true;
      }
    }
  }
  
  void step() {
    if (timer.done()) {
      fireStep();
    }
    for(int i=0; i<NUM; i++) {
      for(int j=0; j<NUM; j++) {
        tileArray[i][j].step();
      }
    }
    for(int i=0; i<NUM; i++) {
      for(int j=0; j<NUM; j++) {
        tileArray[i][j].isBurningVis = false;
      }
    }
    if (!timer.done()) {
      int indexX = int(mouseX/TILE_SIZE);
      int indexY = int(mouseY/TILE_SIZE);
      if (indexX>=0 && indexX<NUM && indexY>=0 && indexY<NUM) {
        Tile tile = tileArray[indexX][indexY];
        if (tile.isBomb) {
          for(int k=0; k<dx.length; k++) {
            int _i = indexX+dx[k];
            int _j = indexY+dy[k];
            if (_i>=0 && _i<NUM && _j>=0 && _j<NUM) {
              tileArray[_i][_j].isBurningVis = true;
            }
          }
        }
      }
      timer.step();
    }
  }
  
  void draw() {
    timer.draw();
    for(int i=0; i<NUM; i++) {
      for(int j=0; j<NUM; j++) {
        tileArray[i][j].draw();
      }
    }
  }
  
  void fireStep() {
    if (fireTimeCount == 0) {
      changingFlag = false;
      for(int i=0; i<NUM; i++) {
        for(int j=0; j<NUM; j++) {
          if (tileArray[i][j].isBombStart) {
            tileArray[i][j].isBurning = true;
            changingFlag = true;
          }
        }
      }
      fireFinishedFlag = !changingFlag;
    } else if (fireTimeCount % fireTimeInterval == 0) {
      changingFlag = false;
      for(int i=0; i<NUM; i++) {
        for(int j=0; j<NUM; j++) {
          Tile tile = tileArray[i][j];
          if (!tile.isBurning) {
            for(int k=0; k<dx.length; k++) {
              int _i = i+dx[k];
              int _j = j+dy[k];
              if (0<=_i && _i<NUM && 0<=_j && _j<NUM) {
                Tile _tile = tileArray[_i][_j];
                if (_tile.isBomb && _tile.isBombActive && _tile.isPreBurning) {
                  tile.isBurning = true;
                  changingFlag = true;
                  break;
                }
              }
            }
          }
        }
      }
      fireFinishedFlag = !changingFlag;
    } else {
      for(int i=0; i<NUM; i++) {
        for(int j=0; j<NUM; j++) {
          Tile tile = tileArray[i][j];
          if (tile.isBurning) tile.isPreBurning = true;
        }
      }
    }
    fireTimeCount++;
  }
  
  boolean isFinished() {
    return timer.done() && fireFinishedFlag;
  }
  
  boolean isGameOver() {
    for(int i=0; i<NUM; i++) {
      for(int j=0; j<NUM; j++) {
        Tile tile = tileArray[i][j];
        if (tile.isDman && tile.isBurning) return true;
        if (tile.isGopher && !tile.isBurning) return true;
      }
    }
    return false;
  }
  
  void selectLeft() {
    if (timer.done()) return;
    
    int indexX = int(mouseX/TILE_SIZE);
    int indexY = int(mouseY/TILE_SIZE);
    if (indexX<0 || indexX>=NUM) return;
    if (indexY<0 || indexY>=NUM) return;
    
    Tile tile = tileArray[indexX][indexY];
    if (tile.isBomb && tile.isBombActive) {
      tile.isBombStart = !tile.isBombStart;
    }
  }
  
  void selectRight() {
    if (timer.done()) return;
    
    int indexX = int(mouseX/TILE_SIZE);
    int indexY = int(mouseY/TILE_SIZE);
    if (indexX<0 || indexX>=NUM) return;
    if (indexY<0 || indexY>=NUM) return;
    
    Tile tile = tileArray[indexX][indexY];
    if (tile.isBomb) {
      tile.isBombActive = !tile.isBombActive;
      if (!tile.isBombActive) tile.isBombStart = false;
    }
  }
  
  void mouseClicked() {
    if (mouseButton == LEFT) {
      selectLeft();
    }
    if (mouseButton == RIGHT) {
      selectRight();
    }
  }
}
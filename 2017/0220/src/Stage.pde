class Stage {  
  Tile[][] tileArray = new Tile[NUM][NUM];
  Goal[][] goalArray = new Goal[NUM][NUM];
  int stageCount;
  
  boolean debugMode;
  
  Stage(int[][] stageData, boolean [][] goalData, int stageCount, boolean debugMode) {
    for(int i=0; i<NUM; i++) {
      for(int j=0; j<NUM; j++) {
        tileArray[i][j] = new Tile(i, j, (i+0.5)*TILE_SIZE, (j+0.5)*TILE_SIZE, TILE_SIZE, TILE_SIZE);
        goalArray[i][j] = new Goal((i+0.5)*TILE_SIZE, (j+0.5)*TILE_SIZE, TILE_SIZE, TILE_SIZE, goalData[i][j]);
        
        int po = stageData[i][j];
        if (po==1) tileArray[i][j].isTarget = true;
        if (po==2) tileArray[i][j].isRotator = true;
      }
    }
    this.stageCount = stageCount;
    this.debugMode = debugMode;
  }
  
  void step() {
    boolean nowRotating = checkRotating();
    if (!nowRotating) updateSelect();
    for(int i=0; i<NUM; i++) {
      for(int j=0; j<NUM; j++) {
        tileArray[i][j].step();
      }
    }
    for(int i=0; i<NUM; i++) {
      for(int j=0; j<NUM; j++) {
        goalArray[i][j].step();
      }
    }
  }
  
  void draw() {
    
    for(int i=0; i<NUM; i++) {
      for(int j=0; j<NUM; j++) {
        if (!tileArray[i][j].isRotating) tileArray[i][j].draw();
      }
    }
    for(int i=0; i<NUM; i++) {
      for(int j=0; j<NUM; j++) {
        if (tileArray[i][j].isRotating) tileArray[i][j].draw();
      }
    }
    for(int i=0; i<NUM; i++) {
      for(int j=0; j<NUM; j++) {
        goalArray[i][j].draw();
      }
    }
  }
  
  void updateSelect() { 
    int indexX = int(mouseX/TILE_SIZE);
    int indexY = int(mouseY/TILE_SIZE);    
    
    if (indexX<0 || indexX>=NUM) return;
    if (indexY<0 || indexY>=NUM) return;
    
    Tile rotator = tileArray[indexX][indexY];
    
    if (debugMode) {
      println(
        "  x: "+indexX+
        ", y: "+indexY+
        ", initX: "+rotator.initIndexX+
        ", initY: "+rotator.initIndexY
      );
    }
     
    boolean canRotation = rotator.isRotator;
    for(int i=0; i<NUM; i++) {
      for(int j=0; j<NUM; j++) {
        boolean selected = (
          (i==indexX && (abs(j-indexY)<3 || NUM-abs(j-indexY)<3)) ||
          (j==indexY && (abs(i-indexX)<3 || NUM-abs(i-indexX)<3))
        );
        if (stageCount <= 0) selected = false;
        tileArray[i][j].isSelected = selected;
      }
    }
  }
  
  void select() {
    boolean nowRotating = checkRotating();
    if (nowRotating) return;
    if (stageCount <= 0) return;
    
    int indexX = int(mouseX/TILE_SIZE);
    int indexY = int(mouseY/TILE_SIZE);
    if (indexX<0 || indexX>=NUM) return;
    if (indexY<0 || indexY>=NUM) return;
    Tile rotator = tileArray[indexX][indexY];
    boolean canRotation = rotator.isRotator;
    
    if (!canRotation && !debugMode) return;
    if (!canRotation && debugMode) {
      rotator.isRotator = true;
      canRotation = true;
    }
    
    for(int i=0; i<NUM; i++) {
      for(int j=0; j<NUM; j++) {
        boolean selected = (
          (i==indexX && (abs(j-indexY)<3 || NUM-abs(j-indexY)<3)) ||
          (j==indexY && (abs(i-indexX)<3 || NUM-abs(i-indexX)<3))
        );
        if (selected) {
          int flgX = i>indexX+NUM/2 ? 1 : i<indexX-NUM/2 ? -1 : 0;
          int flgY = j>indexY+NUM/2 ? 1 : j<indexY-NUM/2 ? -1 : 0;
          float rx = rotator.x + flgX*TILE_SIZE*NUM;
          float ry = rotator.y + flgY*TILE_SIZE*NUM;
          int _i = (indexX-(j-flgY*NUM-indexY) + NUM)%NUM;
          int _j = (indexY+(i-flgX*NUM-indexX) + NUM)%NUM;
          tileArray[i][j].initRotation(rx, ry, false, tileArray[_i][_j].isRotator, tileArray[_i][_j].isTarget, tileArray[_i][_j].initIndexX, tileArray[_i][_j].initIndexY);
        }
      }
    }
    stageCount--;
  }
  
  boolean checkRotating() {
    for(int i=0; i<NUM; i++) {
      for(int j=0; j<NUM; j++) {
        if (tileArray[i][j].isRotating) return true;
      }
    }
    return false;
  }
  
  boolean checkClear() {
    if (debugMode) return false;
    for(int i=0; i<NUM; i++) {
      for(int j=0; j<NUM; j++) {
        if (goalArray[i][j].isGoal && !tileArray[i][j].isTarget) return false;
      }
    }
    return true;
  }
  
  void mouseClicked() {
    select();
  }
}
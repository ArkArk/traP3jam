class StageGenerator {
  
  Stage get(int stageIndex) {
    
    // 0=>None, 1=>Bomb, 2=>Dman, 3=>Gopher
    int[][] stageData = new int[NUM][NUM];
    for(int i=0; i<NUM; i++) for(int j=0; j<NUM; j++) {
      stageData[i][j] = 0;
    }
    
    if (stageIndex<1) {
      po0(stageData, 1, 0, 1);
    } else if (stageIndex<2) {
      po0(stageData, 1, 1, 1);
    } else if (stageIndex<4) {
      po1(stageData, 2, 1, 1);
    } else if (stageIndex<10) {
      po1(stageData, (int)random(2, 4), (int)random(1, 3), (int)random(1, 2));
    } else if (stageIndex<15) {
      po1(stageData, (int)random(2, 5), (int)random(1, 3), (int)random(3, 5));
    } else {
      po1(stageData, (int)random(2, 5), (int)random(1, 4), (int)random(4, 8));
    }
    
    int restTime = (int)(60f * max(2.5f, 4f-stageIndex/20f));
    
    return new Stage(stageData, restTime);
  }
  
  // ------------------------------------------------------------
  
  void po0(int[][] data, int gopherN, int dmanN, int bombN) {
    for(int n=0; n<gopherN; n++) {
      while(true) {
        int i = (int)random(0, NUM);
        int j = (int)random(0, NUM);
        int k = (int)random(0, dx.length);
        int _i = i+dx[k];
        int _j = j+dy[k];
        if (_i<0 || _i>=NUM || _j<0 || _j>=NUM) continue;
        if (data[i][j] != 0) continue;
        if (data[_i][_j] != 0) continue;
        data[i][j] = 3;
        data[_i][_j] = 1;
        break;
      }
    }
    for(int n=0; n<dmanN; n++) {
      while(true) {
        int i = (int)random(0, NUM);
        int j = (int)random(0, NUM);
        if (data[i][j] != 0) continue;
        boolean flag = false;
        for(int k=0; k<dx.length; k++) {
          int _i = i+dx[k];
          int _j = j+dy[k];
          if (0<=_i && _i<NUM && 0<=_j && _j<NUM) {
            if (data[_i][_j] == 1) flag = true;
          }
        }
        if (flag) continue;
        data[i][j] = 2;
        break;
      }
    }
    for(int n=0; n<bombN; n++) {
      while(true) {
        int i = (int)random(0, NUM);
        int j = (int)random(0, NUM);
        if (data[i][j] != 0) continue;
        data[i][j] = 1;
        break;
      }
    }
  }
  
  // ------------------------------------------------------------
  
  void po1(int[][] data, int gopherN, int dmanN, int bombN) {
    for(int n=0; n<gopherN; n++) {
      while(true) {
        int i = (int)random(0, NUM);
        int j = (int)random(0, NUM);
        int k = (int)random(0, dx.length);
        int _i = i+dx[k];
        int _j = j+dy[k];
        if (_i<0 || _i>=NUM || _j<0 || _j>=NUM) continue;
        if (data[i][j] != 0) continue;
        if (data[_i][_j] != 0) continue;
        data[i][j] = 3;
        data[_i][_j] = 1;
        break;
      }
    }
    for(int n=0; n<dmanN; n++) {
      while(true) {
        int i = (int)random(0, NUM);
        int j = (int)random(0, NUM);
        if (data[i][j] != 0) continue;
        boolean flag = false;
        for(int k=0; k<dx.length; k++) {
          int _i = i+dx[k];
          int _j = j+dy[k];
          if (0<=_i && _i<NUM && 0<=_j && _j<NUM) {
            if (data[_i][_j] == 1) flag = true;
          }
        }
        if (flag) continue;
        flag = false;
        int k = (int)random(0, dx.length);
        int _i = i+dx[k];
        int _j = j+dy[k];
        if (_i<0 || _i>=NUM || _j<0 || _j>=NUM) continue;
        data[i][j] = 2;
        data[_i][_j] = 1;
        break;
      }
    }
    for(int n=0; n<bombN; n++) {
      while(true) {
        int i = (int)random(0, NUM);
        int j = (int)random(0, NUM);
        if (data[i][j] != 0) continue;
        data[i][j] = 1;
        break;
      }
    }
  }
  
  
  
}

class GameOver {

  float x = WINDOW_WIDTH/2f;
  float y = WINDOW_HEIGHT/2f;
  float w = WINDOW_WIDTH;
  float h = WINDOW_HEIGHT;


  void step() {
    if (keyPressed) {
      if (key=='t') {
        String text = "【Rotation Cross】Game Clear！！%0a" + "すごーい！きみはパズルが得意なフレンズなんだね！" + "%0a";
        link("https://twitter.com/intent/tweet?url=https://arkark.github.io/traP3jam/2017/0220/"+"&text="+text+"&hashtags=traP3jam", "_blank");
      }
    }
  }

  void draw() {
    // background
    noStroke();
    fill(0, 0, 0, 150);
    rect(x, y, w, h);

    // Game Clear
    {
      textAlign(LEFT);
      textSize(80);
      fill(255);
      String str = "Game Clear";
      float w = textWidth(str);
      text(str, (WINDOW_WIDTH-w)/2, height*0.5);
    }

    // tweet
    {
      textAlign(LEFT);
      textSize(30);
      fill(255);
      String str = "Press t: Tweet Result";
      float w = textWidth(str);
      text(str, (WINDOW_WIDTH-w)/2, height*0.7);
    }
  }

}

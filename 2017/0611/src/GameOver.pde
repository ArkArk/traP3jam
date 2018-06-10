
class GameOver {

  float x = WINDOW_WIDTH/2f;
  float y = WINDOW_HEIGHT/2f;
  float w = WINDOW_WIDTH;
  float h = WINDOW_HEIGHT;

  int count = 0;
  int score;

  void step() {
    if (keyPressed) {
      if (key=='t') {
        String text = "【Growth Ball ver1.00】%0aScore: " + score + "%0a";
        link("https://twitter.com/intent/tweet?url=https://arkark.github.io/traP3jam/2017/0611"+"&text="+text+"&hashtags=traP3jam", "_blank");
      }
    }
    count++;
  }

  void draw() {
    // background
    noStroke();
    fill(0, 0, 0, 150);
    rect(x, y, w, h);

    // Game Over
    {
      textAlign(LEFT);
      textSize(50);
      fill(255);
      String str = "Game Over";
      float w = textWidth(str);
      text(str, (WINDOW_WIDTH-w)/2, height*0.4);
    }

    // Score
    {
      textAlign(LEFT);
      textSize(40);
      fill(255);
      String str = "Score: " + score;
      float w = textWidth(str);
      text(str, (WINDOW_WIDTH-w)/2, height*0.6);
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

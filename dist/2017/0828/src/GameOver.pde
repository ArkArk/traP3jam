
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
        String text = "【Oscillating Circle ver1.00】%0aScore: " + nf(floor(score/10f), 1) + "." + nf(floor(score%10), 1) + "%25" + "%0a";
        link("https://twitter.com/intent/tweet?url=https://arkark.github.io/OscillatingCircle"+"&text="+text+"&hashtags=traP3jam", "_blank");
      }
    }
    count++;
  }

  void draw() {
    // background
    noStroke();
    fill(0, 0, 0, 150);
    rect(x, y, w, h);

    // Score
    {
      textAlign(RIGHT);
      textSize(50);
      fill(255);
      String str = nf(floor(score/10f), 1) + "." + nf(floor(score%10), 1) + "%";
      float w = textWidth("100.0%");
      text(str, (WINDOW_WIDTH-w)/2, height*0.3, w, 50);
    }

    // tweet
    {
      textAlign(LEFT);
      textSize(30);
      fill(255);
      String str = "Press t: Tweet Result";
      float w = textWidth(str);
      text(str, (WINDOW_WIDTH-w)/2, height*0.64);
    }

    // retry
    {
      textAlign(LEFT);
      textSize(30);
      fill(255);
      String str = "Press Enter: Retry";
      float w = textWidth(str);
      text(str, (WINDOW_WIDTH-w)/2, height*0.78);
    }
  }

}


class GameOver {

  float x = WINDOW_WIDTH/2f;
  float y = WINDOW_HEIGHT/2f;
  float w = WINDOW_WIDTH;
  float h = WINDOW_HEIGHT;

  int score;
  int playtime;

  void step() {
    if (keyPressed) {
      if (key=='t') {
        String text = "【Just Shot】%0aScore: "+score+", Playtime: "+playtime+"%0a";
        link("https://twitter.com/intent/tweet?url=https://arkark.github.io/JustShot/"+"&text="+text+"&hashtags=traP3jam", "_new");
      }
    }
  }

  void draw() {
    // background
    noStroke();
    fill(0, 0, 0, 150);
    rect(x, y, w, h);

    // score
    {
      textAlign(LEFT);
      textSize(40);
      fill(255);
      text("score: ", 100f, 100f);

      textAlign(LEFT);
      textSize(40);
      fill(255);

      String str = nf(score);
      float textW = textWidth(str);
      text(str, x-textW/2f, 150f);
    }

    // playtime

    {
      textAlign(LEFT);
      textSize(40);
      fill(255);
      text("playtime: ", 100f, 200f);

      textAlign(LEFT);
      textSize(40);
      fill(255);

      String str = nf(playtime);
      float textW = textWidth(str);
      text(str, x-textW/2f, 250f);
    }

    // tweet message
    {

      textAlign(LEFT);
      textSize(30);
      fill(255);

      String str1 = "Press t :";
      String str2 = "Tweet Result";
      float textW = textWidth(str2);
      text(str1, 100f, 400f);
      text(str2, x-textW/2f, 440f);

    }
  }

}

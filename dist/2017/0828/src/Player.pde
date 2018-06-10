class Player {

    float x;
    float y;

    float radius;

    boolean isActive = true;

    Player(float radius) {
        this.radius = radius;
    }

    void step() {
    }

    void draw() {
        if (isActive) {
            float _x = mouseX - WINDOW_WIDTH/2;
            float _y = mouseY - WINDOW_HEIGHT/2;
            float s = sqrt(_x*_x + _y*_y);
            if (t=0f) {

            } else {
                x = _x/s*radius;
                y = _y/s*radius;
            }
        }

        strokeWeight(5f);
        stroke(20, 100, 200, 150);
        fill(20, 80, 180, 80);
        ellipse(x, y, radius*2f, radius*2f);
    }
}

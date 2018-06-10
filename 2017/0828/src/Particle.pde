class Particle {

    float amplitude;

    float angle; // ∈[0, 1]
    float phase; // ∈[0, 1]

    float opacity; // ∈[0, 1]

    float x, y;

    Particle(float amplitude, float phase, float angle, float opacity) {
        this.amplitude = amplitude;
        this.phase = phase;
        this.angle = angle;
        this.opacity = opacity = 1f;
    }

    void step() {
    }

    void draw() {
        float _x = amplitude * sin(2*PI*phase);
        float _y = 0f;

        float s = sin(2*PI*angle);
        float c = cos(2*PI*angle);

        x = _x*c - _y*s;
        y = _x*s + _y*c;

        strokeWeight(3f);
        stroke(200, 120, 30, opacity*255f);
        fill(180, 100, 20, opacity*255f);
        ellipse(x, y, 10f, 10f);
    }

}

class Stage {

    Player player;

    int particleNum = 10;
    Particle[] particles;

    float amplitude = 150f;

    int maxTime  = 60 * 10;
    int restTime = 60 * 10;

    int poTime = 60*2;

    float angleDuration;
    float phaseDuration;

    Stage() {
        player = new Player(amplitude/2f);
        particles = new Particle[particleNum];
        float phaseR = random(0f, 1f);
        float angleR = random(0f, 1f);
        for(int i=0; i<particleNum; i++) {
            float phase = i/(float)particleNum /2f + phaseR;
            float angle = i/(float)particleNum /2f + angleR;
            particles[i] = new Particle(amplitude, phase, angle, 1f);
        }

        angleDuration = random(50f, 60f);
        phaseDuration = random(1.4f, 1.8f);
    }

    void step() {
        if (restTime > 0) {
            // particle move
            for(int i=0; i<particleNum; i++) {
                Particle p = particles[i];
                p.phase += 1f/60f / phaseDuration;
                p.angle += 1f/60f / angleDuration;
            }

            // particle opacity
            float r = restTime / (float)maxTime;
            float t;
            if (r > 0.9f) {
                t = 1f;
            } else if (r > 0.2) {
                t = (r-0.2)/0.7f;
            } else {
                t = 0f;
            }
            t *= particleNum;
            for(int i=0; i<particleNum; i++) {
                Particle p = particles[i];
                float opacity = max(0f, min(1f, t-1f*i));
                p.opacity = opacity;
                if (i == 0) {
                    p.opacity = max(t, r-0.5)
                }
            }
        } else {
            float r = (-restTime)/poTime;
            for(int i=0; i<particleNum; i++) {
                Particle p = particles[i];
                p.opacity = r*0.7f;
            }
            player.isActive = 0;
        }

        for(int i=0; i<particleNum; i++) {
            Particle p = particles[i];
            p.step();
        }

        player.step();

        restTime -= 1;

    }

    void draw() {
        pushMatrix();


        // particles
        translate(WINDOW_WIDTH/2, WINDOW_HEIGHT/2);
        for(int i=0; i<particleNum; i++) {
            particles[i].draw();
        }

        if (restTime <= 0) {
            float r = (-restTime)/poTime;
            strokeWeight(5f);
            stroke(200, 120, 30, 150f*r);
            fill(180, 100, 20, 80*r);
            ellipse(centerX(), centerY(), amplitude, amplitude);
        }

        player.draw();


        popMatrix();


        // restTime
        {
            int time = max(0, restTime);
            float t = 10f;
            float s = 30f;
            textAlign(RIGHT);
            textSize(s);
            fill(255);
            String st = nf(floor(time/60f), 1) + "." + nf(floor(time%60), 2);
            text(st, t, t, WINDOW_WIDTH-2*t, s);
        }


    }

    float centerX() {
        float x = 0f;
        for(int i=0; i<particleNum; i++) {
            x += particles[i].x;
        }
        return x / particleNum;
    }

    float centerY() {
        float y = 0f;
        for(int i=0; i<particleNum; i++) {
            y += particles[i].y;
        }
        return y / particleNum;
    }


    int score() {
        if (restTime>=0) return 0;

        float t1 = atan2(centerY(), centerX());
        float t2 = atan2(player.y, player.x);
        float d = min(abs(t2-t1), min(abs(t2-t1+2*PI), abs(t2-t1-2*PI)));
        d /= PI;
        return max(0, min(1000, ceil((1f - d)*1000f)));
    }

    boolean isFinished() {
        return restTime <= -poTime;
    }
}

class Dot {
  float diameter, ynoise, ty, max, mass;
  PVector location;
  PVector velocity;
  PVector acceleration;
  int rcolor, gcolor, bcolor;

  Dot(float size, float m, float x, float y) {

    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    max= 1;
    rcolor=245;
    gcolor=250;
    bcolor=245;
    diameter = size;
    mass=m;
  }
  void applyForce(PVector force) {
    PVector f =PVector.div(force, mass);
    acceleration.add(f);
  }

  void checkEdges() {
    if (location.x>width) {
      location.x = width;
      velocity.x*=-1;
    } else if (location.x<0) {
      velocity.x*=-1;
      location.x=0;
    }
    if (location.y > height) {
      velocity.y *=0;
      location.y = height;
      velocity.x *= 0;
    }
  }

  void update(float meep) {
    ty=meep;
    velocity.add(acceleration);
    velocity.limit(max);
    location.add(velocity);
    acceleration.mult(0);
  }


  void display() {
    noStroke();

    fill(255);
    ellipse(location.x, location.y, diameter, diameter);
  }

  void colorchange(int ccr, int ccg) {
    rcolor=ccr;
    gcolor=ccg;
    bcolor=240;
  }
}

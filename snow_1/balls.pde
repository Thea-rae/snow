class Dot {
  float diameter, ynoise, ty, max;
  PVector location;
  PVector velocity;
  PVector acceleration;
  int rcolor, gcolor, bcolor, speed;


  Dot(float size) {

    location = new PVector(random(0, width), 0);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0.1);
    max= 1;
    rcolor=245;
    gcolor=250;
    bcolor=245;
    speed=1;
    diameter = size;
  }
  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void checkEdges() {
  }

  void update(float meep) {
    ty=meep;
    velocity.add(acceleration);
    velocity.limit(max);
    location.add(velocity);
  }


  void display() {
    noStroke();
    fill(0, 80);
    rect(0, 0, width, height);
    fill(rcolor, gcolor, bcolor);
    ellipse(location.x, location.y, diameter, diameter);
  }

  void colorchange() {
    rcolor=rcolor+speed;
    gcolor=gcolor-speed;
    bcolor=bcolor+speed;
    if (rcolor >=251|| rcolor<244) {
      speed=-speed;
    }
  }
}

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
    max= 2;
    rcolor=1;
    gcolor=255;
    bcolor=255;
    speed=10;
    diameter = size;
  }
  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void checkEdges() {
    if (location.x>width) {
      location.x = width;
      velocity.x*=-1;
    } else if (location.x<0) {
      velocity.x*=-1;
      location.x=0;
    }
    if (location.y>=height) {
      velocity.mult(0);
      acceleration.mult(0);
      location.y = height-1;
    }
  }

  void update(float meep) {
    //acceleration=
    ty=meep;
    velocity.add(acceleration);
    velocity.limit(max);
    location.add(velocity);
  }


  void display() {

    noStroke();
    fill(rcolor, gcolor, bcolor);
    ellipse(location.x, location.y, diameter, diameter);
  }

  void colorchange() {

    rcolor=rcolor+speed;
    gcolor=gcolor-speed*2;
    bcolor=bcolor-speed;
    if (rcolor >=250|| rcolor<1) {
      speed=-speed;
    }
  }
}

class Flake {//aka snow aka tribbles aka balls that do things on a screen
  float diameter, ynoise, ty, max, mass, comfortZone;
  PVector location;
  PVector velocity;
  PVector acceleration;
  boolean freeze = false;

  Flake(float size, float m, float x, float y) {
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    max= 1;
    diameter = size;
    mass=m;
  }

  void applyForce(PVector force) {// fake physics
    PVector f =PVector.div(force, mass);
    acceleration.add(f);
  }

  void update() { //moar fake physics
    velocity.add(acceleration);
    velocity.limit(max);
    location.add(velocity);
    acceleration.mult(0);
  }

  void checkEdges() {//stop moving when you land on the ground, kthaxbye
    if (location.y >= height) {
      velocity.y *= 0;
      location.y = height;
      velocity.x *= 0;
      acceleration.mult(0);
      freeze = true;
    }
  }
  
  void accumulation(Flake other) {//this mess is/was my latest attempt at making them pile up
    PVector flakeVect = PVector.sub(other.location, this.location);
    for (int i = flakes.size()-1; i>=0; i--) {
      float dx = other.location.x - this.location.x;
      float dy = other.location.y - this.location.y;
      float distance = sqrt(dx*dx+dy*dy);
      float minDist = other.diameter+this.diameter;
      if ((distance < minDist)&&(other.freeze ==true)) {
        freeze=true;
      }
    }
  }

  void display() {//snowflakes, yup thats them in all their prettiness....
    noStroke();
    fill(255);
    ellipse(location.x, location.y, diameter, diameter);
  }
}

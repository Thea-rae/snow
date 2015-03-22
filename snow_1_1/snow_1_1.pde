import processing.core.PVector;
ArrayList<Dot> dots;
float dotsize;
float  mas, xloc, yloc;

void setup() {
  mas= 10.0;
  yloc = 0;
  size(displayWidth/2, displayHeight/3);
  dots = new ArrayList<Dot>();
  dots.add(new Dot(dotsize, mas, random(0, width), yloc));
  dotsize = random(.05, 3);
}

void draw() {
  fill(240, 230, 230);
  rect(0, 0, width, height);
  PVector gravity = new PVector(0, 0.1);
  for (int i = dots.size ()-1; i>=0; i--) {
    Dot dot = dots.get(i);
    dot.display();
    dot.update(random(-100, 100));
    dot.applyForce(gravity);
    dot.checkEdges();
  }
}

void mousePressed() {
  PVector wind = new PVector(random(-1, 1), 0);
  dotsize = random(1, 5);
  dots.add(new Dot(dotsize, mas, random(0, width), yloc));
  for (int i = dots.size ()-1; i>=0; i--) {
    Dot dot = dots.get(i);
    dot.applyForce(wind);
  }
}

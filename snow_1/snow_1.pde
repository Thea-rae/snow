import processing.core.PVector;
ArrayList<Dot> dots;
float dotsize;

void setup() {
  size(displayWidth, displayHeight/3);
 //background(245,241,231);
 background(0);
  dots = new ArrayList<Dot>();
  dots.add(new Dot(dotsize));
  dotsize = random(.05,3);
}

void draw() {
 
  for (int i = dots.size ()-1; i>=0; i--) {
    Dot dot = dots.get(i);
    dot.display();
    dot.update(random(-100,100));
    //dot.applyForce(gravity);
  }
}

void mousePressed() {
  dotsize = random(.05,3);
  dots.add(new Dot(dotsize));
  for (int i = dots.size ()-1; i>=0; i--) {
    Dot dot = dots.get(i);
    dot.colorchange();
  }
}

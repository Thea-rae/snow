import com.temboo.core.*;
import com.temboo.Library.Yahoo.Weather.*;
import processing.core.PVector;
TembooSession session = new TembooSession("thearae", "myFirstApp", "d4e3e4e73379491b88c8c0a2430b050c");
ArrayList<Flake> fallingFlakes;
ArrayList<Flake> fallenFlakes;

float flakeSize, temperatureColor, snowfallRate, smallestFlake, largestFlake, GRAVITY, meltRate, quanityofFlakes;
float  Mass, xloc, yloc, pressure;
int temperature, windChill, windDirection, windSpeed, feelslike, direction;
int visability, humidity, rising, conditionCode, sfRate, tembooTimer, meltTimer;
XML weatherResults;
boolean snowing = false;
boolean sticking = false;


String location = "detrit, mi";//I keep picking random cities that are snowing to check how the different varrations look

void setup() {
  size(displayWidth, displayHeight/3);
  background(255);
  meltTimer = minute();
  tembooTimer = minute();//for calling the weather every 15
  sfRate = millis();//mytimer for pacing out the snowfall rate
  Mass= 5;//just because I can
  yloc = 0;//always be born at the top. 
  loadWeather();//orginal call to yahoo weather through temboo
  loadSnow();//loads the arraylist/class
  fallenFlakes = new ArrayList<Flake>();
}

void draw() {
  tempcolor();//creates the warmth and coolness of the background.
  checkWeather();//checks the weather ever 2 minites
  if (snowing == true) {  //so it only calls the snow when it is actually snowing
    callSnow();
  }
  snowType(); // holds the switch case for the different types of snowfall charateristics 
  vis();//will white out the screen if visability drops.
}

void loadSnow() {//there will be snow!
  fallingFlakes = new ArrayList<Flake>();//calling the snow making class
  for (int i = 0; i < fallingFlakes.size (); i--) {
    fallingFlakes.add(new Flake(flakeSize, Mass, random(-150, (width)), yloc));
  }
}

void callSnow() { //It's totally snowing
  if (temperature<=32) {
    sticking = true;
  }
  if (millis()-sfRate>snowfallRate) {
    sfRate=millis();
    flakeSize = random(smallestFlake, largestFlake);
    fallingFlakes.add(new Flake(flakeSize, Mass, random(-150, (width)), yloc));
  }

  PVector wind = new PVector(windSpeed*direction, 0); //shows the windspeed/direction~ish
  PVector gravity = new PVector(0, 10);//allows me to change how quickly they fall
  for (int i = fallingFlakes.size ()-1; i>=0; i--) {//flakes are kinda like tribbles, huh...
    Flake flake = fallingFlakes.get(i);
    flake.display();
    flake.update();
    flake.applyForce(gravity);
    flake.applyForce(wind);

    for (Flake other : fallingFlakes) {
      flake.accumulation(other);
    }    
    flake.checkEdges();

    // println(flake.fallen());

    if (flake.fallen()) {
      Flake Temp = fallingFlakes.get(0);
      fallingFlakes.remove(0);

      fallenFlakes.add(Temp);
    }
  }


  for (Flake f : fallenFlakes) {
    f.display();
  }
}

void tempcolor() {
  int minTemp = 0;
  int maxTemp = 100;
  feelslike=windChill-temperature+temperature;
  temperatureColor = map(feelslike, minTemp, maxTemp, 0, 255);
  noStroke();
  fill(255);
  rect(0, 0, width, height);
  fill(0+temperatureColor, 200, 255-temperatureColor, 45);
  rect(0, 0, width, height);
}

void vis() {
  noStroke();
  fill(255, visability);
  rect(0, 0, width, height);
}

void snowType() {  
  switch(conditionCode) {//show me the SNOW
  case 5: //mixed rain and snow
    snowing = true;
    smallestFlake = 2;
    largestFlake = 6;
    snowfallRate=200;
    GRAVITY=int(random(10, 25));
    //make the flakes larger and raise gravity as a way of speeding the xaccleration no sticking
    break;
  case 7:          // mixed snow and sleet
    //large flakes higher gravity, but a thinner layer upon sticking 
    snowing = true;
    smallestFlake = 1;
    largestFlake = 6;
    snowfallRate=200;
    GRAVITY=int(random(10, 25));
    break;
  case 13:          // snow flurries
    //few large flakes at random intervals
    snowing = true;
    smallestFlake = 3;
    largestFlake = 6;
    snowfallRate=300;
    GRAVITY=int(random(10, 15));
    break;
  case 14:          // light snow showers
    //few large slakes consistant rate
    snowing = true;
    smallestFlake = 2;
    largestFlake = 6;
    snowfallRate=300;
    GRAVITY=int(random(10, 15));
    break;
  case 16:          // snow
    //abundant medium flakes at a steady rate 
    snowing = true;
    smallestFlake = 1;
    largestFlake = 4;
    snowfallRate=200;
    GRAVITY=int(random(10, 15));
    break;
  case 41:          // heavy snow
    //copious small flakes, constaint   
    snowing = true;
    smallestFlake = .5;
    largestFlake = 2.5;
    snowfallRate=50;
    GRAVITY=int(random(10, 15));
    break;
  case 42:          // scattered snow showers
    //abundant small flakes  at sporatic intervals
    snowing = true;
    smallestFlake = .5;
    largestFlake = 2.5;
    snowfallRate=150;
    GRAVITY=int(random(10, 15));
    break;
  case 43:          // heavy snow
    //copious small flakes, constaint 
    snowing = true;
    smallestFlake = .5;
    largestFlake = 2.5;
    snowfallRate=10;
    GRAVITY=int(random(10, 15));
    break;
  case 46:          // snow showers
    //aubundant small flakes, with short breaks in snow fall 
    snowing = true;
    smallestFlake = .5;
    largestFlake = 2.5;
    snowfallRate=50;
    GRAVITY=int(random(10, 15));
    break;
  }
}

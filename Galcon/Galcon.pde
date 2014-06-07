PImage bg, red, blue, gray;
int dx = 0;
int dy = 0;
int redx = 250;
int redy = 200;

void setup(){
  size (640,480);
  bg = loadImage("img/background.jpg");
  red = loadImage("img/red2.png");
  blue = loadImage("img/blue2.png");
  gray = loadImage("img/gray2.png");
}

void mouseClicked(){
  if (mouseX == redx || mouseY == redy){
    fill(0);
    ellipse(redx, redy, 50, 50);
  }
}

void draw() {
  background(bg);
  image(red, redx, redy);
  redx+=dx;
  redy += dy;
  image(blue, 500, 200);
  image(gray, 250, 200);
  planet p = new planet();
  text((int)p.numSpaceship, redx+50, redy+50);

}



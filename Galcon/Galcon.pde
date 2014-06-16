/*
My hypothesis?
We should put the spaceship array in the planet class
and then create the spaceships in the galcon class?
i think we should do this so that each spaceship is connected
to the planets like the rings are. 
the home planet is easily set. 

*/

PImage bg, cursor, logo, pause, play;
boolean clicked = false;
planet p0,p1,p2,p3,p4,p5,p6;
planet home, target;
planet[] plist = new planet[7];

spaceship sp;
spaceship sp1;
spaceship sp2;
spaceship[] splist = new spaceship[3];

boolean menu = true;
boolean pauseState = false;
int clicks = 0;
int savedTime1,savedTime2,savedTime3;
boolean allOn;


void setup(){
  noCursor();
  size (640,480);
  bg = loadImage("img/background.jpg");
  cursor = loadImage("img/cursor.png");
  logo = loadImage("img/logo.png");
  pause = loadImage("img/pause.png");
  play = loadImage("img/play.png");
  p0 = new planet(50, 50, 36, "blue");
  p1 = new planet(500, 400, 30, "red");
  p2 = new planet(120, 90, 24, "gray");
  p3 = new planet(200, 220, 24, "gray");
  p4 = new planet(350, 100, 36, "gray");
  p5 = new planet(420, 80, 30, "gray");
  p6 = new planet(300, 250, 24, "blue");

  sp = new spaceship(p1.xcor, p1.ycor, p1, p5, 5); //CHANGES
  sp1 = new spaceship(p6.xcor, p6.ycor, p0, p3, 5);
  sp2 = new spaceship(p0.xcor, p0.ycor, p0, p1, 5);
  splist[0] = sp;
  splist[1] = sp1;
  splist[2] = sp2;

  plist[0] = p0;
  plist[1] = p1;
  plist[2] = p2;
  plist[3] = p3;
  plist[4] = p4;
  plist[5] = p5;
  plist[6] = p6;
  
  savedTime1 = millis();
  savedTime2 = millis();
  savedTime3 = millis();
}

boolean inRadiusAny(){
  for (planet x: plist){
    if (x.getDistance(mouseX, mouseY) < x.radius)
      return true;
  }
  return false;
}

void allOff(){
  for (planet x: plist){
    x.ringOff();
    x.hoverRingOff();
    home = null;
    target = null;
  }
  clicks = 0;
  allOn = false;
}

void allOn(){
  for (planet x: plist){
    if (x.planetColor == "blue")
      x.ringOn();
  }
  clicks = 2;
  allOn = true;
}

void mousePressed(){
  if (menu && mouseX< 420 && mouseX > 220 && mouseY < 430 && mouseY > 350){
    menu = false;
  }
  if (mouseX< 30 && mouseX > 0 && mouseY < 30 && mouseY> 0){
    pauseState = !pauseState;
  }
  else{
    for (planet x: plist){
      if (x.mouseInRadius()){
        if (x.planetColor.equals("blue")){
          if (clicks == 0){
            x.ringOn();
            clicks++;
            home = x;
          }else if (clicks == 1 && x.Ring.on){
            allOn();
            //stroke(0, 180, 0);
            //line(home.xcor, home.ycor, target.xcor, target.ycor);
          }else if (clicks == 1 && !x.Ring.on){
            target = x;
            //send ships
            clicks++;
            allOff();
          }
        }else if (!(x.planetColor.equals("blue"))){
          if (clicks == 1){
            target = x;
            //send ships
            clicks++;
            allOff();
          }else if (clicks ==2 && allOn){
            println("hello");
            target = x;
            //send ships
            allOff();
          }
        }
      }
    }
    if (inRadiusAny() == false)
      allOff();
  }
}


void button(String text, int xcor, int ycor, int w, int h, int size){
  fill(210,255,255, 80);
  strokeWeight(4);
  rect(xcor, ycor, w, h, 7);
  textSize(size);
  if (mouseX< xcor+w && mouseX > xcor && mouseY < ycor+h && mouseY > ycor){
    fill(210,255,255);
    stroke(210,255,255);
  }
  else{
    fill(0);
    stroke(0);
  }
  text(text, (w-text.length()*size * .5)/2 + xcor , ((h+size)/2 + ycor));
}

void draw() {
  background(bg);
  if (menu){
    image(logo, 0, 0);
    button("Start", 220, 350, 200, 80, 30);
  }
  if (pauseState){
    image(play, 0, 0);
    textSize(50);
    fill(0);
    stroke(210,255,255);
    text("GAME PAUSED", 150, 250);
    if (keyPressed && key == ' ')
      pauseState = false;
  }
  else if (!menu && !pauseState){
    image(pause, 0, 0);
    for (planet x: plist){
      if (x.mouseInRadius()){
        if (clicks == 0){
          if (x.planetColor.equals("blue"))
            x.hoverRingOn();
            home = x;
        }
        if (clicks == 1){
          x.hoverRingOn();
          target = x;
          stroke(175,250,250);
          line(home.xcor, home.ycor, target.xcor, target.ycor);
        }        
        if (clicks == 2 && allOn){
          target = x;
          for (planet b: plist){
            if (b.planetColor.equals("blue")){
              stroke(175,250,250);
              line(b.xcor, b.ycor, target.xcor, target.ycor);
            }
          }
          x.hoverRingOn();
        }
      }if (!x.mouseInRadius()){
         x.hoverRingOff();
      }
    }

    
    int passedTime1 = millis() - savedTime1;  
    int passedTime2 = millis() - savedTime2;
    int passedTime3 = millis() - savedTime3;
    if (passedTime1 > 500){
      for (planet p: plist){
        if (p.radius == 36)
          p.grow();
      }
      savedTime1 = millis();
    }
    if (passedTime2 > 750){
      for (planet p: plist){
        if (p.radius == 30){
          p.grow();
        }
      }
      savedTime2 = millis();
    }
    if (passedTime3 > 1000){
      for (planet p: plist){
        if (p.radius == 24){
          p.grow();
        }
      }
      savedTime3 = millis();
    }
  
  
    for (planet x: plist){
      image(x.getPlanetImage(), x.xcor-x.radius, x.ycor-x.radius);
      x.displayRing();
      textSize(12);
      fill(0);
      text(""+x.num, x.xcor-10, x.ycor+5);
    }
      
    for (spaceship s: splist){
      s.setV();
      s.move();
    }
  
    if (keyPressed) {
      if (key == 'm') 
        menu = true;
      if (key == ' ') 
        pauseState = true;
    }
  }
  image(cursor, mouseX-16, mouseY-16);
}



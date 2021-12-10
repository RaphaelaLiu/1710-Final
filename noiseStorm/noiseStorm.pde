import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer player;

float x, y, x2, y2, rad, rad2, dist, dist2;
float deg, incr, yIn, rotateBy, ang;

void setup() {
  size(1280, 720);
  background(#02021A);
  incr = 1; 
  rad = -20;
  rad2 = -160;
  dist = 550;
  dist2 = 550;
  minim = new Minim(this);
  player = minim.loadFile("Florent Mothe - L'assasymphonie.mp3");
}

void draw() {
  player.play();
  noStroke();
  fill(#02021A, 10);
  rect(mouseX, 0, width, height);
  fill(255 * mouseX / width,255 * mouseY / height,0);
  rotateBy += player.mix.level()*0.03;
  pushMatrix();
  translate(width/2, height/2);
  rotate(rotateBy);
  deg = 0;
  while (deg <= 360){
  for (int i=0; i < player.bufferSize(); i++) {
    deg += incr;
    ang = radians(deg);
    x = cos(i) * (rad + ((dist)* noise(y/50, yIn)));
    y = sin(i) * (rad + ((dist+player.mix.level()*80) * noise(x/480, yIn)));
    ellipse(x*1, y*1, 1.5, 1.5);
    x2 = sin(i) * (rad2 + (dist2 * noise(y2/player.mix.level()*20, yIn)));
    y2 = cos(i) * (rad2 + (dist2 * noise(y2/player.mix.level()*20, yIn)));
    ellipse(x2*2, y2*2, 1, 1);
    box(player.mix.level()*150);
  }
  } 
  text(str(255 * mouseX / width) + " : " + str(255 * mouseY / height), width/2,height/2);
  yIn += .003;
  popMatrix();
}

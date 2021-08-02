//https://openprocessing.org/sketch/create
int spawnLimitX;
int spawnLimitY;


public class A {
  public float x;
  public float y;
  public float xv;
  public float yv;
  public color cl;
  public void A(float x, float y, float xv, float yv) {
    this.x = x;
    this.y = y;
    this.xv = xv;
    this.yv = yv;
  }
}

A[] ps = new A[10];
void setup() {
  size(800,800);
  spawnLimitX = width/4;
  spawnLimitY = height/4;
  background(240,240,240);
    colorMode(HSB, 255);
  for(int i = 0; i<ps.length; ++i) {
    ps[i] = new A();
    ps[i].x = random(0, spawnLimitX);
    ps[i].y = random(0, spawnLimitY);
    ps[i].xv = random(-0, 0);
    ps[i].yv = random(-0, 0);
    ps[i].cl = color(random(0,255), random(254, 255), 255);
  }
}

void draw() {
  background(0,0,240);
  textSize(32);
  for(A p : ps) {

  for(A p1 : ps) { //para "colisiones", no funciona muy bien
      float dX = (p.x - p1.x);
      float dY = (p.y - p1.y);
      float dT = dX + dY;
      float dist = sqrt(dX*dX + dY*dY);
      if(dist < 20) {
        p.xv += dX*0.01;
        p.yv += dY*0.01;
        p1.xv -= dX*0.01;
        p1.yv -= dY*0.01;
      }
  }
  p.xv += (mouseX - p.x)*0.005;
  p.yv += (mouseY - p.y)*0.005;
  float lerpX = p.x+p.xv;
  float lerpY = p.y+p.yv;
  //
  float dirX = Math.signum(lerpX-p.x);
  float dirY = Math.signum(lerpY-p.y);
  //
  float diffX = Math.abs(lerpX-p.x);
  float diffY = Math.abs(lerpY-p.y);
  if(diffX + diffY > 2) {
    float angle = atan(diffY/diffX);
    fill(0,0,0);
    //text(degrees(angle), 20, 50);
    float adyX = cos(angle+PI/2) * 10;
    //text("adyX:" + adyX, 20, 100);
    float opY = sin(angle+PI/2) * 10;
    //text("opY: " + opY, 20, 150);
    color cl1 = lerpColor(p.cl, color(hue(p.cl), 55, 255), 0.9);
    fill(cl1);
    triangle(lerpX+adyX*dirX, lerpY+opY*dirY,
    lerpX-adyX*dirX, lerpY-opY*dirY,
    p.x-(diffX*dirX*1.5), p.y-(diffY*dirY*1.5));
  }
  p.x += p.xv;
  p.y += p.yv;
  fill(p.cl);
  circle(p.x, p.y, 20);
  }
}

/*
h = diffY/diffX
*/
void keyPressed() {
  for(A p : ps) {
    p.x = random(0, spawnLimitX);
    p.y = random(0, spawnLimitY);
    p.xv = random(-5, 5);
    p.yv = random(-5, 5);
  }
}
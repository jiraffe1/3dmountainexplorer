//procedural terrain generator;

PVector orientation;
PVector velocity;
int columns;
int rows;
int scale = 20;
int w = 4000;
int h = 4000;
float flyingX = 0;
float flyingY = 0;
float flyingZ = 0;
int tris = 0;
int verts = 0;
float[][] terrain;
float steepness = 0.01;// 0.01,0.02,0.005,0.013, 100
boolean move = true;

void setup() {
  size(1200, 900, P3D);
  columns = w / scale;
  rows = h / scale;
  orientation = new PVector(PI/3,0,0);
  velocity = new PVector(0,0,0);
  terrain = new float[columns][rows];
}

void draw() {

  if(keyPressed) {
    if(key == 'w') {
      //flyingZ-=50;
      //
         orientation.x+=0.05;

//      orientation.x+=0.05;
    }
    else if(key == 'd') {
      //flyingZ+=50;
      orientation.z-=0.05;
    }
    else if(key == 'a') {
      orientation.z+=0.05;
    }
    else if(key == 's') {
      orientation.x -= 0.05;
    }
        if(key == 'i') {
      //flyingZ-=50;
      //
         flyingY+=0.05;

//      orientation.x+=0.05;
    }
    else if(key == 'l') {
      //flyingZ+=50;
      flyingX-=0.05;
    }
    else if(key == 'j') {
      flyingY+=0.05; 
    }
    else if(key =='k') {
      flyingY-=0.05;
    }
  }
  //flyingY-=0.02;
  float yoff = flyingY;
  for (int y = 0; y < rows; y++) {
    float xoff = flyingX;
    for (int x = 0; x < columns; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -1000, 1500);
      xoff += steepness;
    }

    yoff += steepness;
  }

  lights();
  background(60, 110, 255);
    text("verts: "+verts, 20, 20);
  text("tris: "+tris, 20, 50);
  text("frame rate: "+frameRate, 20, 80);
    tris = 0;
  verts = 0;
  stroke(0, 200, 130);
  fill(0, 200, 130);
  translate(width / 2, height / 2 + 10);
  rotateX(orientation.x);
  rotateY(orientation.y);
  rotateZ(orientation.z);

  translate(-w / 2, -h / 2);

  for (int y = 0; y < rows - 1; y++) {
    beginShape(TRIANGLE_STRIP);

    for (int x = 0; x < columns; x++) {
          tris++;
      float t = terrain[x][y];
      fill(t+30, t+160, t+15);
      strokeWeight(0);
      stroke(t+30, t+160, t+15);
      vertex((x * scale)+flyingX, (y * scale)+flyingY, terrain[x][y]+flyingZ);
      vertex((x * scale)+flyingX, ((y + 1) * scale)+flyingY, terrain[x][y+1]+flyingZ);
      verts+=3;
    }
    endShape();
  }
  translate(w/2, h/2, flyingZ-30);
  translate(flyingX,0,0);
  fill(0, 0, 255);
  box(w, h, -0.5);
  fill(0);
  textSize(12);
  stroke(0);
  

}

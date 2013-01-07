import processing.opengl.*;

Random _randomInstance;

void setup() {
  initializeColors();
   size(500, 600, P3D);
  _randomInstance = new Random();
}
void keyPressed() {
  if (keyCode == ENTER)
    saveFrame("still-####.jpg");
}
float direction = .02, dVal = 0;
void draw() {
  background(0);
  translate(width/2, height/1.2, -800);

  dVal += direction;
  if (dVal >= 1) direction = -.02;
  if (dVal < 0) direction = .02;
//  xAngle=0;
  float count = dVal;
  rotateX(radians(55));
  //rotateY(radians(50));
  rotateZ(radians(frameCount*2));

  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 600);
  stroke(255, 0, 0);
  //line(0, 0, 0, 0, 600, 0);
  stroke(0, 255, 0);
  //line(0, 0, 0, 600, 0, 0);


//  surface(0, count);
  surface(1, count);
  translate(0,0,200);
  rotateZ(radians(60));
  surface(1, count);
  translate(0,0,200);
  rotateZ(radians(60));
  surface(1, count);
  translate(0,0,200);
  surface(2, count);

}
float calcVertex(int formulaNumber, float irad, float theta, boolean drawVertex, float count) {
  float scalar = 200;
  float x1, y1, z1, x, y;
  x1 = irad*cos(theta);
  y1 = irad*sin(theta);
  switch (formulaNumber) {
  case 0:
    x = irad*cos(2*theta);
    y = irad*sin(2*theta);
    z1 = (4*x*x + y*y)/4;
    break;
  case 1:    // leaves of the plant
    {
//      float temprad = irad;
//         float temprad = abs(cos(theta)) + abs(sin(theta));
//      float temprad = irad*pow((abs(cos(theta)) + abs(sin(theta))), 6.5)/7;
      float temprad = pow(cos(2*theta),2)*irad*3;
      x1 = 1.0*temprad*cos(theta);
      y1 = 1.0*temprad*sin(theta);
      x = irad*cos(2*theta);
      y = irad*sin(2*theta);
      z1 = (6*x*x + y*y)/8;
   //   z1 = .2;
    } 
    break;
  case 2:
    {
//      float temprad = count * abs(cos(irad*PI/2))*sqrt(irad) +(1.0-count)*irad;
      float temprad = abs(cos(irad*PI/2))*sqrt(irad) +irad;
      //      temprad = irad;
      x1 = 1.0*temprad*cos(theta);
      y1 = 1.0*temprad*sin(theta);
      x = irad*cos(theta*3);
      y = irad*sin(theta*3);
//      z1 = (4*x*x + y*y)/8;
//      z1 = (abs(x)+abs(y));
      z1 = sqrt(2*x*x + y*y)/1.5;
    }    break;
  default:
    println("here");
    z1=0;
    break;
  }
  if (drawVertex)
    vertex(x1*scalar, y1*scalar, z1*scalar);
  return z1;
}
void surface(int formulaNumber, float count) {
  float maxz = -9999;
  maxz = insurface(formulaNumber, true, maxz, count);
  insurface(formulaNumber, false, maxz, count);
}
float insurface(int gradient, boolean noDraw, float maxz, float count) {
  noStroke();
  float maxx = PI, maxy = 1, xinc = maxx/40, yinc = maxy/20;
  for (float ix = -maxx; ix < maxx; ix+= xinc) {  // theta: -PI to PI
    for (float iy = yinc; iy < maxy; iy+=yinc) {  // radians: 0 to 1

      float theta=ix;
      float irad=iy;
      float z1 = calcVertex(gradient, irad, theta, false, count);      // just to get color
      if (z1 > maxz) maxz = z1;
      if (noDraw) {
      }
      else {
        fill(getColor(gradient, maxz, z1));
        beginShape();
        for (int i = 0; i < 4; i++) {  // calc 4 corners (or vertexes) of polygon (shape)
          switch (i) {
          case 0:
            theta = ix - xinc;
            irad = iy - yinc;
            break;
          case 1:
            theta = ix - xinc;
            irad = iy;
            break;
          case 2:
            theta = ix;
            irad = iy;
            break;
          case 3:
            theta = ix;
            irad = iy - yinc;
            break;
          }
          calcVertex(gradient, irad, theta, true, count);
        }
        endShape(CLOSE);
      }
    }
  }
  return maxz;
}


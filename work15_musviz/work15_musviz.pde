import processing.opengl.*;

void setup() {
  size(600, 600, P3D);
  initializeColors();
  newFlight(_iter, 2, 0);
  newFlight(_iter, 4, 200);
  newFlight(_iter, 12, 400);
  newFlight(_iter, 3, 400);
  _maxIterToSave = 36;

}
int _iter = 0;
void draw() {
//  if (frameCount%3 != 0) return;
  background(0);
  translate(width/2, height/2, -620);
  translate(500, 400, 00);
  rotateX(radians(60));
  rotateZ(radians(80));
  //drawGrid();
  noStroke();
  lights();
  fill(200, 0, 0);

  // random goodness
  //println(frameCount);
  
  /*
  for (int i = 0; i < 5; i++)
   newGlyph(_iter, 1, 1, 0,(int) (sin(_iter)*100), .5);
   
   translate(2,2,2);
   for (int i = 0; i < 5; i++)
   newGlyph(_iter, 2, 1, i*100,100,.5);
   */
  renderFlights(_iter);
  _iter++;
  if (_iter%_maxIterToSave == 0) {
    if (_firstTime)
        startGifAnimation();
    else {
      mousePressed();
      exit();
    }
     _firstTime = false;
  }
  onDraw();
}
boolean _firstTime = true;


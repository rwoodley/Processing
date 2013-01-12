List<Flight> _flights = new ArrayList<Flight>();
public void newFlight(int startIter, int period, int z) {
  //int numGlyphs = (int) random(0, 10);
  int numGlyphs = 4;
  List<Glyph> gs = new ArrayList<Glyph>();
  for (int i = 0; i < numGlyphs; i++) {
    Glyph g = 
      newGlyph(_iter, 
    (int) random(2)+1, // formula 
    (int) random(6), // color
    //      i * 100,            // Y
    (int) random(1000), // Y
    z + (int) random(100), // Z
    random(1), 
    (int) random(100)            // gradient
    );
    gs.add(g);
  }
  newFlight2(gs, startIter, period);
}
public void newFlight2(List<Glyph> glyphs, int startIter, int period) {
  Flight f = new Flight(glyphs, startIter, period);
  _flights.add(f);
}
public void renderFlights(int iter) {
  //println("yo! " + iter);
  for (Flight f : _flights)
    f.render(iter);
}

class Flight {
  List<Glyph> _glyphs;
  int _startIter;
  int _period;
  public Flight(List<Glyph> glyphs, int startIter, int period) {
    _glyphs = glyphs; 
    _startIter = startIter;
    _period = period;
  }
  public void render(int iter) {
    if ((iter - _startIter)%_period == 0) {
      println(iter + "," + _allGlyphs.size());
      for (Glyph g : _glyphs)
        newGlyph2(g, iter);
    }
    renderAllGlyphs(iter);
  }
}


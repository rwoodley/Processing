List<Glyph> _allGlyphs = new ArrayList<Glyph>();

Glyph newGlyph(int iter, int i, int col, int y, int z, float scalar, float gradient) {
  Glyph g = new Glyph(iter, y,z,getColor(col,100,gradient),i,scalar);
  _allGlyphs.add(g);
  return g;
}
void newGlyph2(Glyph g, int iter) {
  Glyph newg = new Glyph(g,iter);
  _allGlyphs.add(newg);
}
int _maxIterToSave = 20;
List<Glyph> _toremove = new ArrayList<Glyph>();
void renderAllGlyphs(int currentIter) {
  _toremove.clear();
  for (Glyph g : _allGlyphs) {
    if ((currentIter - _maxIterToSave) > g._iter)
      _toremove.add(g);
    else
      g.render(currentIter);
  }
  for (Glyph g : _toremove)
   _allGlyphs.remove(g); 
}
class Glyph {
  int _iter;
  int _Y;
  int _Z;
  color _col;
  int _formula;
  float _scalar;
  public Glyph(int iter, int y, int z, color col, int formula, float scalar) {
    _iter = iter;
    _Y = y; _Z = z; _col = col; _formula = formula; _scalar= scalar;
  }
  public Glyph(Glyph g, int iter) {
    _Y = g._Y; _Z = g._Z; _col = g._col;
    _formula = g._formula; _scalar = g._scalar;
    _iter = iter;
  }
  public void render(int currentIter) {
    int x = (currentIter - _iter) * -100;
    
    pushMatrix();
    fill(_col);
    translate(x,_Y, _Z);
    if (_formula == 1) {
      sphere(100 * _scalar);
    }
    else if (_formula == 2) {
      box(100 * _scalar);
    }
    popMatrix();
  }
}

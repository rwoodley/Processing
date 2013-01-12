import gifAnimation.*;
boolean GIF_EXPORT_ON = true;
GifMaker _gifExport = null;
void startGifAnimation()
{
  if (!GIF_EXPORT_ON) return;
  if (_gifExport != null) return;
  _gifExport = new GifMaker(this, "export.gif");
  _gifExport.setRepeat(0);  
  _gifExport.setQuality(200);
}
void onDraw()
{
  if (!GIF_EXPORT_ON) return;
  if (_gifExport == null) return;
  _gifExport.setDelay(1);
  _gifExport.addFrame();
}
void mousePressed() {
  if (!GIF_EXPORT_ON) return;
  _gifExport.finish();
  //  exit();
}


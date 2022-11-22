class Button
{
  int x;
  int y;
  color boxColor;
  int borderRadius;
  
  Button(int x, int y, color bx){
    this.x = x;
    this.y = y;
    boxColor = bx;
    borderRadius = 6;
  }
  
  boolean isClicked(int mouseX, int mouseY, int x, int y, int w, int h){
    if((mouseX >= x && mouseX <= x + w) && (mouseY >= y && mouseY <= y + h)){
      return true;
    } else {
      return false;
    }
  }
}
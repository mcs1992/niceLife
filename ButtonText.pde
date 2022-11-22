class ButtonText extends Button{
  color textColor;
  String value;
  
  ButtonText(int x, int y, color bx, color tx, String v){
    super(x, y, bx);
    textColor = tx;
    value = v;
  }
  
  boolean isClicked(int mx, int my){
    int w = (int)textWidth(value) + 10;
    int h = 15;
    return super.isClicked(mx, my, x - 5, y - 12, w, h);
  }
  
  void drawButton(){
    fill(boxColor);
    noStroke();
    rect(x-5,y-12, (int)textWidth(value)+10,15);
    fill(textColor);
    text(value,x,y);
  }  
}
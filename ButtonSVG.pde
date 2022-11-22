class ButtonSVG extends Button{
  int padding;
  int w;
  int h;
  PShape icon;
  color iconColor;
  
  ButtonSVG(int x, int y, int padding, color bx, color iconColor, PShape icon){
    super(x, y, bx);
    this.icon = icon;
    this.iconColor = iconColor;
    this.padding = padding;
    w = (int)icon.getWidth() + (padding * 2);
    h = (int)icon.getHeight() + (padding * 2); 
  }
  
  ButtonSVG(int x, int y, int w, int h, int padding, color bx, color iconColor, PShape icon){
    super(x, y, bx);
    this.w = w;
    this.h = h;
    this.icon = icon;
    this.iconColor = iconColor;
    this.padding = padding;    
  }  
  
  boolean isClicked(int mx, int my){
    return super.isClicked(mx, my, x, y, w, h);
  }
  
  void drawButton(){
    fill(boxColor);
    noStroke();
    ellipse(x + borderRadius, y + borderRadius, borderRadius * 2, borderRadius * 2);
    ellipse(x + w - borderRadius, y + borderRadius, borderRadius * 2, borderRadius * 2);
    ellipse(x + borderRadius, y + h - borderRadius, borderRadius * 2, borderRadius * 2);
    ellipse(x + w - borderRadius, y + h - borderRadius, borderRadius * 2, borderRadius * 2);
    rect(x + borderRadius, y, w - (borderRadius * 2), h);
    rect(x, y + borderRadius, w, h - (borderRadius * 2));
    icon.disableStyle();
    fill(iconColor);
    shape(icon, x + padding, y + padding, w - (padding * 2), h - (padding * 2));
  }
}
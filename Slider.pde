class Slider{
  //atributos
  int x;
  int y;
  color lineColor;
  color line;
  int min;
  int max;
  int value;
  boolean dragged;
  
  //constructor
  Slider(int x, int y, color line, color lc, int min, int max, int v){
    this.x = x;
    this.y = y;
    this.line = line;
    lineColor = lc;
    this.min = min;
    this.max = max;
    value = v;
    dragged = false;
  }
  
  void drawSlider(){
    if(value<0){
      value=0;
    }
    else if(value>max){
      value = max;
    }
    fill(255);
    rect(x,y-2,max,4);
    fill(lineColor);
    rect(x,y-1,value,2);
    drawBall(value);
  }
  
  void drawBall(int value){
    fill(lineColor);
    ellipse(x+value,y,10,10);
  }
  
  boolean isPressed(int mx, int my, int value){
    if((mx >= x+value-5 && mx <= x+value+5) && ( my >= y-5 && my <= y+5)){
      dragged = true;
       return true;
    }
    else{
      dragged = false;
      return false;
    }
  }
  
  boolean isLinePressed(int mx, int my){
    if((mx >= x && mx <= x+max) && (my >= y-5 && my <= y+5)){
      dragged = true;
       return true;
    }
    else{
      dragged = false;
      return false;
    }
  }
  
  void unPress(){
    dragged = false;
  }
  
  int newValue(int mx){
    int newVal = mx - x;
    value = newVal;
    if(value < 0){
      value = 0;
    } else if(value > max){
      value = max;
    }
    return newVal;
  }
}
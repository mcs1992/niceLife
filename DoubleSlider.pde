class DoubleSlider extends Slider{
  //atributos
  int minValue;
  boolean first;
  boolean last;
  
  //constructor
  DoubleSlider(int x, int y, color line, color lc, int min, int max, int minV, int maxV){
    super(x,y,line,lc,min,max,maxV);
    minValue = minV;
    first = false;
    last = false;
  }
  
  //metodos
  void drawDoubleSlider(){
    fill(255);
    rect(x, y - 2, max, 4);
    fill(lineColor);
    rect(x + minValue, y - 1, value - minValue, 2);
    drawMin(minValue);
    drawMax(value);
  }
  
  void drawMin(int val){
    drawTri(val, -10);
  }
  
  void drawMax(int val){
    drawTri(val, 10);
  }

  void drawTri(int val, int dir){
    fill(lineColor);
    triangle(x + val, y - 8, x + val + dir, y, x + val, y + 8);
  }
  
  void isTriPressed(int mx, int my){
    if((mx >= x + minValue - 8 && mx <= x + minValue) && ( my >= y - 20 && my <= y + 20)){
       first = true;
       dragged = true;
    }
    else if((mx >= x + value && mx <= x + value + 8) && ( my >= y - 20 && my <= y + 20)){
      last = true;
      dragged = true;
    }
  }
  
  void lineSide(int mx, int my){
    if((mx >= x + minValue - 8 && mx <= x + minValue) && ( my >= y - 20 && my <= y + 20)){
       first = true;
       dragged = true;
    }
    else if((mx >= x + value && mx <= x + value + 8) && ( my >= y - 20 && my <= y + 20)){
      last = true;
      dragged = true;
    }
  }
  
  void closestTri(int mx, int my) {
    if(mx >= x + min && mx <= x + max && my >= y - 5 && my <= y + 5){
      if(mx <= minValue + x){
        first = true;
      } else if(mx >= value + x){
        last = true;
      } else if(dist(mx, my, x + minValue, y) < dist(mx, my, x + value, y)){
        first = true;   
      } else {
        last = true;
      }
      dragged = true;
    }
  }
  
  void unPress(){
    first = false;
    last = false;
    dragged = false;
  }
  
  int newValue(int mx, int slider){
    int newVal = mx - x;
    switch(slider){
      
      case 1:
        //minvalue
      minValue = newVal;        
      if(minValue>value){
        minValue = value;
      }
      if(minValue<0){
        minValue = 0;
      }
      if(minValue > max){
        minValue = max;
      } 
      break;
      
      case 2:
      //maxvalue
      value = newVal;
      if(value<0){
        value = 0;
      }
      if(value>max){
        value = max;
      }
      if(value<minValue){
        value = minValue;
      }
      break;
    }
    return newVal;
  }
}
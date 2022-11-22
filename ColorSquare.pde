//variables globales
final int RED = 0;
final int GREEN = 1;
final int BLUE = 2;

class ColorSquare{
  //atributos
  int[] colorMin = new int[3];
  int[] colorMax = new int[3];
  int alpha;
  int x;
  int y;
  int sizeX;
  // el sizeY se refiere al tamaño de los segmentos, no al de todo el cuadro
  int sizeY;
  
  //constructor
  ColorSquare(int x, int y, int sizeX, int sizeY, int[] colorMin, int[] colorMax, int alpha){
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.colorMin = colorMin;
    this.colorMax = colorMax;
    this.alpha = alpha;
  }
  
  void drawColorSquare(){
    //dirección en la que transiciona el color, si es true, es que va de regreso, si es false, es que va de ida
    boolean direction;
    
    //este arreglo de bools sirve para saber qué colores están prendidos o apagados.
    //Todos empiezan apagados porque el cuadro de colores empieza en negro.
    boolean colors[] = {false, false, false};
    //Para saber cuál es el color del arreglo que está activo... es un índice
    int activeColor;
    for(int i = 0; i < 7; i++){
      
      //Hardcode espantosillo, sirve para definir qué color estárá activo, R, G o B.
      //El color activo es en el que se hace la transición, ya sea de ia o de regreso
      if(i == 0 || i == 2 || i == 5){
        activeColor = RED;
      } else if( i == 1 || i == 4 || i == 6){
        activeColor = GREEN;
      } else {
        activeColor = BLUE;
      }
      
      //decidir sobre la direccion
      direction = colors[activeColor];
      //Función auxiliar, esta dibujacada bloque, o sea, cada trancisión
      drawSegment(activeColor, i, direction, colors[RED], colors[GREEN], colors[BLUE]);
      //esto está mas bonito... hace que el color que acaba de estar activo se pase a su estado final en el arreglo
      colors[activeColor] = !(colors[activeColor]);
    }
    noFill();
    stroke(255);
    rect(x, y, sizeX, sizeY * 7);
  }
  
  void drawSegment(int index, int segment, boolean direction, boolean boolRed, boolean boolGreen, boolean boolBlue){
    float colorAdvance;
    for(int i = 1; i <= sizeY; i++){
      //Mapea en cada iteración la medida correcta del color activo, desde el mímimo hasta en máximo, pero basándose en
      //la escala del tamaño del segmento
      colorAdvance = map(i, 1, sizeY, colorMin[index], colorMax[index]);
      int red = colorMin[0];
      int green = colorMin[1];
      int blue = colorMin[2];
      
      //para saber cuáles colores están prendidos y cuales apagados, y así poder dibujar correctamente la transición
      if(boolRed == true){
        red = colorMax[0];
      }
      if(boolGreen == true){
        green = colorMax[1];
      }
      if(boolBlue == true){
        blue = colorMax[2];
      }
      
      switch(index){
        case 0:
          stroke(colorAdvance, green, blue, alpha);
        break;
        case 1:
          stroke(red, colorAdvance, blue, alpha);
        break;
        case 2:
          stroke(red, green, colorAdvance, alpha);
      }
      
      if(direction){
        //de regreso
        line(x, y + ((segment + 1) * sizeY) - i, x + sizeX, y + ((segment + 1) * sizeY) - i);
      }else{
        //de ida        
        line(x, y + i + (segment * sizeY) - 1, x + sizeX, y + i + (segment * sizeY) - 1);
      }
    } 
  }
  
  void refreshAlpha(int alpha){
    this.alpha = alpha;
  }
  
  //casi igual a la funcion que etsá en la clase del DoubleSlider
  void refreshColorSquare(DoubleSlider slider, int index, int side, int mx){
    int newVal = mx - slider.x;
    switch(side){      
      case 1:
        //minvalue
      colorMin[index] = newVal;        
      if(colorMin[index] > slider.value){
        colorMin[index] = slider.value;
      }
      if(colorMin[index] < 0){
        colorMin[index] = 0;
      }
      if(colorMin[index] > slider.max){
        colorMin[index] = slider.max;
      } 
      break;
      
      case 2:
      //maxvalue
      colorMax[index] = newVal;
      if(colorMax[index] < 0){
        colorMax[index] = 0;
      }
      if(colorMax[index] > slider.max){
        colorMax[index] = slider.max;
      }
      if(colorMax[index] < slider.minValue){
        colorMax[index] = slider.minValue;
      }
      break;
    }
  }  
}
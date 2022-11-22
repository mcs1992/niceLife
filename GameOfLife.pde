class GameOfLife{
  //atributos
  int[] colorMin = new int[3];
  int[] colorMax = new int[3];
  int alpha;
  int matrizX;
  int matrizY;
  int cellSize;
  boolean[][] actual;
  int[][] vecinos;
  
  //constructores
  GameOfLife(int tam){
    cellSize = tam;
    matrizX = width/tam;
    matrizY = height/tam;
    actual = new boolean[matrizX][matrizY];
    vecinos = new int[matrizX][matrizY];
    for(int i = 0; i < COLORS; i++){
      colorMin[i] = 255;
      colorMax[i] = 255;
    }
    alpha = 100;
  }
  
  GameOfLife(int tam, int[] min, int[] max, int alphaColor){
    cellSize = tam;
    matrizX = width/tam;
    matrizY = height/tam;
    actual = new boolean[matrizX][matrizY];
    vecinos = new int[matrizX][matrizY];
    colorMin = min;
    colorMax = max;
    alpha = alphaColor;
  }
  
  //métodos
  void randomiza(){
    for(int i=0; i<matrizX;i++){
      for(int j=0; j<matrizY;j++){
        float ran = random(0, 10);
        int wiwi = int(ran);
        if(wiwi<2){
          actual[i][j]=true;
        }
        else{
          actual[i][j]=false;
        }
      }
    }
  }
  
  void cuentaVecinos(){
    //incluye la celda actual
    for(int i=0; i<matrizX;i++){
      for(int j=0; j<matrizY;j++){      
        int vecinosVivos=0;
        
        //que tal que se esta en el borde o las esquinas...
        int minX = -1;
        int maxX = 1;
        int minY = -1;
        int maxY = 1;
        if(i==0) {
          minX=0;
        }
        if(j==0){
          minY=0;
        }
        if(i==matrizX-1){
          maxX=0;
        }
        if(j==matrizY-1){
          maxY=0;
        }
        
        for(int k=minX;k<=maxX;k++){
          for(int l=minY;l<=maxY;l++){
            if(actual[i+k][j+l]==true){
              vecinosVivos++;
            }
          }
        }    
        vecinos[i][j] = vecinosVivos;
      }
    }
  }
  
  void dibujaActual() {
    for(int i=0; i<matrizX;i++){
      for(int j=0; j<matrizY;j++){
        if(actual[i][j]==true){
          fill(0);
          rect(i*cellSize,j*cellSize,cellSize,cellSize);
        }
      }
    }
  }
  
  void dibujaCirculos() {
    for(int i=0; i<matrizX;i++){
      for(int j=0; j<matrizY;j++){
        if(actual[i][j]==true){
          noStroke();
          fill(random(colorMin[0],colorMax[0]),
               random(colorMin[1],colorMax[1]),
               random(colorMin[2],colorMax[2]),
               alpha);
          float radio = random(cellSize,cellSize * 1.5);
          ellipse(random(i * cellSize + (cellSize/4),
            (i + .75) * cellSize),
            random(j * cellSize + (cellSize/4),
            (j + .75) * cellSize),radio,radio);
        }
      }
    }
  }
    
    
  void reescribeMatriz(){
    for(int i=0; i<matrizX;i++){
      for(int j=0; j<matrizY;j++){  
        if(actual[i][j]==true){
          //como la matriz de vecinos incluye a la celda viva, aumento del 2 al 3
          if(vecinos[i][j]<3){
            actual[i][j]=false;
          }
          //como la matriz de vecinos incluye a la celda viva, aumento del 3 al 4
          if(vecinos[i][j]>4){
            actual[i][j]=false;
          }
        }
        else{
          if(vecinos[i][j]==3){
            actual[i][j]=true;
          }
        }
      }
    }
  }
  
  void run(){
    fill(0,10);
    rect(0,0,width,height);
    if(frameCount%3==0){
      //dibujaActual();
      dibujaCirculos();
      cuentaVecinos();
      reescribeMatriz();
    }
  }
  
  void reviveCell(int mx, int my){
    if(mx < width && mx >= 0 && my < height && my >= 0){
      actual[mx / cellSize][my / cellSize] = true;
      drawNewCells(mx / cellSize, my / cellSize);
    }    
  }
  
  void drawNewCells(int i, int j){
    noStroke();
    fill(random(colorMin[0],colorMax[0]),
      random(colorMin[1],colorMax[1]),
      random(colorMin[2],colorMax[2]),
      alpha);
    float radio = random(cellSize,cellSize * 1.5);
    ellipse(random(i * cellSize + (cellSize/4),
      (i + .75) * cellSize),
      random(j * cellSize + (cellSize/4),
      (j + .75) * cellSize),radio,radio);
  }
}
/*The game of life
pendientes
***hacer botones bonitos y ponerlos en los
lugares correctos
***poner un slider que controle la speed
***poner un slider que controle el tamaño de las celdas
***comentar codigo, huehuehue
***splashscreen
***ya que esté lista esta version de PC,
arreglarla para que funcione en android
***pasar la version de android a eclipse, para
meterle publicidad del mal
*/

//distintas pantallas de la app
int estado;
final int SPLASH = 0;
final int CONFIG = 1;
final int RUN = 2;
final int PAUSE = 3;

final int COLORS = 3;
int BUTTONSIZE;

//botones... no todos están disponibles siempre
ButtonSVG inicio;
ButtonSVG regreso;
ButtonSVG pausa;
ButtonSVG play;
ButtonSVG reinicia;

//svgs
PShape iconPlay;
PShape iconPause;
PShape iconConfig;
PShape iconRestart;

//arreglo de slider para rango de colores
DoubleSlider[] sliderColor = new DoubleSlider[COLORS];
Slider alphaColor;

//arreglos de ints para pasar los rangos de color
//a la clase game of life
int[] colorMin = new int[COLORS];
int[] colorMax = new int[COLORS];
int alpha;

ColorSquare colorPreview;

//es comodo defnir colores por ahi
color black = color(0);
color white = color(255);
color red = color(255,0,0);
color green = color(0,255,0);
color blue = color(0,0,255);
color grey = color(128);
color indigo = #3F51B5;
color[] colArray = {red,green,blue,grey};

//el juego como tal
GameOfLife game;

void setup() {
  //config de pantalla, aqui estamos empezando con
  //la pantalla de config, pero tan pronto haya
  //splashscreen, todo va a cambiar
  size (960,540);
  smooth();  
  background(0);
  estado = CONFIG;
  
  if(width > height) {
    BUTTONSIZE = width / 16;
  } else {
    BUTTONSIZE = height / 16;
  }
  
  //cargar svgs
  iconPlay = loadShape("play.svg");
  iconPause = loadShape("pause.svg");
  iconConfig = loadShape("cog.svg");
  iconRestart = loadShape("restart.svg");
  
  //construir los botones, posX, posY, texto, colorTexto, colorBoton
  inicio = new ButtonSVG((int)((width / 2) - BUTTONSIZE - 255 + (255 / 2 - BUTTONSIZE)),
                         (height / 2) - (BUTTONSIZE * 3),
                         BUTTONSIZE * 2, BUTTONSIZE * 2,
                         BUTTONSIZE / 5,
                         white, indigo, iconPlay);
  regreso = new ButtonSVG(BUTTONSIZE / 2, BUTTONSIZE / 2,
                          BUTTONSIZE, BUTTONSIZE,
                          BUTTONSIZE / 5,
                          white, indigo, iconConfig);
  pausa = new ButtonSVG((width / 2) - (BUTTONSIZE / 2), BUTTONSIZE / 2,
                        BUTTONSIZE, BUTTONSIZE,
                        BUTTONSIZE / 5,
                        white, indigo, iconPause);
  play = new ButtonSVG((width / 2) - (BUTTONSIZE / 2), BUTTONSIZE / 2,
                       BUTTONSIZE, BUTTONSIZE,
                       BUTTONSIZE / 5,
                       white, indigo, iconPlay);
  reinicia = new ButtonSVG(width - BUTTONSIZE - (BUTTONSIZE / 2), BUTTONSIZE / 2,
                           BUTTONSIZE, BUTTONSIZE,
                           BUTTONSIZE / 5,
                           white, indigo, iconRestart);
  
  //iniciar cada doubleslider del array
  for(int i = 0; i < COLORS; i++){
    //posX, posY, lineColor, minValue, maxValue,
    //valorInicialLimiteInferior, valorInicialLimiteSuperior
    sliderColor[i] = new DoubleSlider(width / 2 - BUTTONSIZE - 255, (height / 2) + (i * BUTTONSIZE),
                                      white, colArray[i], 0, 255, 0, 255);
  }
  alphaColor = new Slider(width / 2 - BUTTONSIZE - 255, (height / 2) + (3 * BUTTONSIZE), white, grey, 0, 255, 255);
  
  for(int i = 0; i < COLORS; i++){
    sliderColor[i].unPress();
    colorMin[i] = sliderColor[i].minValue;
    colorMax[i] = sliderColor[i].value;
  }
  alpha = alphaColor.value;
  
  //tamaño de celda, limites inferiores de color, limites superiores de color 
  game = new GameOfLife(5, colorMin, colorMax, alpha);
  
  colorPreview = new ColorSquare((width / 2) + BUTTONSIZE,
                                 (int)((height / 2) - (BUTTONSIZE * 3.5)),
                                 BUTTONSIZE * 2,BUTTONSIZE,
                                 colorMin, colorMax, alpha);
} 

void draw(){
  //switchear entre pantallas
  switch(estado){
    case SPLASH:
    break;
    case CONFIG:
      fill(black);
      noStroke();
      rect(0,0,width,height);
      inicio.drawButton();
      for(int i = 0; i < COLORS; i++){
        sliderColor[i].drawDoubleSlider();
      }
      alphaColor.drawSlider();
      colorPreview.drawColorSquare();
    break;
    case RUN:
      game.alpha = alpha;
      game.run();
      regreso.drawButton();
      pausa.drawButton();
      reinicia.drawButton();
    break;
    case PAUSE:
      play.drawButton();
      reinicia.drawButton();
      regreso.drawButton();
    break;
  }
}

void mouseReleased(){
  if(estado == CONFIG){
    //al soltar el mouse, el status de clic en los sliders
    //cambia a falso. También estoy asignando los valores
    //de los sliders al arreglo que determina los atributos
    //de color del juego de la vida
    for(int i = 0; i < COLORS; i++){
      sliderColor[i].unPress();
      colorMin[i] = sliderColor[i].minValue;
      colorMax[i] = sliderColor[i].value;
    }
   alphaColor.unPress();
   alpha = alphaColor.value;
  }  
}

void mouseDragged(){
  switch(estado){
    case CONFIG:
      if(alphaColor.dragged){
        alphaColor.newValue(mouseX);
        alpha = alphaColor.value;
        colorPreview.refreshAlpha(alphaColor.value);
      }
      //arrastra los limites del doubleslider
      for(int i = 0; i < COLORS; i++){
        if(sliderColor[i].dragged){
          if(sliderColor[i].last){
            sliderColor[i].newValue(mouseX,2);
            colorPreview.refreshColorSquare(sliderColor[i], i, 2, mouseX);
          }
          else if(sliderColor[i].first){
            sliderColor[i].newValue(mouseX,1);
            colorPreview.refreshColorSquare(sliderColor[i], i, 1, mouseX);
          }
        }
      }
    break;
    case RUN:
      game.reviveCell(mouseX,mouseY);
    break;
    case PAUSE:
      game.reviveCell(mouseX,mouseY);
  }
}

void mousePressed(){
  switch(estado){
    case CONFIG:
      if(alphaColor.isLinePressed(mouseX, mouseY)){
        alphaColor.newValue(mouseX);
      }
      //clicar en una parte del slider, y que el limite más cercano
      //se mueva a esa posición  
      for(int i = 0; i < COLORS; i++){
        sliderColor[i].lineSide(mouseX,mouseY);
        sliderColor[i].closestTri(mouseX,mouseY); 
        if(sliderColor[i].first){
          sliderColor[i].newValue(mouseX,1);
        } else if (sliderColor[i].last) {
          sliderColor[i].newValue(mouseX,2);
        }    
      }
    break;
    case RUN:
      game.reviveCell(mouseX,mouseY);
    break;
    case PAUSE:
      game.reviveCell(mouseX,mouseY);
    break;
  }
}

void mouseClicked() {
  //lo que se hace al picotear algun boton
  switch(estado){
    case SPLASH:
    break;
    case CONFIG:
      //shufflear el juego, añadir un fondo nuevo (porque
      //si no se ve muu feo) e iniciar el juego de la vida
      if(inicio.isClicked(mouseX,mouseY)){
        game.randomiza();
        background(0);
        estado = RUN;
      }
      if(alphaColor.isLinePressed(mouseX, mouseY)){
        alphaColor.newValue(mouseX);
        alpha = alphaColor.value;
        colorPreview.refreshAlpha(alpha);
        alphaColor.unPress();
      }
      //cambia los valores del doubleslider
      for(int i = 0; i < COLORS; i++){
        sliderColor[i].closestTri(mouseX,mouseY); 
          if(sliderColor[i].first){
          sliderColor[i].newValue(mouseX,1);
        } else if (sliderColor[i].last) {
          sliderColor[i].newValue(mouseX,2);
        } 
        sliderColor[i].unPress();
      }      
    break;
    case RUN:
      //por si se picotea la config o el reinicio, o la pausa
      irConfig();
      reiniciar();
      if(pausa.isClicked(mouseX,mouseY)){
        estado = PAUSE;
      }
    break;
    case PAUSE:
      //lo mismo que el caso de run, pero al reves
      irConfig();
      reiniciar();
      if(play.isClicked(mouseX,mouseY)){
        estado = RUN;
      }
    break;
  }
}
//metodo del cuadro de visualizacion de color
/*
void colorRect(int x, int y, int r, int g, int b){
  fill(r,g,b);
  rect(x,y,128,128);
  for(int i = r; i < 256; i++){
    stroke(i,g,b);
    line(x+128+i-r,y,x+128+i-r,y+128);
  }
}
*/

//método para reeiniciar el juego, lo reshufflea y lo corre
void reiniciar(){
  if(reinicia.isClicked(mouseX,mouseY)){
    game.randomiza();
    estado = RUN;
  }
}

//método que nos lleva a la config al picotear ese botón
void irConfig(){
  if(regreso.isClicked(mouseX,mouseY)){
     estado = CONFIG;
  }
}
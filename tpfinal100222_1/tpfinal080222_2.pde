Pantallas pantallas;
Juego juego;
void setup(){
  size(800,600);
  pantallas = new Pantallas();
  juego = new Juego();
}
void draw(){ 
  pantallas.mostrar();
  //juego.actualizar();
  //juego.dibujar();
}

void mousePressed(){
 juego.mouse();
}

void keyPressed(){
  pantallas.MuestraPantalla();
  juego.tecla();


}

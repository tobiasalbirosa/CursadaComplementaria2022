
class Juego {

  //-----------------------------------------------------
  ////PROPIEDADES

  String estado;
  PImage fondo;
  int tamText;
  Jugador jugador;
  Reina reina;
  Contador contador;
  String estoyJugando;
  // -----------------------------------------------------
  //CONSTRUCTOR
  Juego() {

    jugador = new Jugador();
    reina = new Reina();
    contador = new Contador();
    fondo = loadImage("fondo.png");
    tamText = 20;
    contador.tiempoContador= 30;
    estado = "menu";
  }

  // -----------------------------------------------------
  //METODOS
  void actualizar() {
    //-------ESTADO DE JUEGO---------
    //Menu
    if (estado.equals("menu")) {

      contador.tiempoContador = 30;
      //Juego
    } 

    if (estado.equals("jugar")) {
      //  println("contador " + contador.tiempoContador);
      contador.tiempoContador-=0.0193; //Si aca se puede reemplazar para calcular segundos reales, mejor      //Tiempo limite
      reina.actualizar();
      if (contador.tiempoContador < 0 ) {
        estado = "perder";
      } else if (reina.reinaVida<=0) {
        estado = "ganar";
      }
    }
  }

  void dibujar() {
    println("Estado en juego.dibujar ", estado);
    if (estado.equals("menu")) {

      pushStyle();

      image(fondo, 0, 0);
      textSize(tamText+20);

      textAlign(CENTER);      
      fill(0);
      text("Minijuego: derrota a la reina", width/2, height/8+10);

      textSize(tamText);
      textAlign(CENTER);  
      fill(0, 80);
      text("Esto te enseñará a no meterte conmigo", width/4, height/5);
      text("Muajajaja.", 700, height/5+370);

      textAlign(CENTER);
      fill(0, 250);
      text("Para ganarle a la reina deberás iluminarla lo suficiente\nantes de que ella te congele en 30 segundos, ten cuidado!", width/2, height-40);   

      fill(255, 250);
      textAlign(CENTER);
      text("Empezar", width/2, height/2);


      popStyle();
    } else if (estado.equals("jugar")) {
      pushStyle();
      println("estado es jugar: " + estado);
      background(255);
      image(fondo, 0, 0);
      reina.dibujar();
      //Dibujar el contador y vida de la reina
      contador.dibujar();
      //Dibuja  del jugador en mouseX y mouseY
      jugador.espejo(mouseX, mouseY);

      popStyle();
    } else if (estado.equals("ganar")) {
      pushStyle();

      image(fondo, 0, 0);  
      rectMode(CENTER);
      fill(#4bd8ff);
      rect(width/2, height/2, width, height);
      textAlign(CENTER);
      fill(255);
      text("¡Felicidades!\nLograste acabar con la reina.", width/2, height/3);
      text("Presiona la tecla ´R´ para reiniciar", width/2, height-40);

      popStyle();
    } else if (estado.equals("perder")) {

      pushStyle();

      image(fondo, 0, 0);  
      rectMode(CENTER);
      fill(255, 0, 0);
      rect(width/2, height/2, width, height);
      textAlign(CENTER);
      fill(255);
      text("¡Oh no!\nNo lo lograste, fuiste congelada por la reina", width/2, height/3);
      text("Presiona la tecla ´R´ para reiniciar", width/2, height-40);

      popStyle();
    }
  }

  //-Vida de la reina y el contador.
  void bmatar() {
    reina.matar();
    contador.barraVida-=10;
  }

  void mouse() {
    println("Press on Juego");
    println(estado);
    if (estado.equals("jugar")) {
      println("Press on Jugar");
      jugador.iluminar(mouseX, mouseY, reina.x, reina.y, reina.tx, reina.ty);
    } 

    if (estado.equals("menu")) { //Boton jugar   
      if (mouseX > width/2  - 50 && mouseX < width/2 + 50 &&
        mouseY > height/2  - 50 && mouseY < height/2 + 50  ) {
        rect(width/2  - 50, height/2 - 25, 100, 50);
        estado = "jugar";
      }
    }

  }

  void tecla() {
    //keyCode == 82 = Tecla 'R'
    if (((estado.equals("ganar") || estado.equals("perder")) && keyCode == 82)) {
      println("Tecla R");
      jugador = new Jugador();
      reina = new Reina();
      contador = new Contador();
      fondo = loadImage("fondo.png");
      estado = "menu";
      tamText = 20;
    }
  }
}

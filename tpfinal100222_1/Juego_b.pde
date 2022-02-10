
class Juego {

  //-----------------------------------------------------
  ////PROPIEDADES

  String estado;
  PImage fondo;
  int tamText;
  Jugador jugador;
  Reina reina;
  Contador contador;

  // -----------------------------------------------------
  //CONSTRUCTOR
  Juego() {
    jugador = new Jugador();
    reina = new Reina();
    contador = new Contador();
    fondo = loadImage("fondo.png");
    tamText = 20;
    contador.tiempoContador=30;
    estado = "menu";
    
  }

  // -----------------------------------------------------
  //METODOS
  void actualizar() {
    println("estado actualizar " + estado);
    reina.actualizar();
    //-------ESTADO DE JUEGO---------
    //Menu
    
    if (estado.equals("menu")) {
      contador.tiempoContador=30;
    //Juego
    } else if (estado.equals("jugar")) {   
      println("contador " + contador.tiempoContador);
      contador.tiempoContador-=0.0193; //Si aca se puede reemplazar para calcular segundos reales, mejor      //Tiempo limite
      if (contador.tiempoContador<0) {
        estado="perder";
      } else if (reina.reinaVida<=0) {
        estado="ganar";
      }
    }
  }
 
  void dibujar() { //
    println("Estamos en el void dibujar del juego " + estado);
    if (estado.equals("menu")) {
      image(fondo,0,0);
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
    }
     println("estado: por afuera de la condicion " + estado);
    if (estado.equals("jugar")) {
      println("estado: " + estado);
      background(255);
      //image(fondo, 0, 0);
      reina.dibujar();
      //Dibujar el contador y vida de la reina
      contador.dibujar();
      //Dibuja  del jugador en mouseX y mouseY
      jugador.espejo(mouseX, mouseY);
    }

    //Estado "ganaste"
    if (estado.equals("ganar")) {
      image(fondo, 0, 0);  
      rectMode(CENTER);
      fill(#4bd8ff);
      rect(width/2, height/2, width, height);
      textAlign(CENTER);
      fill(255);
      text("¡Felicidades!\nLograste acabar con la reina.", width/2, height/3);
      text("Presiona la tecla ´R´ para reiniciar", width/2, height-40);
    }

    //Estado "perdiste"
    if (estado.equals("perder")) {
      image(fondo, 0, 0);  
      rectMode(CENTER);
      fill(255, 0, 0);
      rect(width/2, height/2, width, height);
      textAlign(CENTER);
      fill(255);
      text("¡Oh no!\nNo lo lograste, fuiste congelada por la reina", width/2, height/3);
      text("Presiona la tecla ´R´ para reiniciar", width/2, height-40);
    }
  }

  //-Vida de la reina y el contador.
  void bmatar() {
    reina.matar();
    contador.barraVida-=10;
  }

  void mouse() {
    println(estado);
    if (estado.equals("jugar")) {
      jugador.iluminar(mouseX, mouseY, reina.x, reina.y, reina.tx, reina.ty);
      //juego = new Juego();
    } else if (estado.equals("menu")) { //Boton jugar   
      if (mouseX>width/2-50 && mouseX<width/2+50 && mouseY >height/2-5-20 && mouseY<height/2-5+20) {
        estado="jugar";
       }
     }
  }

   void tecla() {
     if ((estado.equals("ganar") || estado.equals("perder")) && keyCode == 'R') {
       estado = "menu";
       juego = new Juego();
      
     }
   }
}

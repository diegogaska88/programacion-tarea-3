import processing.video.*; // Importar la librería de video

Movie myVideo; // Para el video
float angle = 0; // Ángulo para animar las figuras

void setup() {
  size(800, 600);
  
  // Cargar el video desde la carpeta data
  myVideo = new Movie(this, "Bogota arde.Mp4");
  myVideo.loop(); // Reproducir en bucle
}

void draw() {
  // Mostrar el video de fondo
  background(0);
  
  if (myVideo.available()) {
    myVideo.read(); // Leer el siguiente frame del video
  }
  
  // Mostrar el video en el lienzo
  image(myVideo, 0, 0, width, height);
  
  // Dibujar la Flor de la Vida en el medio
  drawFlowerOfLife(width / 2, height / 2, 100 + sin(angle) * 20);
  
  // Aumentar el ángulo para animar
  angle += 0.05; // Cambia este valor para ajustar la velocidad de la animación
}

void drawFlowerOfLife(float x, float y, float size) {
  stroke(255); // Color de la línea
  noFill(); // Sin relleno
  int circles = 7; // Número de círculos en la Flor de la Vida
  
  for (int i = 0; i < circles; i++) {
    float radius = size / 2 + i * (size / circles); // Radio de los círculos
    ellipse(x, y, radius, radius);
    
    // Dibujar círculos alrededor de la flor
    for (int j = 0; j < 6; j++) {
      float angleOffset = TWO_PI / 6 * j; // Calcular el ángulo para los círculos alrededor
      float offsetX = cos(angleOffset) * radius / 2;
      float offsetY = sin(angleOffset) * radius / 2;
      ellipse(x + offsetX, y + offsetY, radius, radius);
    }
  }
}

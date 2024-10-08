import ddf.minim.*;

Minim minim;
AudioPlayer player;
color[] colors = {#e6302b, #36ad63, #FF860C, #13C9EE, #FF92DD, #DEF98A, #00009E};
PVector[] positions;
PVector[] velocities;
float[] sizes;
int numPoints = 2000;

void setup() {
  size(900, 900);
  minim = new Minim(this);
  
  // Cargar la canción
  player = minim.loadFile("I Love You.mp3");
  player.play(); // Reproducir la canción

  positions = new PVector[numPoints];
  velocities = new PVector[numPoints];
  sizes = new float[numPoints];
  
  // Inicializar posiciones, velocidades y tamaños de los puntos
  for (int i = 0; i < numPoints; i++) {
    positions[i] = new PVector(random(width), random(height));
    velocities[i] = new PVector(random(-1, 1), random(-1, 1));
    sizes[i] = random(5, 20);
  }
}

void draw() {
  background(16, 20, 20); // Color de fondo
  
  // Actualizar y dibujar cada punto
  for (int i = 0; i < numPoints; i++) {
    // Actualizar posición
    positions[i].add(velocities[i]);
    
    // Rebotar los puntos en los bordes del canvas
    if (positions[i].x < 0 || positions[i].x > width) velocities[i].x *= -1;
    if (positions[i].y < 0 || positions[i].y > height) velocities[i].y *= -1;
    
    // Dibujar punto
    fill(colors[int(random(colors.length))]);
    noStroke();
    ellipse(positions[i].x, positions[i].y, sizes[i], sizes[i]);
  }
}

void stop() {
  // Detener el reproductor al cerrar el sketch
  player.close();
  minim.stop();
  super.stop();
}

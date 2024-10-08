import ddf.minim.*; // Importa la biblioteca Minim

Minim minim;
AudioPlayer player;

float[] mass = new float[0];
float[] positionX = new float[0];
float[] positionY = new float[0];
float[] velocityX = new float[0];
float[] velocityY = new float[0];

void setup() {
  size(800, 600);
  minim = new Minim(this);
  player = minim.loadFile("JUSTICE.mp3"); // Carga el archivo de audio
  player.loop(); // Reproduce la música en bucle
  noStroke();
  fill(64, 255, 255, 192);
}

void draw() {
  background(32);

  for (int particleA = 0; particleA < mass.length; particleA++) {
    float accelerationX = 0, accelerationY = 0;

    for (int particleB = 0; particleB < mass.length; particleB++) {
      if (particleA != particleB) {
        float distanceX = positionX[particleB] - positionX[particleA];
        float distanceY = positionY[particleB] - positionY[particleA];

        float distance = sqrt(distanceX * distanceX + distanceY * distanceY);
        if (distance < 1) distance = 1;

        float force = (distance - 320) * mass[particleB] / distance;
        accelerationX += force * distanceX;
        accelerationY += force * distanceY;
      }
    }

    velocityX[particleA] = velocityX[particleA] * 0.99 + accelerationX * mass[particleA];
    velocityY[particleA] = velocityY[particleA] * 0.99 + accelerationY * mass[particleA];
  }

  for (int particle = 0; particle < mass.length; particle++) {
    positionX[particle] += velocityX[particle];
    positionY[particle] += velocityY[particle];

    ellipse(positionX[particle], positionY[particle], mass[particle] * 1000, mass[particle] * 1000);
  }
}

void addNewParticle() {
  mass = append(mass, random(0.003, 0.03));
  positionX = append(positionX, mouseX);
  positionY = append(positionY, mouseY);
  velocityX = append(velocityX, 0);
  velocityY = append(velocityY, 0);
}

void mouseClicked() {
  addNewParticle();
}

void mouseDragged() {
  addNewParticle();
}

void stop() {
  player.close(); // Cierra el reproductor al detener
  minim.stop(); // Detiene Minim
}

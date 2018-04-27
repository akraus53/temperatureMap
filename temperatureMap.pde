PShape sphere;
int angle = 90;

  int lat = 51;
  int lon = 0;
  
void setup() {
  size(500, 500, P3D);

  sphere = createShape(SPHERE, 300);
  sphere.setTexture(loadImage("Erde.jpg"));
  sphere.setStroke(false);
}

void draw() {
  background(51);
  
  translate(width/2, height/2, -300);

  rotateX(radians(-30));
  rotateY(radians(angle));
  
  pushMatrix();
  rotateZ(radians(lat+5));
  rotateY(radians(lon));
  translate(-300, 0);
  strokeWeight(12);
  stroke(200, 0, 100);
  point(0,0);
  popMatrix();

  shape(sphere);

  angle += 0.3;
}
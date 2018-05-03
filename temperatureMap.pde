
// Globe
PShape sphere;

// Viewing angles
float angleX = -30;
float angleY = 0;

float changeX = 0;
float changeY = 0;

// Radius of the earth
int rad = 600;

// Array of temperature points
tempPoint [] temps;


void setup() {
  fullScreen(P3D);
  //size(720, 360);

  // Define the globe
  sphere = createShape(SPHERE, rad);
  sphere.setTexture(loadImage("Earth.jpg"));
  sphere.setStroke(false);
  colorMode(HSB);
  
  // Load temperatures from JSON
  loadTemps("DarkSky3.json");
}

void draw() {
  background(51);

  // Rotate view of whole globe
  translate(width/2, height/2, -600);
  rotateX(radians(angleY));
  rotateY(radians(angleX));

  // Draw each tempPoint
  for (tempPoint t : temps) t.show();
  
  // Draw the globe
  shape(sphere);

  angleY += changeY;
  angleX += changeX;
}


void keyPressed(){
  if(keyCode == LEFT) changeX -= 0.5;  
  if(keyCode == RIGHT) changeX += 0.5;  
  if(keyCode == UP) changeY -= 0.5;  
  if(keyCode == DOWN) changeY += 0.5;  

}

// Load temperature data from specific JSON file
void loadTemps(String file) {
  JSONArray tmps = loadJSONArray(file);
  temps = new tempPoint[tmps.size()];

  for (int i = 0; i < tmps.size(); i++) {
    JSONObject obj = tmps.getJSONObject(i);
    
    float lat = obj.getFloat("lat");
    float lon = obj.getFloat("lon");
    float tmp = obj.getFloat("tmp");
    float prs = obj.getFloat("prs");

    temps[i] = new tempPoint(lon, lat, tmp, prs);
  }
}

// Load the bulk data downloaded from the web
void loadTemps() {
  JSONArray tmps = loadJSONArray("weather.json");
  temps = new tempPoint[tmps.size()];

  for (int i = 0; i < tmps.size(); i++) {
    JSONObject obj = tmps.getJSONObject(i);
    //print(".");
    float lat = obj.getJSONObject("city").getJSONObject("coord").getFloat("lat");
    float lon = obj.getJSONObject("city").getJSONObject("coord").getFloat("lon");
    float tmp = obj.getJSONObject("main").getFloat("temp") - 273.15;

    temps[i] = new tempPoint(lon, lat, tmp, 1000);
  }
}

// view, which points are at the opposite side of the earth (test)
void oppositeTest(){
  
  int index = frameCount % temps.length; 

  tempPoint first = temps[index];
  float firstX = map(first.lat, -90, 90, height, 0);
  float firstY = map(first.lon, -180, 180, 0, width);
  ellipse(firstY, firstX, 20, 20);

  tempPoint last = temps[temps.length-index];
  float lastX = map(last.lat, -90, 90, height, 0);
  float lastY = map(last.lon, -180, 180, 0, width);
  ellipse(lastY, lastX, 20,20);
  stroke(255,100,150);
  line(firstY, firstX, lastY, lastX);
  ellipse(width/2,height/2, 10,10);
}
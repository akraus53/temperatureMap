PShape sphere;
float angleX = 0;
float angleY = -30;

int rad = 600;
tempPoint london = new tempPoint(0, 51.5, 290);
tempPoint chicago = new tempPoint(-87.650047, 41.850029, 290);

tempPoint [] temps;

void setup() {
  size(500, 500, P3D);

  sphere = createShape(SPHERE, rad);
  sphere.setTexture(loadImage("Erde2.jpg"));
  sphere.setStroke(false);
  colorMode(HSB);
  loadTemps();
}

void draw() {
  background(51);
  
  translate(width/2, height/2, -300);

  rotateX(radians(angleX));
  rotateY(radians(angleY));
  

  shape(sphere);

  london.show();
  chicago.show();


  for(tempPoint t : temps){
    t.show();
  }

  angleX += 0;
  angleY += 2;
}

void loadTemps(){
  JSONArray tmps = loadJSONArray("weather.json");
  temps = new tempPoint[tmps.size()];
  
    for (int i = 0; i < tmps.size(); i++) {
      JSONObject obj = tmps.getJSONObject(i);
      //print(".");
      float lat = obj.getJSONObject("city").getJSONObject("coord").getFloat("lat");
      float lon = obj.getJSONObject("city").getJSONObject("coord").getFloat("lon");
      float tmp = obj.getJSONObject("main").getFloat("temp") - 273.15;
      
      temps[i] = new tempPoint(lon, lat, tmp);
    }
}
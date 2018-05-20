
// Globe
PShape sphere;

// Viewing angles
float angleX = -30;
float angleY = 0;

float speedX = 0;
float speedY = 0;

// Radius of the earth
int rad = 600;
boolean showEarth = true;
boolean showLines = false;
boolean showAll = false;

final int TEMPERATURE = 0;
final int PRESSURE = 1;
final int BOTH = 2;
int drawMode = TEMPERATURE;

float tolerance = 0.15;


// Array of temperature points
TempPoint [] temps;

ArrayList<ArrayList<TempPoint>> tempList;
int res = 2;

void setup() {
  fullScreen(P3D);
  //size(720, 360, P3D);

  // Define the globe
  sphere = createShape(SPHERE, rad);
  sphere.setTexture(loadImage("Earth.jpg"));
  
  sphere.setStroke(false);
  colorMode(HSB);

  // Define List of Lists for Antipod finding
  tempList  = new ArrayList<ArrayList<TempPoint>>();
  

  for (int i = 0; i <= 180*res; i++) {
    tempList.add(new ArrayList<TempPoint>());
  }

  // Load temperatures from JSON
  loadTemps("DarkSky4.json");

  findTemps();
}

void draw() {
  background(51);
  pushMatrix();
  // Rotate view of whole globe
  translate(width/2, height/2, -600);
  rotateX(radians(angleY));
  rotateY(radians(angleX));
  
  // Draw each TempPoint
  for (ArrayList<TempPoint> l : tempList) {
    for (TempPoint t : l) {
      t.show();
    }
  }
  // Draw the globe
  if (showEarth) shape(sphere);

  popMatrix();
  textSize(width/100);
  text("M - Map | T - Temperature | P - Pressure | B - Temperature & Pressure |" + 
    "L - Lines | Turn Globe with Mouse | A - Not Equal Points | J/K change Tolerance", 
    20, height -20);

  if (showLines) {
    stroke(255);
    strokeWeight(4);
    line(0, height/2, width, height/2); 
    line(width/2, 0, width/2, height);
  }

  angleX += speedX;
  angleY += speedY;
  speedX *= 0.9;
  speedY *= 0.9;
  angleX = angleX % 360;
  angleY = angleY % 360;

  if (angleX < 0) angleX = 360 - angleX;
  if (angleY < 0) angleY = 360 - angleY;
}


void keyPressed() {
  switch(keyCode) {
  case 77: //m
    showEarth = !showEarth; 
    break;
  case 76: // l
    showLines = !showLines;
    break;
  case 84: 
    drawMode = TEMPERATURE;
    break;
  case 80:
    drawMode = PRESSURE;
    break;
  case 66: 
    drawMode = BOTH;
    break;
  case 65: 
    showAll = !showAll;
    break;
  case 74: 
    if (tolerance > 0) tolerance -= 0.02; 
    findTemps();
    break;
  case 75: 
    tolerance += 0.02;
    findTemps();
  }
}

void mouseDragged() {
  float yrot = (mouseY - pmouseY);
  if (abs(yrot) < 50) {
    speedY = yrot * 0.16 * -1;
  }

  boolean onOtherSide = abs((angleY -90) %360) > 180 && abs((angleY -90) %360) < 360;
  int f = onOtherSide? 1 : -1;

  f *= (angleY -90) < 0? -1:1;

  float xrot = (mouseX - pmouseX);
  //  println(angleX, angleY);
  if (abs(xrot) < 50) {
    speedX = xrot * 0.16 * f;
  }
}


// Load temperature data from specific JSON file
void loadTemps(String file) {
  JSONArray tmps = loadJSONArray(file);
  temps = new TempPoint[tmps.size()];

  for (int i = 0; i < tmps.size(); i++) {
    JSONObject obj = tmps.getJSONObject(i);

    float lat = obj.getFloat("lat");
    float lon = obj.getFloat("lon");
    float tmp = obj.getFloat("tmp");
    float prs = obj.getFloat("prs");


    int latIndex = round((lat + 90) * res);
    TempPoint newPoint = new TempPoint(lon, lat, tmp, prs);
    temps[i] = newPoint;
    ArrayList<TempPoint> current = tempList.get(latIndex);
    current.add(newPoint);
  }
}

// Load the bulk data downloaded from the web
void loadTemps() {
  JSONArray tmps = loadJSONArray("weather.json");
  temps = new TempPoint[tmps.size()];

  for (int i = 0; i <= tmps.size(); i++) {
    JSONObject obj = tmps.getJSONObject(i);
    //print(".");
    float lat = obj.getJSONObject("city").getJSONObject("coord").getFloat("lat");
    float lon = obj.getJSONObject("city").getJSONObject("coord").getFloat("lon");
    float tmp = obj.getJSONObject("main").getFloat("temp") - 273.15;

    temps[i] = new TempPoint(lon, lat, tmp, 1000);
  }
}

// view, which points are at the opposite side of the earth (test)
void oppositeTest() {

  int index = frameCount % temps.length; 

  TempPoint first = temps[index];
  float firstX = map(first.lat, -90, 90, height, 0);
  float firstY = map(first.lon, -180, 180, 0, width);
  ellipse(firstY, firstX, 20, 20);

  TempPoint last = temps[temps.length-index];
  float lastX = map(last.lat, -90, 90, height, 0);
  float lastY = map(last.lon, -180, 180, 0, width);
  ellipse(lastY, lastX, 20, 20);
  stroke(255, 100, 150);
  line(firstY, firstX, lastY, lastX);
  ellipse(width/2, height/2, 10, 10);
}

void findTemps() {
  //println(temps.length);
  int numSame = 0;
  int numSimilar = 0;

  for (int  i = 0; i <= tempList.size()/2; i++) {
    for (int j = 0; j < tempList.get(i).size(); j ++) {  

      TempPoint first = tempList.get(i).get(j);

      int newLat = (90*res - i) + (90*res);

      int lonPlusHalf = ((tempList.get(i).size()/2) + j)%tempList.get(i).size();

      TempPoint last = tempList.get(newLat).get(lonPlusHalf);

      first.pointSize = 5;
      last.pointSize = 5;

      if (abs(first.temperature - last.temperature) < tolerance) {
        first.pointSize = 8;
        last.pointSize = 8;
        numSimilar++;

        if (abs(first.airpressure - last.airpressure) < 0.1) {
          first.pointSize = 15;
          last.pointSize = 15;
          numSame++;
        }
        //println(first.lon, "\t", last.lon, "\t", first.lon-last.lon, "\t", first.lat, "\t", last.lat, "\t", first.temperature, "\t", first.airpressure);
      }
    }
  }
  text(numSame + "/" + numSimilar + "@" + nf(tolerance, 1,2).replace(",","."), width-180, height-20);
}

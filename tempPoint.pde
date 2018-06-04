class TempPoint {
  final static int DEF = 0;
  final static int PRI = 1;
  final static int BTH = 2;

  float lat;
  float lon;

  float temperature;
  float airpressure;
  float colP_HSB;
  float colT_HSB;
  float colP_RGB;
  float colT_RGB;

  int state = DEF;

  TempPoint(float lon, float lat, float tmp, float prs) {
    this.temperature = tmp;
    this.lat = lat;
    this.lon = lon;
    this.airpressure = prs;

    // Map colors with HSB
    this.colT_HSB = map(tmp, -30, 40, 240, 0);
    this.colP_HSB = map(prs, 970, 1030, 240, 0);

    // Map colors with RGB
    this.colT_RGB = map(tmp, -30, 40, 0, 255);
    this.colP_RGB = map(prs, 970, 1030, 0, 255);
  }

  void show() {
    if (showAll || this.state != DEF) {
      pushMatrix();
      rotateY(radians(this.lon));
      rotateZ(radians(this.lat));
      translate(-rad, 0);
      int pointSize = 100;
      
      switch(state) {
      case DEF:
        pointSize = 4;
        noStroke();
        break;
      case PRI: 
        pointSize = 10;
        noStroke();
        break;
      case BTH:
        pointSize = 15;
        stroke(255);
        strokeWeight(4);
      }

      switch(drawMode) {
      case TEMPERATURE: 
        colorMode(HSB);
        fill(this.colT_HSB, 255, 255);
        break;
      case PRESSURE: 
        colorMode(HSB);
        fill(this.colP_HSB, 255, 255);
        break;
      case BOTH:
        colorMode(RGB);
        fill(this.colT_RGB, this.colP_RGB, 128);
      }
      rotateY(radians(90));
      ellipse(0, 0, pointSize, pointSize);
      popMatrix();
    }
  }
}

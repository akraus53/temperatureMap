class tempPoint{
  float lat;
  float lon;

  float temperature;
  float airpressure;
  float colP;
  float colT;


  tempPoint(float lon, float lat, float tmp, float prs) {
    this.temperature = tmp;
    this.lat = lat;
    this.lon = lon;
    this.airpressure = prs;

    // Map colors with HSB
    this.colT = map(tmp, -30, 40, 240, 0);
    this.colP = map(prs, 970, 1030, 240, 0);

    // Map colors with RGB
    //this.colT = map(tmp, -30, 40, 0, 255);
    //this.colP = map(prs, 970, 1030, 0, 255);
  }


  void show() {
    pushMatrix();
    rotateY(radians(this.lon));
    rotateZ(radians(this.lat));
    translate(-rad, 0);
    strokeWeight(14);
//  stroke(this.colT, this.colP,128);
    colorMode(HSB);
    stroke(this.colT, 255, 255);

    point(0, 0);
    popMatrix();
  }
}
class tempPoint{
  float lat;
  float lon;
  
  float temperature;
  float airpressure;
  
  
  tempPoint(float lon, float lat, float tmp){
    this.temperature = tmp;
    this.lat = lat;
    this.lon = lon;
  }
  
  
  void show(){
   
  pushMatrix();
  rotateY(radians(this.lon));
  rotateZ(radians(this.lat));
  translate(-rad, 0);
  strokeWeight(12);
  float col = map(this.temperature, -30, 60, 0, 360);
  stroke(col, 255, 200);
  point(0,0);
  popMatrix(); 
  }
  
}
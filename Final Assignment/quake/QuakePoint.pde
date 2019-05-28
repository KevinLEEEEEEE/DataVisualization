class QuakePoint {
  int sewer_and_water;
  int power;
  int roads_and_bridges;
  int medical;
  int buildings;
  int shake_intensity;
  
  String time;
  TimeStamp timeStamp;
  
  QuakePoint(String time, int sewer_and_water, int power, int roads_and_bridges, int medical, int buildings, int shake_intensity) {
    this.time = time;
    this.sewer_and_water = sewer_and_water;
    this.power = power;
    this.roads_and_bridges = roads_and_bridges;
    this.medical = medical;
    this.buildings = buildings;
    this.shake_intensity = shake_intensity;
    
    calcTimeStamp();
  }
  
  void calcTimeStamp() {
    String day = this.time.substring(8, 10);
    String hour = this.time.substring(11, 13);
    String minute = this.time.substring(14, 16);
    
    this.timeStamp = new TimeStamp(Integer.parseInt(day), Integer.parseInt(hour), Integer.parseInt(minute));
  }
}

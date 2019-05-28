class QuakeLocation {
  ArrayList<QuakePoint> quakePoints= new ArrayList<QuakePoint>();
  int location;
  
  QuakeLocation(int location) {
    this.location = location;
  }
  
  void add(QuakePoint point) {
    this.quakePoints.add(point);
  }
}

class QuakeEvent {
  float latitude; 
  float longitude;
  float depth;
  float mag;
  float energy;
  
  QuakeEvent(float latitude, float longitude, float depth, float mag) {
    this.latitude = latitude;
    this.longitude = longitude;
    this.depth = depth;
    this.mag = mag;

    this.energy = pow(10, 1.5 * this.mag);
  }
}

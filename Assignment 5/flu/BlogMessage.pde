class BlogMessage {
  Time time;
  Location location;
  
  BlogMessage(String date, String location) {
    this.calcDate(date);
    
    this.calcLocation(location);
  }
  
  void calcDate(String date) {
    int firstSlash = date.indexOf("/");
    int nextSlash = date.indexOf("/", firstSlash + 1);
    int space = date.indexOf(" ");
    int colon = date.indexOf(":");
    String month = date.substring(0, firstSlash);
    String day = date.substring(firstSlash + 1, nextSlash);
    String hour = date.substring(space, colon);
    
    if (hour.indexOf(" ") != -1) {
      hour = hour.substring(1, hour.length()); 
    }

    this.time = new Time(Integer.parseInt(month), Integer.parseInt(day), Integer.parseInt(hour));
  }
  
  void calcLocation(String location) {
    int space = location.indexOf(" ");
    String latitude = location.substring(0, space);
    String longitude = location.substring(space, location.length());
    
    this.location = new Location(Float.parseFloat(latitude), Float.parseFloat(longitude));
  }
  
  int getTimeIndex() {
    return this.time.getTimeIndex(); 
  }
  
  float getLatitude() {
    return this.location.getLatitude();
  }
 
  float getLongtitude() {
    return this.location.getLongtitude();
  }
  
  boolean withinRange(int dateIndex) {
     return this.getTimeIndex() <= dateIndex;
  }
}

class BlogMessage {
  int month;
  int day;
  int hour;
  int dateIndex;
  float latitude;
  float longitude;
  
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
    
    this.day = Integer.parseInt(day);
    this.month = Integer.parseInt(month);
    this.hour = Integer.parseInt(hour);
    this.dateIndex = (this.month * 30 + this.day) * 24 + this.hour;
  }
  
  void calcLocation(String location) {
    int space = location.indexOf(" ");
    String lantitude = location.substring(0, space);
    String longitude = location.substring(space, location.length());
    
    this.latitude = Float.parseFloat(lantitude);
    this.longitude = Float.parseFloat(longitude);
  }
  
  boolean withinRange(int dateIndex) {
     return this.dateIndex <= dateIndex;
  }
}

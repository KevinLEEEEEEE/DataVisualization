class Time {
  int month;
  int day;
  int hour;
  
  Time(int month, int day, int hour) {
    this.month = month;
    this.day = day;
    this.hour = hour;
  }
  
  int getMonth() {
   return this.month; 
  }
  
  int getDay() {
   return this.day; 
  }
  
  int getHour() {
     return this.hour; 
  }
  
  int getTimeIndex() {
    return (this.month * 30 + this.day) * 24 + this.hour;  
  }
}

class Clock {
  int month;
  int day;
  int hour;
  Time currTime;
  
  Clock(int startMonth, int startDay, int startHour) {
    this.currTime = new Time(startMonth, startDay, startHour);
  }

  void tick() {
    if (this.currTime.getHour() + 1 > 24) {
      if (this.currTime.getDay() + 1 > 24) {
        this.currTime = new Time(this.currTime.getMonth() + 1, 1, 0); // add month
      } else {
        this.currTime = new Time(this.currTime.getMonth(), this.currTime.getDay() + 1, 0); // add day
      }
    } else {
      this.currTime = new Time(this.currTime.getMonth(), this.currTime.getDay(), this.currTime.getHour() + 1); // add hour
    }
  }

  String getCurrentMonth() {
    return String.valueOf(this.currTime.getMonth());
  }

  String getCurrentDay() {
    return (this.currTime.getDay() < 10 ? "0" : "") + String.valueOf(this.currTime.getDay());
  }

  String getCurrentHour() {
    return (this.currTime.getHour() < 10 ? "0" : "") + String.valueOf(this.currTime.getHour()) + ":00";
  }
  
  int getDateIndex() { 
    return this.currTime.getTimeIndex();
  }
}

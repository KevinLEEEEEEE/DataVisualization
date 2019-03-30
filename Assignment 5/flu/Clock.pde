class Clock {
  int month;
  int day;
  int hour;
  
  Clock(int startMonth, int startDay, int startHour) {
    this.month = startMonth;
    this.day = startDay;
    this.hour = startHour;
  }

  void tick() {
    this.hour++;

    if (this.hour > 24) {
      this.hour = 0;

      this.day++;

      if (this.day > 30) {
        this.day = 1;

        this.month++;
      }
    }
  }

  String getCurrentMonth() {
    return String.valueOf(this.month);
  }

  String getCurrentDay() {
    return (this.day < 10 ? "0" : "") + String.valueOf(this.day);
  }

  String getCurrentHour() {
    return (this.hour < 10 ? "0" : "") + String.valueOf(this.hour) + ":00";
  }
  
  int getDateIndex() {
    return (this.month * 30 + this.day) * 24 + this.hour; 
  }
}

int MinutesPerHour = 60;
int HoursPerDay = 24;

class TimeStamp {
  int day;
  int hour;
  int minute;
  
  TimeStamp(int day, int hour, int minute) {
    this.day = day;
    this.hour = hour;
    this.minute = minute;
  }

  int getTimeStamp() {
    return this.minute + (this.hour + this.day * HoursPerDay) * MinutesPerHour;
  }
}

Table MicroBlogs;
PImage Map;
ArrayList<BlogMessage> fluMessages = new ArrayList<BlogMessage>();

void setup() {
  size(1800, 996); 
  
  colorMode(HSB, 360, 100, 100);
  
  frameRate(6);
  
  strokeWeight(5);
 
  textSize(45);
  
  loadDatas();
  
  searchBlogs();
}

void loadDatas() {
  MicroBlogs = loadTable("Microblogs.csv", "header");
  
  Map = loadImage("Vastopolis_Map.png");
}

void searchBlogs() {
    for (TableRow row : MicroBlogs.rows()) {
      String date = row.getString("Created_at");
      String location = row.getString("Location");
      String text = row.getString("text").toLowerCase();
  
      if (text.indexOf("flu") != -1) {
         fluMessages.add(new BlogMessage(date, location));
      }
  }
}

void drawDatas(int dateIndex) {
    for (BlogMessage message : fluMessages) {
      if (message.withinRange(dateIndex)) {
        float x = map(message.latitude, 42.3017, 42.1609, 0, width);
        float y = map(message.longitude, 93.5673, 93.1923, 0, height);
        float hue = map(message.dateIndex, 3600, 7125, 120, 0);
        
        stroke(hue, 80, 100);
        
        point(x, y);
      }
  }
}

void updateDateText(int dateIndex) {
    int month = dateIndex / 720;
    int day = dateIndex / 24 % 30;
    int hour = dateIndex - (month * 30 + day) * 24;
    
    if (day == 0) {
      month--;
      
      day = 30;
    }

    pushMatrix();    
    
    pushMatrix();
      
    fill(0, 0, 0, 120);
    
    noStroke();
    
    rect(10, 20, 300, 70, 15);
    
    popMatrix();
    
    fill(0, 0, 100);
   
    text(String.valueOf(month) + "/" + (day < 10 ? "0" : "") +  String.valueOf(day) + "  " + (hour < 10 ? "0" : "")  + String.valueOf(hour)+ ":00", 30, 70);
    
    popMatrix();
}

void updateSunLight(int dateIndex) {
    int month = dateIndex / 720;
    int day = dateIndex / 24 % 30;
    int hour = dateIndex - (month * 30 + day) * 24;
    float sunlight = map(abs(hour - 12), 0, 11, 10, 120);

    pushMatrix();
    
    fill(0, 0, 0, sunlight);
    
    rect(0, 0, width, height);
    
    popMatrix();
}

int dateIndex = 3600;

void draw() {
  if (dateIndex <= 7125) {
    image(Map, 0, 0, width, height);
    
    updateSunLight(dateIndex);
  
    drawDatas(dateIndex);
  
    updateDateText(dateIndex);
  
    dateIndex++;    
  }
}

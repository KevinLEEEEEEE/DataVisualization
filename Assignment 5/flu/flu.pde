Table MicroBlogs;
PImage Map;
Clock clock = new Clock(4, 30, 0);
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

void drawDatas() {
    for (BlogMessage message : fluMessages) {
      if (message.withinRange(clock.getDateIndex())) {
        float x = map(message.getLatitude(), 42.3017, 42.1609, 0, width);
        float y = map(message.getLongtitude(), 93.5673, 93.1923, 0, height);
        float hue = map(message.getTimeIndex(), 3600, 4080, 120, 0);
        
        stroke(hue, 80, 100);
        
        point(x, y);
      }
  }
}

void updateDateText() {
    pushMatrix();    
    
    pushMatrix();
      
    fill(0, 0, 0, 120);
    
    noStroke();
    
    rect(10, 20, 300, 70, 15);
    
    popMatrix();
    
    fill(0, 0, 100);
   
    text(clock.getCurrentMonth() + "/" + clock.getCurrentDay() + "  " + clock.getCurrentHour(), 30, 70);
    
    popMatrix();
}

void updateSunLight() {
    float sunlight = map(abs(clock.hour - 12), 0, 11, 10, 120);

    pushMatrix();
    
    fill(0, 0, 0, sunlight);
    
    rect(0, 0, width, height);
    
    popMatrix();
}

void draw() {
  if (clock.getDateIndex() <= 4080) {
    image(Map, 0, 0, width, height);
    
    updateSunLight();
  
    drawDatas();
  
    updateDateText(); 
    
    clock.tick();
  }
}

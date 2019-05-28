ArrayList<QuakeLocation> quakeLocations = new ArrayList<QuakeLocation>();
int StartTimeStamp = 8640;

void setup() {
  size(2500, 600);
  
  background(255);
  
  blendMode(DARKEST);
  
  colorMode(HSB, 360, 100, 100);
  
  for(int i = 1; i < 20; i++) {
   quakeLocations.add(new QuakeLocation(i)); 
  }
  
  loadDatas();
  
  QuakeLocation loc1 = quakeLocations.get(0);
  
  for(QuakePoint point : loc1.quakePoints) {
    drawQuakePoint(point);
  }
}

void loadDatas() {
  Table quakeTable = loadTable("mc1-reports-data.csv", "header");

  generateQuakeData(quakeTable, quakeLocations);
}

void generateQuakeData(Table table, ArrayList<QuakeLocation> list) {
  for (TableRow row : table.rows()) {

    String time = row.getString("time");
    int sewer_and_water = row.getInt("sewer_and_water");
    int power = row.getInt("power");
    int roads_and_bridges = row.getInt("roads_and_bridges");
    int medical = row.getInt("medical");
    int buildings = row.getInt("buildings");
    int shake_intensity = row.getInt("shake_intensity");
    int location = row.getInt("location");
    
    list.get(location - 1).add(new QuakePoint(time, sewer_and_water, power, roads_and_bridges, medical, buildings, shake_intensity));
  }
}

void drawQuakePoint(QuakePoint point) {
  int currTime = point.timeStamp.getTimeStamp() - StartTimeStamp;
  float xPos = map(currTime, 0, 7400, 0, 2500);
  
  drawPoint(xPos + 20, 50, 0, point.sewer_and_water);
  
  drawPoint(xPos + 20, 150, 45, point.power);
  
  drawPoint(xPos + 20, 250, 90, point.roads_and_bridges);
  
  drawPoint(xPos + 20, 350, 135, point.medical);
  
  drawPoint(xPos + 20, 450, 180, point.buildings);
  
  drawPoint(xPos + 20, 550, 225, point.shake_intensity);
}

void drawPoint(float x, float y, int hue, float level) {
  pushMatrix();
  
  stroke(hue, level * 9 + 10, level * 9 + 10);
  
  strokeWeight(level * level / 5);
  
  point(x, y);
  
  popMatrix();
}

PShape globey;
PImage globeyTexture;
float maxEnergy = 0.0;
ArrayList<QuakeEvent> quakeList = new ArrayList<QuakeEvent>();

void setup() {
  size(1800, 1200, P3D); 
  
  colorMode(HSB, 360, 100, 100);

  strokeWeight(2);
  
  loadDatas();

  loadShapes();

  calcMaxValue(quakeList);
}

void loadShapes() {
  globeyTexture = loadImage("earthTexture.jpg");
  globey = createShape(SPHERE, 100);

  globey.setTexture(globeyTexture);
  globey.setStroke(false);
}

void loadDatas() {
  Table data2000 = loadTable("all_2000s_M6plus.csv", "header");
  Table data2010 = loadTable("all_2010s_M6plus.csv", "header");
  
  generateQuakeData(data2000, quakeList);
  generateQuakeData(data2010, quakeList);
}

void generateQuakeData(Table table, ArrayList list) {
  for (TableRow row : table.rows()) {
    
    float latitude = row.getFloat("latitude");
    float longitude = row.getFloat("longitude");
    float depth = row.getFloat("depth");
    float mag = row.getFloat("mag");
    
    list.add(new QuakeEvent(latitude, longitude, depth, mag));
  }
}

void calcMaxValue(ArrayList<QuakeEvent> list) {
  float tmpEnergy = 0.0;

  for(QuakeEvent event : list) {
    if (tmpEnergy < event.energy) tmpEnergy = event.energy;
  }

  maxEnergy = tmpEnergy;
}

float energyLimit(float energy) {
  return energy;
}

void drawQuakeLines(ArrayList<QuakeEvent> list) {
  for(QuakeEvent event : list) {
    pushMatrix();

    rotateX(radians(event.latitude) + PI);

    rotateY(radians(event.longitude));

    float h = map(energyLimit(event.energy), 0, energyLimit(maxEnergy), 180, 360);

    stroke(h, 80, 100);

    line(0, 0, 100, 0, 0, 100 + map(event.energy, 0, maxEnergy, 0, 2000));
    
    popMatrix();
  }
}

void draw() {
  background(15);
  
  directionalLight(200, 30, 40, 0, 1, 0);

  pointLight(200, 60, 60, width / 2, -height, 0);

  translate(width / 2, height / 2, 0); // first move origin to the center

  camera(0, height / 2 - 660, 200.0, 0, height / 2 - 780, 0.0, 0.0, 1.0, 0.0);
  
  rotateX(radians(map(mouseY, 0, height, -240, 240)));

  rotateY(radians(map(mouseX, 0, width, -240, 240)));

  shape(globey);

  drawQuakeLines(quakeList);
}

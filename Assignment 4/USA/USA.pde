PShape usa;

void setup() {
  size(1600, 900);
  
  usa = loadShape("USA.svg");
  
  Table data2000 = loadTable("unemployment.csv", "csv");
}

void draw() {
  scale(2);
  
  usa.enableStyle();
  
  shape(usa, 50, 50);
}

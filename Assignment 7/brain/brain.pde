ArrayList<Layer> layers = new ArrayList<Layer>();

void setup() {
  size(800, 800, P3D);

  colorMode(HSB, 360, 100, 100);
  
  background(30);
  
  camera(width / 2, height / 2, 500, width / 2, height / 2, -1000, 0.0, 1.0, 0.0);
    
  translate(180, 250);
  
  scale(3);
  
  rotateX(radians(44));
  
  for(int i = 1; i < 27; i++) {
    parseMriDat(i);
  }
  
  for(int i = 1; i <6; i++) {
    drawLayer(layers.get(i), -i);
  }
}

void draw() {
}

void drawLayer(Layer layer, int i) {
  for(int x = 0; x < 128; x++) {
   for(int y = 0; y < 128; y++) {
     if (layer.points[x][y] != 0) {
      draw3DPoint(new Point(x, y, i, layer.points[x][y]));
     }
    }
  }
}

void draw3DPoint(Point p) {
  pushMatrix();
  
  translate(p.x, p.y, -p.z);
  
  fill(0, 0, map(p.value, 0, 88, 0, 100));
  
  box(1);
  
  popMatrix();
}

void parseMriDat(int index) {
  BufferedReader reader = createReader("mri" + index + ".dat");
  String line = null;
  try {
    String[] lines = new String[128];
    int row = 0;
    while ((line = reader.readLine()) != null) {
       lines[row++] = line;
    }
    reader.close();
    
    layers.add(new Layer(lines));
  } catch (IOException e) {
    e.printStackTrace();
  }
} 

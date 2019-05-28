ArrayList<Point> points = new ArrayList<Point>();

void setup() {
  size(1000, 1000, P3D); 
  
  noStroke();
  
  background(200);
  
  drawBloodVessels();
  
  colorMode(HSB, 360, 100, 100);

  for(Point p : points) {
    draw3DPoint(p);
  }
}

void drawBloodVessels() {
  for(int i = 1; i < 99; i++) {
    drawVesselByFrame(i);
  }
}

void drawVesselByFrame(int layer) {
   PImage vessalImage = loadImage(layer + ".bmp");

   for(int y = 0; y < 512; y++) {
     for(int x = 0; x < 512; x++) {
       if (vessalImage.pixels[y * 512 + x] != color(0, 0, 0)) {
         points.add(new Point(x, y, layer));
       }
     }
   }
}

void draw3DPoint(Point p) {
  pushMatrix();
  
  translate(p.x, p.y, -p.z);
  
  box(1);
  
  fill(360, 80, p.z);
  
  popMatrix();
}

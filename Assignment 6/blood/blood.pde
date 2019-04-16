void setup() {
  size(1000, 1000, P3D); 
  
  noStroke();
  
  // colorMode(HSB, 360, 100, 100);
  
  drawBloodVessels();
}

ArrayList<Point> points = new ArrayList<Point>();

void drawBloodVessels() {
  for(int i = 1; i < 10; i++) {
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
  
  fill(200, 100, 50);
  
  box(1);
  
  popMatrix();
}

void draw() {
  background(200);
    
  rotateX(radians(map(mouseY, 0, height, -180, 180)));

  rotateY(radians(map(mouseX, 0, width, -180, 180)));
  
  for(Point p : points) {
    draw3DPoint(p);
  }
}

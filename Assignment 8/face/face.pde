int[] femaleIndex = {14, 19, 21, 34};

void setup() {
  size(1000, 600);
  
  background(30);
  
  colorMode(HSB, 360, 100, 100);
  
  strokeWeight(5);
  
  readFolder();
}

void readFolder() {
  for(int i = 1; i < 40; i++) {
    readImageSet(i);
  }
}

void readImageSet(int i) {
  for(int j = 1;j < 10; j++) {
    drawImagePoint(i, j);
  }
}

String getIndex(int index) {
 return (index < 10 ? "0" : "") + String.valueOf(index); 
}

void drawImagePoint(int i, int j) {
  String index = getIndex(i);
  String jndex = getIndex(j);
  PImage image = loadImage(index + "-" + jndex + ".bmp");
  float averageBrightness = analysisImage(image);
  
  if (i == 14 || i == 19 || i == 21 || i == 34) {
   stroke(200, 100, 80);
  } else {
   stroke(30, 100, 80); 
  }

  point(i * 25, map(averageBrightness, 60, 80, 0, 600));
}

float analysisImage(PImage image) {
  float totalBrightness = 0;
  
  for (int x = 0; x < image.width; x++) {
    for (int y = 0; y < image.height; y++) {
      color rgb = image.pixels[y * image.width + x];
      float brightness = brightness(rgb);

      totalBrightness += brightness;
    }
  }
  
  return totalBrightness / (image.width * image.height);
}

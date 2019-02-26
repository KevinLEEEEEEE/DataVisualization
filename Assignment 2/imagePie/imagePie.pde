PImage image;
PImage maskImage;
static int width = 1800;
static int height = 1200;
int[] histogram = new int[360];
double[] normalizedHistogram = new double[360];
HueLine[] lineArray = new HueLine[360];

class HueLine {
  float startX;
  float startY;
  float endX;
  float endY;
  int hue;
  
  HueLine(float startX, float startY, float endX, float endY, int hue) {
    this.startX = startX;
    this.startY = startY;
    this.endX = endX;
    this.endY = endY;
    this.hue = hue;
  }
  
  void drawLine() {
    stroke(this.hue, 80, 100);
    
    line(this.startX, this.startY, this.endX, this.endY);
  }
}

void setup() {
  size(1800, 1200);

  colorMode(HSB, 360, 100, 100);
  
  strokeWeight(4);

  loadImageAndMask();
  
  calculateHistogram();
  
  int maxIndex = normalizeHistogram();
  
  background(maxIndex, 50, 15);
  
  drawColorEclipse(250, 400, width / 2, height / 2);
}

void loadImageAndMask() {
  image = loadImage("image.jpg");
  maskImage = loadImage("mask.jpg");
  
  image.resize(500, 500);
  maskImage.resize(500, 500);
  
  image.loadPixels(); 
  
  image.mask(maskImage);
}

void calculateHistogram() {
  for(int x = 0; x < image.width; x++) {
    for(int y = 0; y < image.height; y++) {
      color rgb = image.pixels[y * image.width + x];
      float hue = hue(rgb);
      
      histogram[(int)hue]++;
    }
  }
}

int normalizeHistogram() {
  int maxAmount = 1;
  int maxIndex = 0;
  
  for(int i = 0; i < 360; i++) {    
    if (histogram[i] > maxAmount) {
      maxAmount = histogram[i];
      
      maxIndex = i;
    }
  }

  for(int i = 0; i < 360; i++) {
    normalizedHistogram[i] = histogram[i] * 1.0 / maxAmount;
  }
  
  return maxIndex;
}

void drawColorEclipse(int maxLine, int offsetLength, int offsetX, int offsetY) {
  for(int i = 0; i < 360; i++) {
    double lineLength = maxLine * normalizedHistogram[i];
    double startLength = offsetLength - lineLength / 2;
    double endLength = offsetLength + lineLength / 2;
    float radius = (i - 180) * PI / 180;
    
    float startX = (float)(startLength * sin(radius));
    float startY = (float)(startLength * cos(radius));
    float endX = (float)(endLength * sin(radius));
    float endY = (float)(endLength * cos(radius));
    
    lineArray[i] = new HueLine(startX + offsetX, startY + offsetY, endX + offsetX, endY + offsetY, i);
  }
}

int i = 0;
 
void draw() {
  image(image, width / 2 - 250, height / 2 - 250);
  
  if(i < 360) {
    lineArray[i].drawLine();
    
    i++;
  }
}

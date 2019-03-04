PImage image;
PImage maskImage;
static int hueAmount = 360;
static int maxLength = 150;
static int offsetLength = 420;
VisualLineIterator iterator;

void setup() {
  size(1800, 1200);

  colorMode(HSB, 360, 100, 100);

  strokeWeight(3);

  loadImageAndMask();
  
  int[] histogram = new int[hueAmount];

  calculateHistogram(histogram);

  float[] normalizedHistogram = new float[hueAmount];

  int maxIndex = normalizeHistogram(histogram, normalizedHistogram);

  background(maxIndex, 50, 15);

  VisualLine[] lineArray = new VisualLine[hueAmount];

  calculateColorEclipse(lineArray, normalizedHistogram, new Point(900, 600));

  iterator = new VisualLineIterator(lineArray);
}

void loadImageAndMask() {
  image = loadImage("image.jpg");
  maskImage = loadImage("mask.jpg");

  image.resize(500, 500);
  maskImage.resize(500, 500);

  image.loadPixels();

  image.mask(maskImage);
}

void calculateHistogram(int[] histogram) {
  for (int x = 0; x < image.width; x++) {
    for (int y = 0; y < image.height; y++) {
      color rgb = image.pixels[y * image.width + x];
      float hue = hue(rgb);

      histogram[(int)hue]++;
    }
  }
}

int normalizeHistogram(int[] histogram, float[] normalizedHistogram) {
  float max = 0;
  int index = 0;

  for (int i = 0; i < hueAmount; i++) {     
    if (histogram[i] > max) {
      max = histogram[i];
      
      index = i;
    }
  }

  for (int i = 0; i < hueAmount; i++) {
    normalizedHistogram[i] = histogram[i] * 1.0 / max;
  }

  return index;
}

void calculateColorEclipse(VisualLine[] lineArray, float[] normalizedHistogram, Point center) {
  for (int i = 0; i < hueAmount; i++) {
    float lineLength = maxLength * normalizedHistogram[i];
    float radius = radians(180 - i);
    
    lineArray[i] = new VisualLine(i, lineLength, radius, center);
  }
}

void draw() {
  image(image, 650, 350);
  
  iterator.next();
}

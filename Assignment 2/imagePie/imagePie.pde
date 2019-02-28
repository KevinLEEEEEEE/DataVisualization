PImage image;
PImage maskImage;
static int hueAmount = 360;
static int maxLength = 150;
static int offsetLength = 420;
VisualLineIterator iterator;

class Point {
  float x;
  float y;

  Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

class VisualLine {
  int hue;
  int step = 4;
  Point center;
  float radius;
  float totalLength;
  float currLength = 0;

  VisualLine(int hue, float totalLength, float radius, Point center) {
    this.hue = hue;
    this.radius = radius;
    this.center = center;
    this.totalLength = totalLength;
  }

  void drawLine(float start, float end) {
    strokeCap(ROUND);

    stroke(this.hue, 80, 100);

    pushMatrix();

    translate(this.center.x, this.center.y);

    rotate(this.radius);

    line(0, start, 0, end);

    popMatrix();
  }

  boolean drawByStep() {
    float currLength = constrain(this.currLength, 0, this.totalLength);

    this.drawLine(offsetLength - currLength / 2, offsetLength + currLength / 2);

    this.currLength += this.step;

    this.step++;

    return this.currLength < this.totalLength;
  }
  
  boolean hasNext() {
    return  this.currLength < this.totalLength;
  }
}

class VisualLineIterator {
  VisualLine[] lineArray;
  boolean canNext = true;
  int index = 0;
  
  VisualLineIterator(VisualLine[] lineArray) {
    this.lineArray = lineArray;
  }
  
  void next() {
    if (!this.canNext) {
      return;
    }
    
    this.lineArray[this.index].drawByStep();
    
    if (!this.lineArray[this.index].hasNext()) {
      this.index++;
      
      if (this.index >= this.lineArray.length) {
        this.canNext = false;
      }
    }
  }
}

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

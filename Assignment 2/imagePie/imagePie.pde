PImage image;
PImage maskImage;
static int width = 1800;
static int height = 1200;
static int hueAmount = 360;
int[] histogram = new int[hueAmount];
double[] normalizedHistogram = new double[hueAmount];
VisualLine[] lineArray = new VisualLine[hueAmount];

class Point {
  float x;
  float y;

  Point(float x, float y) {
    this.x = x;
    this.y = y;
  }

  Point offset(float offsetX, float offsetY) {
    return new Point(this.x + offsetX, this.y + offsetY);
  }
}

class VisualLine {
  int hue;
  int step = 4;
  float totalLength;
  float currLength = 0;
  float sinRadius;
  float cosRadius;
  Point center;

  VisualLine(int hue, float totalLength, float radius, Point center) {
    this.hue = hue;
    this.totalLength = totalLength < 1 ? 1 : totalLength;
    this.center = center;
    this.sinRadius = sin(radius);
    this.cosRadius = cos(radius);
  }

  void drawLine(Point start, Point end) {
    stroke(this.hue, 80, 100);

    line(start.x, start.y, end.x, end.y);
  }

  boolean drawByStep() {
    boolean isMaxLength = this.currLength + this.step >= this.totalLength;
    float currLength = isMaxLength ? this.totalLength : this.currLength;

    float offsetX = currLength * this.sinRadius;
    float offsetY = currLength * this.cosRadius;

    this.drawLine(this.center.offset(-offsetX, -offsetY), this.center.offset(offsetX, offsetY));

    this.currLength += this.step++;

    return !isMaxLength;
  }
}

class VisualLineIterator {
  VisualLine[] lineArray;
  boolean canNext = true;
  int index = 0;
  
  VisualLineIterator(VisualLine[] lineArray) {
    this.lineArray = lineArray;
  }
  
  boolean next() {
    if (!this.canNext) {
      return false;
    }
    
    if (!this.lineArray[this.index].drawByStep()) {
      this.index++;
      
      if (this.index >= this.lineArray.length) {
        this.canNext = false;
        
        return false;
      }
    }
     
    return true;
  }
}

void setup() {
  size(1800, 1200);

  colorMode(HSB, 360, 100, 100);

  strokeWeight(3);

  loadImageAndMask();

  calculateHistogram();

  int maxIndex = normalizeHistogram();

  background(maxIndex, 50, 15);

  drawColorEclipse(130, 420, width / 2, height / 2);
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
  for (int x = 0; x < image.width; x++) {
    for (int y = 0; y < image.height; y++) {
      color rgb = image.pixels[y * image.width + x];
      float hue = hue(rgb);

      histogram[(int) hue]++;
    }
  }
}

int normalizeHistogram() {
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

void drawColorEclipse(int maxLine, int offsetLength, int offsetX, int offsetY) {
  for (int i = 0; i < hueAmount; i++) {
    float lineLength = maxLine * (float)normalizedHistogram[i];
    float radius = (i + 180) * PI / 180;
    float centerX = offsetLength * sin(radius) + offsetX;
    float centerY = offsetLength * cos(radius) + offsetY;
    
    lineArray[i] = new VisualLine(i, lineLength, radius, new Point(centerX, centerY));
  }
}

VisualLineIterator iterator = new VisualLineIterator(lineArray);

void draw() {
  image(image, width / 2 - 250, height / 2 - 250);
  
  iterator.next();
}

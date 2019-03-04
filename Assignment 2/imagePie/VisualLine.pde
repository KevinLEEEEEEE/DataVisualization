
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

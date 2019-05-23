ArrayList<Circle> circles = new ArrayList<Circle>();
// int totalCount = 193;
int totalCount = 13;
int max = 0;

void setup() {
  size(1000, 1000);
  
  parseCircles(0, circles);

  max = calcMax(circles);

  println(max);
  
  drawCircles(circles);
}

void parseCircles(int filename, ArrayList<Circle> container) {
  BufferedReader reader = createReader(filename + ".circles");
  String line = null;
  
  try {
    while ((line = reader.readLine()) != null) {
      container.add(new Circle(line));
    }
    reader.close();
  } catch (IOException e) {
    e.printStackTrace();
  }
}

int calcMax(ArrayList<Circle> container) {
  int max = 0;
  for(Circle circle : container) {
    if (circle.count > max) {
      max = circle.count;
    }
  }

  return max;
}

void drawCircles(ArrayList<Circle> container) {
  for(int y = 0; y < 10; y++) {
    for(int x = 0; x < 10; x++) {
      int index = y * 20 + x;
      if (index < totalCount) {
        drawCircle(x, y, container.get(index));
      }
    }
  }
}

void drawCircle(int x, int y, Circle circle) {
  float radius = map(circle.count, 1, max, 1, 50);

  circle(x * 50 + 25, y * 50 + 25, radius);
}

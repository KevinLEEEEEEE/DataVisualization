ArrayList<Circle> circles = new ArrayList<Circle>();
ArrayList<Connect> connects = new ArrayList<Connect>();
HashMap<Integer, Integer> usersMap = new HashMap<Integer, Integer>();
int MAXRADIUS = 100;

void setup() {
  size(2000, 1000);
  
  background(25);
  
  stroke(130);
  
  parseCircles(0, circles);
  parseCircles(107, circles);
  parseCircles(348, circles);
  parseCircles(414, circles);
  parseCircles(686, circles);
  parseCircles(698, circles);
  parseCircles(1684, circles);
  parseCircles(1912, circles);
  parseCircles(3437, circles);
  parseCircles(3980, circles);
  
  parseEdges(0, connects);
  parseEdges(107, connects);
  parseEdges(348, connects);
  parseEdges(414, connects);
  parseEdges(686, connects); 
  parseEdges(1684, connects);
  parseEdges(1912, connects);
  parseEdges(3437, connects);
  parseEdges(3980, connects);
  
  mapUsers(circles);

  drawEdges(connects);
  
  drawCircles(circles, calcMax(circles));
}

void mapUsers(ArrayList<Circle> container) {
  for(int i = 0; i < container.size(); i++) {
    Circle curr = container.get(i);

    for(int j = 0; j < curr.users.length; j++) {
      int id = curr.users[j];
      
      usersMap.put(id, i);
    }
  }
}

void parseEdges(int filename, ArrayList<Connect> container) {
  BufferedReader reader = createReader(filename + ".edges");
  String line = null;
  
  try {
    while ((line = reader.readLine()) != null) {
      container.add(new Connect(line));
    }
    reader.close();
  } catch (IOException e) {
    e.printStackTrace();
  }
}

void drawEdges(ArrayList<Connect> container) {
  for(Connect connect : container) {
    if(usersMap.containsKey(connect.user1) && usersMap.containsKey(connect.user2))  {
      int circle1 = usersMap.get(connect.user1);
      int circle2 = usersMap.get(connect.user2);
      
      if (circle1 != circle2) {
        drawEdge(circle1, circle2);
      }
    }
  }
}

void drawEdge(int circle1, int circle2) {
  int x1 = getPosByIndex(circle1 % 20);
  int y1 = getPosByIndex(circle1 / 20);
  int x2 = getPosByIndex(circle2 % 20);
  int y2 = getPosByIndex(circle2 / 20);
  
    line(x1, y1, x2, y2);
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

void drawCircles(ArrayList<Circle> container, int max) {
  for(int y = 0; y < 10; y++) {
    for(int x = 0; x < 20; x++) {
      int index = y * 20 + x;
      if (index < container.size()) {
        drawCircle(x, y, container.get(index), max);
      }
    }
  }
}

void drawCircle(int x, int y, Circle circle, int max) {
  float radius = map(circle.count, 1, max, 5, MAXRADIUS);

  circle(getPosByIndex(x), getPosByIndex(y), radius);
}

int getPosByIndex(int index) {
  return index * MAXRADIUS + MAXRADIUS / 2;
}

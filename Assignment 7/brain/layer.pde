class Layer {
  int[][] points = new int[128][128];
  
  Layer(String[] layer) {
    formatLayer(layer);
  }
  
  void formatLayer(String[] layer) {
    for(int i = 0; i < 128; i++) {
      String[] pieces = split(layer[i], ",");
      
      for(int j = 0; j < 128; j++) {
        points[i][j] = Integer.parseInt(pieces[j]);
      }
    }
  }
}

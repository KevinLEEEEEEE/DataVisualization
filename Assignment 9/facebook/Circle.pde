class Circle {
  int[] users;
  int count;
  
  Circle(String line) {
    String[] pieces = split(line, TAB);
    
    this.count = pieces.length - 1;
    
    this.calcUsers(pieces);
  }
  
  void calcUsers(String[] pieces) {
    this.users = new int[this.count];
    
    for(int i = 1;i < this.count; i++) {
      this.users[i] = 
    }
  }
}

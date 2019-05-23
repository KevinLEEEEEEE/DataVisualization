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
    
    for(int i = 0;i < this.count; i++) {
      this.users[i] = Integer.parseInt(pieces[i + 1]);
    }
  }
}

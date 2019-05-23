class Connect {
  int user1;
  int user2;
  
  Connect(String line) {
    String[] pieces = split(line, ' ');
    
    this.user1 = Integer.parseInt(pieces[0]);
    
    this.user2 = Integer.parseInt(pieces[1]);
  }
}

void drawGrid(){
  int ySegment = (int) Math.round(HEIGHT/ROWS);
  int xSegment = (int) Math.round(WIDTH/COLUMNS);
  
  for(int j = 0; j<ROWS; j++){
    line(0, ySegment*j, width, ySegment*j);
  }  
  for(int i = 0; i<COLUMNS; i++){
    line(xSegment*i, 0, xSegment*i, height);
  }
  
}
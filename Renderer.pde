class Renderer{
  public int headerHeight = 2;
  public int footerHeight = 1;
  
  public void drawGrid(){
    int ySegment = (int) Math.round(HEIGHT/(ROWS+headerHeight + footerHeight));
    int xSegment = (int) Math.round(WIDTH/COLUMNS);
    
    for(int j = 2; j<ROWS+3; j++){
      line(0, ySegment*j, width, ySegment*j);
    }  
    for(int i = 0; i<COLUMNS; i++){
      line(xSegment*i, ySegment*2, xSegment*i, height-ySegment);
    }
  
  }
  
  public void drawOut(){
    ellipseMode(RADIUS);
    fill(0);
    //ellipse(width, 
  }
}
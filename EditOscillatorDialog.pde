class Renderer{
  
  public void drawCells(){
    for (Cell[] row : cells){
      for (Cell c : row){
        c.drawCell();
      }
    }
  }
  
  public void drawOut(){
    ellipseMode(RADIUS);
    fill(0);
    float x = width;
    float y = ySegment * HEADER_HEIGHT + ySegment * (ROWS)/2;
    ellipse(x, y, 30,30);
    noFill();
    bezier(x-200, y-200, x, y - 200, x-200, y, x, y);
    fill(255);
    textSize(12);
    text("Out", x-25, y); 

  }
  
  public void drawTitle(){
    fill(0);
    textSize(25);
    textAlign(CENTER);
    text("FM Synthesis Board", width/2, ySegment/2);
  }
  
  public void drawHelp(){
    fill(0);
    textSize(20);
    textAlign(CENTER);
    text("Help", width-100, ySegment/2);
  
  }
}
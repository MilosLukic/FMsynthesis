class Renderer{
  
  public void drawCells(){
    System.out.println(cells.length+ " " + cells[0].length);
    for (Cell[] row : cells){
      for (Cell c : row){
        
        c.drawCell();
      }
    }
  }
  
  public void drawOut(){
    ellipseMode(RADIUS);
    fill(0);
    //ellipse(width, 
  }
}
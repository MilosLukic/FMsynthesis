class Renderer{
  
  public void drawCells(){
    for (Cell[] row : cells){
      for (Cell c : row){
        if (lockedOscillator != null && lockedOscillator == c.oscillator)
          continue;
         c.drawCell();
      }
    }
    for (Cell[] row : cells){
      for (Cell c : row){
        if(c.oscillator != null) c.drawConnection();
      }
    }
    
    if(lockedOscillator != null) lockedOscillator.container.drawCell();
    
    drawActiveConnection();
  }
  
  public void drawActiveConnection(){
    Oscillator activeConn = null;
    if (activeIn != null){
      activeIn.container.drawDynamicOut((float) mouseX, (float) mouseY);
    }else if(activeOut != null){
      activeOut.container.drawDynamicIn((float) mouseX, (float) mouseY);
    }
  }
  
  public void drawOut(){
    audioOut.render();
  }
  
  public void drawTitle(){
    fill(0);
    textSize(25);
    textAlign(CENTER);
    text("FM Synthesis Board", width/2, ySegment/2);
  }
  
  public void drawToolbar(){
    fill(0);
    textSize(20);
    textAlign(CENTER);
    text("Help", width-100, ySegment/2);
    
    fill(0);
    textSize(20);
    textAlign(CENTER);
    text("Play", width-200, ySegment/2);
  }
  

  
  public void drawBackground(){
    background(255);
  }
}
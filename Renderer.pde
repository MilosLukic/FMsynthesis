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
  
  public void drawOscillatorEditor(){

    fill(200,200,200);
    rect(width/2-editorWidth/2, height/2-editorHeight/2, editorWidth, editorHeight, 10);
    
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
    textSize(40);
    textAlign(CENTER);
    text("FM SYNTHESIS BOARD", width/4, ySegment/2 + 15);
  }
  
  public void drawToolbar(){
  }
  

  
  public void drawBackground(){
    background(255);

  
    
  }
  
  


}
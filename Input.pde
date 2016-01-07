boolean activeThread = false;

void mousePressed() {
    try{
        if(mouseButton == LEFT){
          if (mouseEvent.getClickCount()==2){
            cells[floor((mouseY-(ySegment*HEADER_HEIGHT))/ySegment)][floor(mouseX/xSegment)].editOscillator();
          }else{
            cells[floor((mouseY-(ySegment*HEADER_HEIGHT))/ySegment)][floor(mouseX/xSegment)].manageInput();
          }
        }else if (mouseButton == RIGHT){
          Cell cell = cells[floor((mouseY-(ySegment*HEADER_HEIGHT))/ySegment)][floor(mouseX/xSegment)];
          if(cell.isEmpty()){
            cell.initOscillator();
            oscillators.add(cell.oscillator);
          }else{
            for(Oscillator oscillator : oscillators){
              if (oscillator.outOscillator == cell.oscillator){
                oscillator.outOscillator = null;
              }
            }
            cell.removeOscillator();
          }
        }
    }catch(Exception e){
      // OUT OF BOUNDS
    }
    if(mouseButton == LEFT){
      audioOut.manageInput();
      manageToolbarInput();  
  }
}

void mouseReleased() {
  if (lockedOscillator != null)
    lockedOscillator.container.moveOscillatorTo(cells[floor((mouseY-(ySegment*HEADER_HEIGHT))/ySegment)][floor(mouseX/xSegment)]);
  
  lockedOscillator = null;
}

void keyPressed(){
  if (key == 'c' && activeThread == false){
    activeThread = true;
    thread("play");
  }
}

void keyReleased(){
  if (key == 'c'){
    audioOut.stop();
  }
}

public void play(){
  if(!audioOut.playing)
      audioOut.play();
}
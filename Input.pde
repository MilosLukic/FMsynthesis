boolean activeThread = false;
LinkedList<Note> activeNotes = new LinkedList<Note>();
LinkedList<Note> nextActiveNotes = null;
HashMap<String, Integer> relativeNotes;

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
  }
}

void mouseReleased() {
  if (lockedOscillator != null)
    lockedOscillator.container.moveOscillatorTo(cells[floor((mouseY-(ySegment*HEADER_HEIGHT))/ySegment)][floor(mouseX/xSegment)]);
  
  lockedOscillator = null;
}

void keyPressed(){
  for (Note activeNote : activeNotes){
    
    if (activeNote.letter == key){
      
      activeNote.active=true;
      activeNote.dying=false;
    }
  }
}

void keyReleased(){
  for (Note activeNote : activeNotes){
    if (activeNote.letter == key){
      activeNote.dying = true;
      activeNote.time = 0;
    }
  }
}

public void play(){
  if(!audioOut.playing)
      audioOut.play();
}
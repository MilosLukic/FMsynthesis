void mousePressed() {
  if(mouseButton == LEFT){
    cells[floor((mouseY-(ySegment*HEADER_HEIGHT))/ySegment)][floor(mouseX/xSegment)].manageInput();
  }else if (mouseButton == RIGHT){
    try{
      Cell cell = cells[floor((mouseY-(ySegment*HEADER_HEIGHT))/ySegment)][floor(mouseX/xSegment)];
      if(cell.isEmpty()){
        cell.initOscillator();
      }else{
        cell.removeOscillator();
      }
    }catch(Exception e){
      // OUT OF BOUNDS
    }
  }
}
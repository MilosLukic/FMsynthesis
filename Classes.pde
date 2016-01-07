class Cell{
  boolean empty;
  int leftTopX;
  int leftTopY;
  int segmentX;
  int segmentY;
  Oscillator oscillator;
  float oscillatorSizeRelative = 0.6;
  float pointInX;
  float pointInY;
  float pointOutX;
  float pointOutY;
  int connectorSize = 10;
  
  public Cell(boolean empty, int leftTopX, int leftTopY, int segmentX, int segmentY ){
    this.empty = empty;
    this.leftTopX = leftTopX;
    this.leftTopY = leftTopY;
    this.segmentX = segmentX;
    this.segmentY = segmentY;
    pointInX = leftTopX;
    pointInY = leftTopY + segmentY/2;
    pointOutX = leftTopX + segmentX * oscillatorSizeRelative;
    pointOutY = leftTopY + segmentY/2;
  }
  
  public void initOscillator(){
    this.oscillator = new Oscillator(this);
    this.empty = false;
  }
  
  public void removeOscillator(){
    /* Remove oscillator form oscillators list */
    for(Oscillator osc : oscillators) {
      if(osc == this.oscillator) {
        oscillators.remove(osc);
        break;
       }
    }
    Oscillator temp = this.oscillator;
    oscillator.container = null;
    this.oscillator = null;
    this.empty = true;
    temp = null;
  }
  
  public void moveOscillatorTo(Cell target){
    if (this.empty || !target.empty){
      return;
    }
    
    target.oscillator = this.oscillator;
    target.oscillator.container = target;
    this.oscillator = null;
    target.setEmpty(false);
    this.setEmpty(true);
  }
  
  public void setEmpty(boolean empty){
    this.empty = empty;
  }
  
  public boolean isEmpty(){
    return this.oscillator == null;
  }
  
  public void editOscillator(){
    if(!this.isEmpty()){
      editingOscillator = this.oscillator;
      showOscillatorEditor = true;
      frequencyTextField.setText(Integer.toString(this.oscillator.frequency));
      amplitudeTextField.setText(Float.toString(this.oscillator.amplitude));
      frequencyTextField.show();
      amplitudeTextField.show();
      submitButton.show();
    }
  }
  
  public void manageInput(){
    
    if (this.empty){
      activeIn = null;
      activeOut = null;
      return;
    }
    
    float distanceIn = sqrt((this.pointInX - mouseX)*(this.pointInX - mouseX) + (this.pointInY - mouseY)*(this.pointInY - mouseY));
    float distanceOut = sqrt((this.pointOutX - mouseX)*(this.pointOutX - mouseX) + (this.pointOutY - mouseY)*(this.pointOutY - mouseY));
    
    if( distanceIn < connectorSize){
      if (activeOut != null && activeOut != this.oscillator){
        activeOut.setOutOscillator(this.oscillator);
        activeIn = null;
        activeOut = null;
      }else if(activeIn == null){
        activeIn = this.oscillator;
      }
      
    }else if (distanceOut < connectorSize){
      System.out.println("out");
      if (activeIn != null && activeIn != this.oscillator){
        this.oscillator.setOutOscillator(activeIn);
        this.oscillator.audioOut = null;
        System.out.println("connected");
        activeIn = null;
        activeOut = null;
      }else if(activeOut == null){
        activeOut = this.oscillator;
      }
    }else if(activeIn != null || activeOut != null){
      activeIn = null;
      activeOut = null;
    }else if(mouseX > pointInX && mouseX < pointOutX && mouseY > leftTopY && mouseY < leftTopY + segmentY){
      lockedOscillator = this.oscillator;
    }
  }
  
  public void drawCell(){
    fill(255);
    stroke(0);
    rect(leftTopX, leftTopY, segmentX, segmentY);
    if (!this.empty)
      drawOscillator();
  }
  
  public void drawConnection(){
    noFill();
    if (this.oscillator != null && this.oscillator.outOscillator != null){
          float outX = this.oscillator.outOscillator.container.pointInX;
          float outY = this.oscillator.outOscillator.container.pointInY;
          bezier(pointOutX, pointOutY, outX, pointOutY,  pointOutX, outY, outX, outY);
    }else if(this.oscillator != null && this.oscillator.audioOut != null){
        float outX = this.oscillator.audioOut.x;
        float outY = this.oscillator.audioOut.y;
        bezier(pointOutX, pointOutY, outX, pointOutY,  pointOutX, outY, outX, outY);
    }
    
  }
  
  public void drawDynamicOut(float dynamicX, float dynamicY){
        bezier(pointInX, pointInY, dynamicX, pointInY,  pointInX, dynamicY, dynamicX, dynamicY);
  }
  
  public void drawDynamicIn(float dynamicX, float dynamicY){
        bezier(dynamicX, dynamicY, pointOutX, dynamicY,  dynamicX, pointOutY, pointOutX, pointOutY);
  }

  public void drawOscillator(){
    float referenceX = leftTopX;
    float referenceY = leftTopY;
    
    if (lockedOscillator == this.oscillator){
      referenceX = mouseX - segmentX*oscillatorSizeRelative*0.5;
      referenceY = mouseY - segmentY*0.5;
    }
    
    textSize(10);
    fill(200);
    stroke(0);
    rect(referenceX, referenceY, segmentX*oscillatorSizeRelative, segmentY, 20);
    fill(255,5,5);
    arc(referenceX, referenceY + segmentY*0.5, connectorSize, connectorSize, -HALF_PI, HALF_PI);
    arc(referenceX + segmentX*oscillatorSizeRelative, referenceY + segmentY*0.5, connectorSize, connectorSize, HALF_PI, PI+HALF_PI);
    
    text("f", referenceX+segmentX*0.1, referenceY+segmentY*0.3); 
    text(this.oscillator.frequency, referenceX+segmentX*0.2, referenceY+segmentY*0.3); 
    text("A", referenceX+segmentX*0.1, referenceY+segmentY*0.7);
    text(this.oscillator.amplitude, referenceX+segmentX*0.2, referenceY+segmentY*0.7); 
    
  }
}

class Oscillator{
  boolean active = true;
  int frequency = 440;
  float amplitude = 1.0f;
  String type = "SINE";
  Oscillator outOscillator = null;
  AudioOut audioOut = null;
  float pointOutX, pointOutY;
  Cell container = null;
  
  public Oscillator(Cell container){
    this.container = container;
  }
  
  public int getFrequency(){
    return this.frequency;
  }
  
  public float getAmplitude(){
    return this.amplitude;
  }
  public String getType(){
    return this.type;
  }
  
  public void setFrequency(int frequency){
    this.frequency = frequency;
   }
   
   public void setAmplitude(float amplitude){
    this.amplitude = amplitude;
   }
   
   public void setType(){
    this.type = type;
   }
   
   public void setOutOscillator(Oscillator outOscillator){
     this.outOscillator = outOscillator;
   }

}
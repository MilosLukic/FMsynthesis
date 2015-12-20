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
  int connectorSize = 5;
  
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
    this.oscillator = new Oscillator();
    this.empty = false;
  }
  
  public void removeOscillator(){
    this.oscillator = null;
    this.empty = true;
  }
  
  public void moveOscillatorTo(Cell target){
    if (this.empty){
      return;
    }
    target.oscillator = this.oscillator;
    this.oscillator = null;
    target.setEmpty(false);
    this.setEmpty(true);
  }
  
  public void setEmpty(boolean empty){
    this.empty = empty;
  }
  
  public boolean isEmpty(){
    return this.empty;
  }
  
  public void manageInput(){
    if (this.empty){
      return;
    }
    
    float distanceIn = sqrt((this.pointInX - mouseX)*(this.pointInX - mouseX) + (this.pointInY - mouseY)*(this.pointInY - mouseY));
    float distanceOut = sqrt((this.pointOutX - mouseX)*(this.pointOutX - mouseX) + (this.pointOutY - mouseY)*(this.pointOutY - mouseY));
    
    if( distanceIn < connectorSize){
      if (activeOut != null && activeOut != this.oscillator){
        this.oscillator.setOutOscillator(activeIn);
      }
      
    }else if (distanceOut < connectorSize){
      if (activeIn != null && activeIn != this.oscillator){
        activeOut.setOutOscillator(this.oscillator);
      }
    }
  }
  
  public void drawCell(){
    fill(255);
    stroke(0);
    rect(leftTopX, leftTopY, segmentX, segmentY);
    if (!this.empty)
      drawOscillator();
  }
  
  public void drawOscillator(){
    
    textSize(10);
    fill(200);
    stroke(0);
    rect(leftTopX, leftTopY, segmentX*oscillatorSizeRelative, segmentY, 20);
    fill(255,5,5);
    ellipse(this.pointInX, this.pointInY, connectorSize, connectorSize);
    ellipse(this.pointOutX, this.pointOutY, connectorSize, connectorSize);
    
    text("f", leftTopX+segmentX*0.1, leftTopY+segmentY*0.3); 
    text(this.oscillator.frequency, leftTopX+segmentX*0.2, leftTopY+segmentY*0.3); 
    text("A", leftTopX+segmentX*0.1, leftTopY+segmentY*0.7);
    text(this.oscillator.amplitude, leftTopX+segmentX*0.2, leftTopY+segmentY*0.7); 
    
  }
}

class Oscillator{
  boolean active = true;
  int frequency = 440;
  float amplitude = 1.0f;
  String type = "SINE";
  Oscillator outOscillator = null;
  float pointInX, pointInY, pointOutX, pointOutY;
  

  
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
   
   public void setFrequency(float amplitude){
    this.amplitude = amplitude;
   }
   
   public void setType(){
    this.type = type;
   }
   
   public void setOutOscillator(Oscillator outOscillator){
     this.outOscillator = outOscillator;
   }
}
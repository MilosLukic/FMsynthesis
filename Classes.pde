class Cell{
  boolean empty;
  int leftTopX;
  int leftTopY;
  int segmentX;
  int segmentY;
  Oscillator oscillator;
  float oscillatorSizeRelative = 0.6;
  
  public Cell(boolean empty, int leftTopX, int leftTopY, int segmentX, int segmentY ){
    this.empty = empty;
    this.leftTopX = leftTopX;
    this.leftTopY = leftTopY;
    this.segmentX = segmentX;
    this.segmentY = segmentY;
  }
  
  public void initOscillator(){
    this.oscillator = new Oscillator(leftTopX, leftTopY + segmentY/2, leftTopX + segmentX * oscillatorSizeRelative, leftTopY + segmentY/2);
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
    
  }
  
  public void drawCell(){
    fill(255);
    stroke(0);
    rect(leftTopX, leftTopY, segmentX, segmentY);
    if (!this.empty)
      drawOscillator();
  }
  
  public void drawOscillator(){
    
    fill(200);
    stroke(0);
    rect(leftTopX, leftTopY, segmentX*oscillatorSizeRelative, segmentY, 20);
    fill(255,5,5);
    ellipse(this.oscillator.pointInX, this.oscillator.pointInY, 5, 5);
    ellipse(this.oscillator.pointOutX, this.oscillator.pointOutY, 5, 5);
  }
}

class Oscillator{
  boolean active = true;
  int frequency = 440;
  float amplitude = 1.0f;
  String type = "SINE";
  Oscillator outOscillator = null;
  float pointInX, pointInY, pointOutX, pointOutY;
  
  public Oscillator(float pointInX, float pointInY, float pointOutX, float pointOutY){
    this.pointInX = pointInX;
    this.pointInY = pointInY;
    this.pointOutX = pointOutX;
    this.pointOutY = pointOutY;
  };
  
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
}
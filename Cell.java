class Cell{
  boolean empty;
  Oscilator oscilator;
  
  public Cell(boolean empty){
    this.empty = empty;
  }
  
  public void initOscilator(){
    this.oscilator = new Oscilator();
    this.empty = false;
  }
  
  public void removeOscilator(){
    this.oscilator = null;
    this.empty = true;
  }
  
  public void moveOscilatorTo(Cell target){
    if (this.empty){
      return;
    }
    target.oscilator = this.oscilator;
    this.oscilator = null;
    target.setEmpty(false);
    this.setEmpty(true);
  }
  
  public void setEmpty(boolean empty){
    this.empty = empty;
  }
}

class Oscilator{
  boolean active = true;
  int frequency = 440;
  float amplitude = 1.0f;
  String type = "SINE";
  
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
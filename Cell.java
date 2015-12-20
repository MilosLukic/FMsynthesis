class Cell{
  boolean empty;
  Oscillator Oscillator;
  
  public Cell(boolean empty){
    this.empty = empty;
  }
  
  public void initOscillator(){
    this.Oscillator = new Oscillator();
    this.empty = false;
  }
  
  public void removeOscillator(){
    this.Oscillator = null;
    this.empty = true;
  }
  
  public void moveOscillatorTo(Cell target){
    if (this.empty){
      return;
    }
    target.Oscillator = this.Oscillator;
    this.Oscillator = null;
    target.setEmpty(false);
    this.setEmpty(true);
  }
  
  public void setEmpty(boolean empty){
    this.empty = empty;
  }
}

class Oscillator{
  boolean active = true;
  int frequency = 440;
  float amplitude = 1.0f;
  String type = "SINE";
  Oscillator outOscillator = null;
  
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
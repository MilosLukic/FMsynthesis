
class AudioOut{
  float x;
  float y;
  float offsetX;
  float radius;
  int sampleRate = 8000;
  
  public AudioOut(){
    this.x = width;
    this.y = ySegment * HEADER_HEIGHT + ySegment * (ROWS)/2;
    this.offsetX = -25;
    this.radius = 30;
  }
  
  public void play(){
    int time = 0;
    LinkedList<Oscillator> connectedToOut = new LinkedList<Oscillator>();
    double value = 0;
    
    try {
        System.out.println("playing");
        AudioFormat af = new AudioFormat((float) sampleRate, 8, 1, true, true);
        DataLine.Info info = new DataLine.Info(SourceDataLine.class, af);
        SourceDataLine source = (SourceDataLine) AudioSystem.getLine(info);
        source.open(af);
        source.start();

        byte[] buf = new byte[sampleRate]; // sampleRate *
    
        for(int i = 0; i<buf.length; i++){
          for (Oscillator o : oscillators){
            if (o.audioOut != null){
              connectedToOut.add(o);
              value += getSignal(o, i);
            }
          }
          buf[i] = (byte) value;
          
      //  System.out.println(value);
        }
        
        source.write(buf, 0, buf.length);
        source.drain();
        source.stop();
        source.close();

    } catch (Exception e1) {
        System.out.println(e1);
    }
  }
  
  public double getSignal(Oscillator oscillator, int time){
    LinkedList<Oscillator> connectedToOut = new LinkedList<Oscillator>();
    float value = 0;
    
    for (Oscillator o : oscillators){
      if (o.outOscillator == oscillator){
        
        value += getSignal(o, time); 
      }
    }
    
              System.out.println( 2.0 * Math.PI * ((double) oscillator.frequency) * time / (double) sampleRate + value);
    return Math.sin( 2 * Math.PI * oscillator.frequency * time / sampleRate + value);
  }
  
  public void manageInput(){
    float distance = sqrt((this.x - mouseX)*(this.x - mouseX) + (this.y - mouseY)*(this.y - mouseY));
    if (distance < radius){
      if(activeOut != null){
        activeOut.outOscillator = null;
        activeOut.audioOut = audioOut;
        activeOut = null;
        activeIn = null;
      }
    }
  }
  
  public void render(){
    ellipseMode(RADIUS);
    fill(0);
    ellipse(this.x, this.y, radius, radius);
    noFill();
    fill(255);
    textSize(12);
    text("Out", this.x+this.offsetX, this.y); 
  }
  
}
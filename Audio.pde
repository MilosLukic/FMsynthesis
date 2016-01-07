
class AudioOut {
  float x;
  float y;
  float offsetX;
  float radius;
  int sampleRate = 12050;
  boolean playing = false;

  public AudioOut() {
    this.x = width;
    this.y = ySegment * HEADER_HEIGHT + ySegment * (ROWS)/2;
    this.offsetX = -25;
    this.radius = 30;
  }


  public void play() {
    long time = 0;
    LinkedList<Oscillator> connectedToOut = new LinkedList<Oscillator>();
    float value = 0;
    playing = true;
    System.out.println("playing");
    try {
      AudioFormat af = new AudioFormat((float) sampleRate, 8, 1, true, true);
      DataLine.Info info = new DataLine.Info(SourceDataLine.class, af);
      SourceDataLine source = (SourceDataLine) AudioSystem.getLine(info);
      Envelope envelope = new Envelope();

      byte[] buf = new byte[100]; 
      source.open(af, buf.length);
      source.start();
      while (this.playing) {
        for (int i = 0; i<buf.length; i++) {
          time++;
          value = 0;
          for (Oscillator o : oscillators) {
            if (o.audioOut != null) {
              connectedToOut.add(o);
              value += getSignal(o, time);
            }
          }
          buf[i] = (byte) (envelope.coeff(time, sampleRate)*value);
        }


        source.write(buf, 0, buf.length);
      }
      if (envelope != null) {
        int sampleNumber = Math.round(envelope.release*sampleRate);
        int currentSamples = 0;
        long currentTime = time;
        while (currentSamples < sampleNumber) {
          for (int i = 0; i<buf.length; i++) {
            time++;
            value = 0;
            for (Oscillator o : oscillators) {
              if (o.audioOut != null) {
                connectedToOut.add(o);
                value += getSignal(o, time);
              }
            }
            buf[i] = (byte) (envelope.release((time - currentTime)/(float)sampleNumber )*value);
          }
          currentSamples += buf.length;
          source.write(buf, 0, buf.length);
        }
      }

      source.drain();
      source.stop();
      source.close();
    } 
    catch (Exception e1) {
      System.out.println(e1);
    }
    activeThread = false;
  }

  public void stop() {
    this.playing = false;
  }

  public double getSignal(Oscillator oscillator, long time) {
    LinkedList<Oscillator> connectedToOut = new LinkedList<Oscillator>();
    float value = 0;

    for (Oscillator o : oscillators) {
      if (o.outOscillator == oscillator) {

        value += getSignal(o, time);
      }
    }
    return (float) oscillator.amplitude * Math.sin( 2 * Math.PI * oscillator.frequency * time / this.sampleRate + value);
  }

  public void manageInput() {
    float distance = sqrt((this.x - mouseX)*(this.x - mouseX) + (this.y - mouseY)*(this.y - mouseY));
    if (distance < radius) {
      if (activeOut != null) {
        activeOut.outOscillator = null;
        activeOut.audioOut = audioOut;
        activeOut = null;
        activeIn = null;
      }
    }
  }

  public void render() {
    ellipseMode(RADIUS);
    fill(0);
    ellipse(this.x, this.y, radius, radius);
    noFill();
    fill(255);
    textSize(12);
    text("Out", this.x+this.offsetX, this.y);
  }
}
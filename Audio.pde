

class AudioOut {
  float x;
  float y;
  float offsetX;
  float radius;
  int sampleRate = 12050;
  boolean playing = false;
  float maxSpec = 0;
  FFT fft;
  byte[] buf;
  float[] floatBuf;
  SourceDataLine source;
  AudioFormat af;

  public AudioOut() {
    this.x = width;
    this.y = ySegment * HEADER_HEIGHT + ySegment * (ROWS)/2;
    this.offsetX = -25;
    this.radius = 30;


    try {
      af = new AudioFormat((float) sampleRate, 8, 1, true, true);
      DataLine.Info info = new DataLine.Info(SourceDataLine.class, af);
      source = (SourceDataLine) AudioSystem.getLine(info);
      buf = new byte[512]; 
      floatBuf = new float[512];
      source.open(af, buf.length);
      fft = new FFT(buf.length, sampleRate);
    }    
    catch (Exception e1) {
      System.out.println(e1);
      System.exit(1);
    }
    thread("play");
  }

  public void kill() {
    source.drain();
    source.stop();
    source.close();
  }


  public void play() {
    long time = 0;
    LinkedList<Oscillator> connectedToOut = new LinkedList<Oscillator>();
    float value = 0;
    playing = true;
    int count = 0;
    source.start();
    while (this.playing) {
      for (int i = 0; i<buf.length; i++) {
        time++;
        value = 0;
        count = 0;
        for (Note activeNote : activeNotes) {
          if (!activeNote.active) continue;
          else count++;
          
          float tempSample = 0;
          for (Oscillator o : oscillators) {
            if (o.audioOut != null) {
              connectedToOut.add(o);
              tempSample += getSignal(o, time, activeNote);
            }
          }
          if (activeNote.dying){
            if (activeNote.lastAmplitude <= 0f){
              activeNote.active = false;
              activeNote.dying = false;
              activeNote.time = 0;
            }
            
          }
          value += tempSample;
          activeNote.time++;
        }

        floatBuf[i] = value*100;
        buf[i] = (byte) floatBuf[i];
      }
      source.write(buf, 0, buf.length);
    }

  }

  public void stop() {
    this.playing = false;
  }

  public double getSignal(Oscillator oscillator, long time, Note n) {
    /* If we are calculating singal for end oscillator, autotune the frequency to some tone */
    LinkedList<Oscillator> connectedToOut = new LinkedList<Oscillator>();
    float value = 0;

    for (Oscillator o : oscillators) {
      if (o.outOscillator == oscillator) {
        value += getSignal(o, time, n);
      }
    }
    
    int frequency = (int) tone.getFrequency(n.number);
    if (oscillator.audioOut == null){
      frequency = oscillator.frequency * frequency / oscillator.outOscillator.frequency;
    }
    
    if (n.dying){
      n.lastAmplitude = oscillator.envelope.release(n.time, sampleRate, n.lastAmplitude);
    }else{
      n.lastAmplitude = oscillator.envelope.coeff(n.time, sampleRate, n)*0.7;
    }
    return (float) oscillator.amplitude * n.lastAmplitude * Math.sin( 2 * Math.PI * frequency * time / this.sampleRate + value);
      
  }

  public void manageInput() {
    float distance = sqrt((this.x - mouseX)*(this.x - mouseX) + (this.y - mouseY)*(this.y - mouseY));
    if (distance < radius) {
      if (activeOut != null) {
        activeOut.outOscillator = null;
        activeOut.setAudioOut(audioOut);
        activeOut = null;
        activeIn = null;
      }
    }
  }

  public void drawFFT() {
    float g = 0;
    float h = 0;
    float specStep;
    int specFraction = 1;

    float specScale = (float) width / (fft.specSize() / specFraction);

    float[] group = getGroup(32);

    // Frekvenčni pasovi
    noStroke();
    for (int i = 0; i < fft.specSize() / specFraction; i++) {
      g = map(fft.getBand(i), 0, maxSpec, 50, 255);
      h = map(fft.getBand(i), 0, maxSpec, 2, ySegment);

      fill(173, g, 47);
      rect(i * specScale, ySegment - h, specScale, h);
    }

    // Povprečja
    stroke(255, 255, 0, 200);
    specStep = width / group.length;
    for (int i = 0; i < group.length; i++) {
      h = height - map(group[i], 0, maxSpec, 0, height);
      line(i * specStep, h, (i + 1) * specStep, h);
    }
  }

  public float[] getGroup(int theGroupNum) {
    // Izvedemo FFT nad trenutnimi vzorci
    fft.forward(floatBuf);

    // Povprečimo v skupine
    float[] group = new float[theGroupNum];

    int specLimit = fft.specSize() - 1;
    int groupSize = specLimit / theGroupNum;
    for (int i = 0; i < group.length; i++) {
      group[i] = 0;
    }

    for (int i = 0; i < specLimit; i++) {
      if (fft.getBand(i) > maxSpec) {
        maxSpec = fft.getBand(i);
      }
      int index = (int) Math.floor(i / groupSize);
      group[index] += fft.getBand(i);
    }

    for (int i = 0; i < group.length; i++) {
      group[i] /= groupSize;
    }
    return group;
  }


  public void render() {
    ellipseMode(RADIUS);
    fill(0);
    ellipse(this.x, this.y, radius, radius);
    noFill();
    fill(255);
    textSize(12);
    text("Out", this.x+this.offsetX, this.y);

    if (floatBuf != null) drawFFT();
  }
}
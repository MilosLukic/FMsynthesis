class Cell implements Serializable {
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

  public Cell(boolean empty, int leftTopX, int leftTopY, int segmentX, int segmentY ) {
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

  private void writeObject(ObjectOutputStream out) throws IOException {
    out.writeBoolean(empty);
    out.writeInt(leftTopX);
    out.writeInt(leftTopY);
    out.writeInt(segmentX);
    out.writeInt(segmentY);
    out.writeObject(oscillator);
    out.writeFloat(oscillatorSizeRelative);
    out.writeFloat(pointInX);
    out.writeFloat(pointInY);
    out.writeFloat(pointOutX);
    out.writeFloat(pointOutY);
    out.writeInt(connectorSize);
  }

  private void readObject(ObjectInputStream in) throws IOException, ClassNotFoundException {
    empty = in.readBoolean();
    leftTopX = in.readInt();
    leftTopY = in.readInt();
    segmentX = in.readInt();
    segmentY = in.readInt();
    oscillator = (Oscillator)in.readObject();
    oscillatorSizeRelative = in.readFloat();
    pointInX = in.readFloat();
    pointInY = in.readFloat();
    pointOutX = in.readFloat();
    pointOutY = in.readFloat();
    connectorSize = in.readInt();
  }

  public void initOscillator() {
    this.oscillator = new Oscillator(this);
    this.empty = false;
  }

  public void removeOscillator() {
    /* Remove oscillator form oscillators list */
    for (Oscillator osc : oscillators) {
      if (osc == this.oscillator) {
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

  public void moveOscillatorTo(Cell target) {
    if (this.empty || !target.empty) {
      return;
    }

    target.oscillator = this.oscillator;
    target.oscillator.container = target;
    this.oscillator = null;
    target.setEmpty(false);
    this.setEmpty(true);
  }

  public void setEmpty(boolean empty) {
    this.empty = empty;
  }

  public boolean isEmpty() {
    return this.oscillator == null;
  }

  public void editOscillator() {
    if (!this.isEmpty()) {
      editingOscillator = this.oscillator;
      showOscillatorEditor = true;
      frequencyTextField.setText(Integer.toString(this.oscillator.frequency));
      amplitudeTextField.setText(Float.toString(this.oscillator.amplitude));
      textFieldA.setText(Float.toString(this.oscillator.envelope.attack));
      textFieldD.setText(Float.toString(this.oscillator.envelope.decay));
      textFieldS.setText(Float.toString(this.oscillator.envelope.sustainAmplitude));
      textFieldR.setText(Float.toString(this.oscillator.envelope.release));
      dropdownSignalType.setStringValue(this.oscillator.type);
      dropdownSignalType.setLabel(this.oscillator.type);
      if (this.oscillator.envelope.decayQ)
        checkboxQ.deactivate(0);
      else
        checkboxQ.activate(0);
      frequencyTextField.show();
      amplitudeTextField.show();
      submitButton.show();
      envelopeLabel.show();
      frequencyLabel.show();
      amplitudeLabel.show();
      labelA.show();
      labelD.show();
      labelS.show();
      labelR.show();
      frequencyTextField.show();
      amplitudeTextField.show();
      textFieldA.show();
      textFieldD.show();
      textFieldS.show();
      textFieldR.show();
      dropdownSignalType.show();
      oscillatorLabel.show();
      signalTypeLabel.show();
      checkboxQ.show();
      labelQ.show();
    }
  }

  public void manageInput() {

    if (this.empty) {
      activeIn = null;
      activeOut = null;
      return;
    }

    float distanceIn = sqrt((this.pointInX - mouseX)*(this.pointInX - mouseX) + (this.pointInY - mouseY)*(this.pointInY - mouseY));
    float distanceOut = sqrt((this.pointOutX - mouseX)*(this.pointOutX - mouseX) + (this.pointOutY - mouseY)*(this.pointOutY - mouseY));

    if ( distanceIn < connectorSize) {
      if (activeOut != null && activeOut != this.oscillator) {
        activeOut.setOutOscillator(this.oscillator);
        activeIn = null;
        activeOut = null;
      } else if (activeIn == null) {
        activeIn = this.oscillator;
      }
    } else if (distanceOut < connectorSize) {
      if (activeIn != null && activeIn != this.oscillator) {
        this.oscillator.setOutOscillator(activeIn);
        this.oscillator.audioOut = null;
        activeIn = null;
        activeOut = null;
      } else if (activeOut == null) {
        activeOut = this.oscillator;
      }
    } else if (activeIn != null || activeOut != null) {
      activeIn = null;
      activeOut = null;
    } else if (mouseX > pointInX && mouseX < pointOutX && mouseY > leftTopY && mouseY < leftTopY + segmentY) {
      lockedOscillator = this.oscillator;
    }
  }

  public void drawCell() {
    fill(255);
    stroke(0, 0, 0, 50);
    rect(leftTopX, leftTopY, segmentX, segmentY);
    if (!this.empty)
      drawOscillator();
  }

  public void drawConnection() {
    stroke(0, 0, 0);
    noFill();
    if (this.oscillator != null && this.oscillator.outOscillator != null) {
      float outX = this.oscillator.outOscillator.container.pointInX;
      float outY = this.oscillator.outOscillator.container.pointInY;
      bezier(pointOutX, pointOutY, outX, pointOutY, pointOutX, outY, outX, outY);
    } else if (this.oscillator != null && this.oscillator.audioOut != null) {
      float outX = this.oscillator.audioOut.x;
      float outY = this.oscillator.audioOut.y;
      bezier(pointOutX, pointOutY, outX, pointOutY, pointOutX, outY, outX, outY);
    }
  }

  public void drawDynamicOut(float dynamicX, float dynamicY) {
    bezier(pointInX, pointInY, dynamicX, pointInY, pointInX, dynamicY, dynamicX, dynamicY);
  }

  public void drawDynamicIn(float dynamicX, float dynamicY) {
    bezier(dynamicX, dynamicY, pointOutX, dynamicY, dynamicX, pointOutY, pointOutX, pointOutY);
  }

  public void drawOscillator() {
    float referenceX = leftTopX;
    float referenceY = leftTopY;

    if (lockedOscillator == this.oscillator) {
      referenceX = mouseX - segmentX*oscillatorSizeRelative*0.5;
      referenceY = mouseY - segmentY*0.5;
    }

    textSize(10);
    fill(200);
    stroke(0);
    fill(100, 100, 100);
    rect(referenceX, referenceY, segmentX*oscillatorSizeRelative, segmentY, 20);
    fill(150, 24, 24);
    arc(referenceX, referenceY + segmentY*0.5, connectorSize, connectorSize, -HALF_PI, HALF_PI);
    arc(referenceX + segmentX*oscillatorSizeRelative, referenceY + segmentY*0.5, connectorSize, connectorSize, HALF_PI, PI+HALF_PI);

    textSize(13);
    fill(255, 255, 255);
    text("f", referenceX+segmentX*0.1, referenceY+segmentY*0.3); 
    text(this.oscillator.frequency, referenceX+segmentX*0.24, referenceY+segmentY*0.3); 
    text("A", referenceX+segmentX*0.1, referenceY+segmentY*0.6);
    text(this.oscillator.amplitude, referenceX+segmentX*0.24, referenceY+segmentY*0.6);
    text(this.oscillator.type, referenceX+segmentX*0.24, referenceY+segmentY*0.9);
  }
}

class Oscillator implements Serializable {
  boolean active = true;
  boolean hasAudioOut;
  int frequency = 440;
  float amplitude = 1f;
  String type = "Sine";
  Oscillator outOscillator = null;
  AudioOut audioOut = null;
  float pointOutX, pointOutY;
  Cell container = null;
  Envelope envelope;

  private void writeObject(ObjectOutputStream out) throws IOException {
    out.writeBoolean(active);
    out.writeInt(frequency);
    out.writeFloat(amplitude);
    out.writeUTF(type);
    out.writeObject(outOscillator);
    out.writeFloat(pointOutX);
    out.writeFloat(pointOutY);
    out.writeObject(container);
    if (this.audioOut != null)
      this.hasAudioOut = true;
    else
      this.hasAudioOut = false;
    out.writeBoolean(hasAudioOut);
  }

  private void readObject(ObjectInputStream in) throws IOException, ClassNotFoundException {
    active = in.readBoolean();
    frequency = in.readInt();
    amplitude = in.readFloat();
    type = in.readUTF();
    outOscillator = (Oscillator)in.readObject();
    pointOutX = in.readFloat();
    pointOutY = in.readFloat();
    container = (Cell)in.readObject();
    hasAudioOut = in.readBoolean();
  }

  public Oscillator(Cell container) {
    this.container = container;
    this.envelope = new Envelope();
  }

  public int getFrequency() {
    return this.frequency;
  }

  public float getAmplitude() {
    return this.amplitude;
  }
  public String getType() {
    return this.type;
  }

  public void setFrequency(int frequency) {
    int n = tone.getNote((float) frequency);
    System.out.println(n);
    this.frequency = (int) tone.getFrequency(n);
  }

  public void setAmplitude(float amplitude) {
    this.amplitude = amplitude;
  }

  public void setType(String type) {
    this.type = type;
  }

  public void setAudioOut(AudioOut aout) {
    this.audioOut = aout;
    float ampl = -1;
    Oscillator carrier = null;
    for (Oscillator o : oscillators) {
      if (o.audioOut != null && o.amplitude > ampl) {
        carrier = o;
        ampl = o.amplitude;
      }
    }
    int n = tone.getNote(carrier.frequency);
  }

  public void setOutOscillator(Oscillator outOscillator) {
    this.outOscillator = outOscillator;
  }

  public float calculateSample(float frequency, long time, int sampleRate, float value) {
    if (type == "Square")
      return (float) Math.signum(Math.sin((float)(2 * Math.PI * frequency * time / sampleRate + value)));
    else if (type == "Triangle")
      return (float) Math.asin(Math.sin((float)(2 * Math.PI * frequency * time / sampleRate + value)));
    else if (type == "Saw") {
      return 2*(time%(sampleRate/frequency))/(sampleRate/frequency)-1;
    } else
      return (float) Math.sin((float)(2 * Math.PI * frequency * time / sampleRate + value));
  }
}

class Envelope {
  float attack = 0.01;
  float decay = 5.4;
  boolean decayQ = true;

  float release = 0.2;
  float sustainAmplitude = 0.3;  


  public float coeff(long sample, int sampleRate, Note activeNote) {
    float lastAmplitude = 0.0;
    float time = sample/(float)sampleRate;

    if (time < attack) {
      lastAmplitude = time/attack;
      if (activeNote.lastAmplitude > lastAmplitude) {
        activeNote.time = (long) activeNote.lastAmplitude*sampleRate;
      }
    } else if ( time - attack < decay) {
      float relativeTime = time - attack;
      float share = relativeTime / decay;
      if (decayQ)
        lastAmplitude = (float) 1 - (1-sustainAmplitude) * (float)Math.sqrt(share);
      else
        lastAmplitude = (float) 1 - (1-sustainAmplitude) * share;
    } else {
      lastAmplitude =  sustainAmplitude;
    }
    return lastAmplitude;
  }

  public float release(long sample, int sampleRate, float lastAmplitude) {
    float ratio = sample/(float)sampleRate/release*lastAmplitude;
    if (ratio >= lastAmplitude)
      return 0f;
    else {
      return lastAmplitude - ratio;
    }
  }
}
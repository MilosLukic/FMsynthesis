
void setupOscillatorEditor(){
  editorWidth = width/4;
  editorHeight = height/4;
  PFont font = createFont("arial", 20);
 
  cp5 = new ControlP5(this);
 
  frequencyTextField = cp5.addTextfield("textInput_1")
    .setPosition(width/2-editorWidth/3,height/2-editorHeight/3)
      .setSize(editorWidth/3, editorHeight/6)
        .setFont(font)
          .setFocus(true)
            .setColor(color(0, 0, 0))
              .setText("jojo")
                .setAutoClear(false)
                  .setLabelVisible(false)
                    .setColorBackground(color(225, 225, 225))
                      .setLabel("");
                
   amplitudeTextField = cp5.addTextfield("textInput_2")
    .setPosition(width/2-editorWidth/3,height/2)
      .setSize(editorWidth/3, editorHeight/6)
        .setFont(font)
          .setFocus(false)
            .setColor(color(0, 0, 0))
              .setText("jojo")
                .setAutoClear(false)
                  .setColorBackground(color(225, 225, 225))
                    .setLabel("");

  
  frequencyTextField.hide();
  amplitudeTextField.hide();
  
              
  submitButton = cp5.addButton("apply")
     .setValue(0)
       .setPosition(width/2,height/2 +editorHeight/4)
         .setSize(3*editorWidth/8,editorHeight/10);
  
  submitButton.hide();
}

public void apply() {
  try{
      editingOscillator.setFrequency(Integer.parseInt(frequencyTextField.getText()));
      editingOscillator.setAmplitude(Float.parseFloat(amplitudeTextField.getText()));
      showOscillatorEditor = false;
      frequencyTextField.hide();
      amplitudeTextField.hide();
      submitButton.hide();
  }catch (Exception e){
      //TODO handle bad input
      println("Bad input, please write some code into catch exception thing");
  }

}
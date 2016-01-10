String[] dropdown = {"Sine", "Triangle", "Square", "Saw"};

void customizeDropdown(DropdownList ddl) {
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(20);
  ddl.setBarHeight(15);

  for (String s : dropdown){
    ddl.addItem(s, s);
  }
  
  //ddl.scroll(0);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isGroup()) {
    println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
  } 
  else if (theEvent.isController() && editingOscillator != null) {
    int index = (int)(theEvent.getController().getValue());
    editingOscillator.type = dropdown[index];
  }
}

void setupOscillatorEditor(){
  editorWidth = width/2;
  editorHeight = height/2;
  PFont font = createFont("arial", 20);
 
  cp5 = new ControlP5(this);
  
  dropdownSignalType = cp5.addDropdownList("Signal type")
          .setPosition(100, 100)
          ;
  
  customizeDropdown(dropdownSignalType);
  
  textFieldA = cp5.addTextfield("textInput_10")
    .setPosition(width/2 + editorWidth/20 + editorWidth/5 ,height/2-editorHeight/2+editorHeight/20 + 15*editorHeight/100)
      .setSize(editorWidth/5, editorHeight/12)
        .setFont(font)
          .setFocus(true)
            .setColor(color(0, 0, 0))
              .setText("jojo")
                .setAutoClear(false)
                  .setLabelVisible(false)
                    .setColorBackground(color(225, 225, 225))
                      .setLabel("");
  
    textFieldD = cp5.addTextfield("textInput_11")
    .setPosition(width/2 + editorWidth/20 + editorWidth/5 ,height/2-editorHeight/2+editorHeight/20 + 30*editorHeight/100)
      .setSize(editorWidth/5, editorHeight/12)
        .setFont(font)
          .setFocus(true)
            .setColor(color(0, 0, 0))
              .setText("jojo")
                .setAutoClear(false)
                  .setLabelVisible(false)
                    .setColorBackground(color(225, 225, 225))
                      .setLabel("");
 textFieldS = cp5.addTextfield("textInput_12")
    .setPosition(width/2 + editorWidth/20 + editorWidth/5 ,height/2-editorHeight/2+editorHeight/20 + 45*editorHeight/100)
      .setSize(editorWidth/5, editorHeight/12)
        .setFont(font)
          .setFocus(true)
            .setColor(color(0, 0, 0))
              .setText("jojo")
                .setAutoClear(false)
                  .setLabelVisible(false)
                    .setColorBackground(color(225, 225, 225))
                      .setLabel("");
                      
   textFieldR = cp5.addTextfield("textInput_13")
    .setPosition(width/2 + editorWidth/20 + editorWidth/5 ,height/2-editorHeight/2+editorHeight/20 + 60*editorHeight/100)
      .setSize(editorWidth/5, editorHeight/12)
        .setFont(font)
          .setFocus(true)
            .setColor(color(0, 0, 0))
              .setText("jojo")
                .setAutoClear(false)
                  .setLabelVisible(false)
                    .setColorBackground(color(225, 225, 225))
                      .setLabel("");                    
                      
  envelopeLabel = cp5.addTextlabel("label3")
                    .setText("Envelope")
                    .setPosition(width/2 + editorWidth/20,height/2-editorHeight/2+editorHeight/20)
                    .setColorValue(0x000000)
                    .setFont(createFont("Georgia",20))
                    ;
  
  labelA = cp5.addTextlabel("label4")
                    .setText("A")
                    .setPosition(width/2 + editorWidth/20,height/2-editorHeight/2+editorHeight/20 + 15*editorHeight/100)
                    .setColorValue(0x000000)
                    .setFont(createFont("Georgia",20))
                    ;
                    
  labelD = cp5.addTextlabel("label5")
                    .setText("D")
                    .setPosition(width/2 + editorWidth/20,height/2-editorHeight/2+editorHeight/20 + 30*editorHeight/100)
                    .setColorValue(0x000000)
                    .setFont(createFont("Georgia",20))
                    ;
 
  labelS = cp5.addTextlabel("label6")
                    .setText("S(Amp)")
                    .setPosition(width/2 + editorWidth/20,height/2-editorHeight/2+editorHeight/20 + 45*editorHeight/100)
                    .setColorValue(0x000000)
                    .setFont(createFont("Georgia",20))
                    ;
                    
  labelR = cp5.addTextlabel("label7")
                    .setText("R")
                    .setPosition(width/2 + editorWidth/20,height/2-editorHeight/2+editorHeight/20 + 60*editorHeight/100)
                    .setColorValue(0x000000)
                    .setFont(createFont("Georgia",20))
                    ;
                    
                    
  frequencyLabel = cp5.addTextlabel("label")
                    .setText("Frequency")
                    .setPosition(width/2-editorWidth/2 + editorWidth/20,height/2-editorHeight/2+editorHeight/20)
                    .setColorValue(0x000000)
                    .setFont(createFont("Georgia",20))
                    ;
                    
  amplitudeLabel = cp5.addTextlabel("label2")
                  .setText("Amplitude")
                  .setPosition(width/2-editorWidth/2 + editorWidth/20,height/2-editorHeight/2+editorHeight/5)
                  .setColorValue(0x000000)
                  .setFont(createFont("Georgia",20))
                  ;
 
  frequencyTextField = cp5.addTextfield("textInput_1")
    .setPosition(width/2-editorWidth/2 + editorWidth/20 + editorWidth/5 ,height/2-editorHeight/2+editorHeight/20)
      .setSize(editorWidth/5, editorHeight/12)
        .setFont(font)
          .setFocus(true)
            .setColor(color(0, 0, 0))
              .setText("jojo")
                .setAutoClear(false)
                  .setLabelVisible(false)
                    .setColorBackground(color(225, 225, 225))
                      .setLabel("");
                
   amplitudeTextField = cp5.addTextfield("textInput_2")
    .setPosition(width/2-editorWidth/2 + editorWidth/20 + editorWidth/5,height/2-editorHeight/2+editorHeight/5)
      .setSize(editorWidth/5, editorHeight/12)
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
       .setPosition(width/2 - 3*editorWidth/16,height/2 +editorHeight/3)
         .setSize(3*editorWidth/8,editorHeight/10);
  
  submitButton.hide();
  
    exportButton = cp5.addButton("Export")
     .setValue(0)
       .setPosition(4*width/6,ySegment/2)
         .setSize(3*editorWidth/8,editorHeight/10);
         
    importButton = cp5.addButton("Import")
     .setValue(0)
       .setPosition(5*width/6,ySegment/2)
         .setSize(3*editorWidth/8,editorHeight/10);
         
    envelopeLabel.hide();
    frequencyLabel.hide();
    amplitudeLabel.hide();
    labelA.hide(); 
    labelD.hide();
    labelS.hide();
    labelR.hide();
    frequencyTextField.hide();
    amplitudeTextField.hide();
    textFieldA.hide();
    textFieldD.hide();
    textFieldS.hide();
    textFieldR.hide();
  
}

public void apply() {
  if(!setupFinished) return;
  try{
      editingOscillator.setFrequency(Integer.parseInt(frequencyTextField.getText()));
      editingOscillator.setAmplitude(Float.parseFloat(amplitudeTextField.getText()));
      showOscillatorEditor = false;
      frequencyTextField.hide();
      amplitudeTextField.hide();
      submitButton.hide();
      envelopeLabel.hide();
      frequencyLabel.hide();
      amplitudeLabel.hide();
      labelA.hide(); 
      labelD.hide();
      labelS.hide();
      labelR.hide();
      frequencyTextField.hide();
      amplitudeTextField.hide();
      textFieldA.hide();
      textFieldD.hide();
      textFieldS.hide();
      textFieldR.hide();
  }catch (Exception e){
      //TODO handle bad input
      println("Bad input, please write some code into catch exception thing");
  }

}

public void Import(){
  if(!setupFinished) return;
  //selectInput("Select a file to process:", "fileSelected");
  //println(filePath);
  
  JFileChooser chooser = new JFileChooser();
  chooser.setFileSelectionMode(JFileChooser.FILES_ONLY);
  int returnVal = chooser.showOpenDialog(null);
  File selectedFile = null;
  if (returnVal == JFileChooser.APPROVE_OPTION) {
    selectedFile = chooser.getSelectedFile();
    System.out.println(selectedFile.getAbsolutePath());
  }
  
  List<Cell> readCase = new ArrayList<Cell>();

  ObjectInputStream objectinputstream = null;
  FileInputStream streamIn;
  try {
    streamIn = new FileInputStream(selectedFile.getAbsolutePath());
    objectinputstream = new ObjectInputStream(streamIn);
     

    
    readCase = (List<Cell>) objectinputstream.readObject();
    //List<Cell> recordList = new ArrayList<Cell>();
    //recordList.add(readCase);

   } catch (Exception e) {
        println("NEMA NISTA");
        e.printStackTrace();
   }finally {
        if(objectinputstream != null){
            try{objectinputstream .close();}catch (Exception e){println("NAPAAAKAAA");}
         } 
   }
  
  initializeCells();
  int c = 0; 
  for (int i = 0; i<cells.length; i++){
    for (int j = 0; j<cells[i].length; j++){
      if(!(readCase.get(c).isEmpty())){
        cells[i][j].empty = false;
        cells[i][j].oscillator = (readCase.get(c).oscillator);
        cells[i][j].oscillator.container = cells[i][j];
        if(readCase.get(c).oscillator.hasAudioOut){
          cells[i][j].oscillator.audioOut = audioOut;
        }
        
      }
      c++;
      
    }
  }
   
}





public void Export(){
  if(!setupFinished) return;
  
  selectOutput("Select a file to write to:", "fileSelected");



}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
      List<Cell> cellList = new ArrayList<Cell>();
  for(int i=0;i<ROWS;i++)
    for(int j=0;j<COLUMNS;j++)
        cellList.add(cells[i][j]);
  try{
    FileOutputStream fout = new FileOutputStream(selection.getAbsolutePath());
    ObjectOutputStream oos = new ObjectOutputStream(fout);
    oos.writeObject(cellList);
    fout.close();
    oos.close();
    println("MISLM DA SM NAREDU FAJL SE KR USPESNO");
  }catch (Exception e){
    e.printStackTrace();
  }
    println("User selected " + selection.getAbsolutePath());
  }
}public void export2(){}
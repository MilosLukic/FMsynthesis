
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
  
    exportButton = cp5.addButton("export2")
     .setValue(0)
       .setPosition(4*width/5,height/10 +editorHeight/4)
         .setSize(3*editorWidth/8,editorHeight/10);
         
    importButton = cp5.addButton("import2")
     .setValue(0)
       .setPosition(3*width/4,height/10)
         .setSize(3*editorWidth/8,editorHeight/10);
  
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
  }catch (Exception e){
      //TODO handle bad input
      println("Bad input, please write some code into catch exception thing");
  }

}

public void import2(){
  if(!setupFinished) return;
  //selectInput("Select a file to process:", "fileSelected");
  //println(filePath);
  List<Cell> readCase = new ArrayList<Cell>();

  ObjectInputStream objectinputstream = null;
  FileInputStream streamIn;
  try {
    streamIn = new FileInputStream("C:\\processing-3.0.1\\address.ser");
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
        if(readCase.get(c).oscillator.hasAudioOut){
          cells[i][j].oscillator.audioOut = audioOut;
        }
        
      }
      c++;
      
    }
  }
   
}

boolean fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    return false;
    
  } else {
    filePath = selection.getAbsolutePath();
    println(filePath);
    return true;
  }
}

public void export() {
  if(!setupFinished) return;
  String csvCells = "";
  String csvOscillators = "";
  for (int i = 0; i<ROWS; i++){
    for(int j = 0; j<COLUMNS; j++){
      Cell c = cells[i][j];
      String curr = "";
    }
  }
}

public void export2(){
  if(!setupFinished) return;
  List<Cell> cellList = new ArrayList<Cell>();
  for(int i=0;i<ROWS;i++)
    for(int j=0;j<COLUMNS;j++)
        cellList.add(cells[i][j]);
  try{
    FileOutputStream fout = new FileOutputStream("address.ser");
    ObjectOutputStream oos = new ObjectOutputStream(fout);
    oos.writeObject(cellList);
    fout.close();
    oos.close();
    println("MISLM DA SM NAREDU FAJL SE KR USPESNO");
  }catch (Exception e){
    e.printStackTrace();
  }

}
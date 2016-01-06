import java.util.*;
import controlP5.*;

public ControlP5 cp5;

public static int WIDTH = 1200;
public static int HEIGHT = 766;
public static int COLUMNS = 6;
public static int ROWS = 7;
public int HEADER_HEIGHT = 2;
public int FOOTER_HEIGHT = 1;
public float SIDE_MARGIN = 0.3f;
public int xSegment;
public int ySegment;
public Oscillator lockedOscillator = null;
public AudioOut audioOut;
public boolean showOscillatorEditor = false;
public Oscillator editingOscillator;
int editorWidth;
int editorHeight;
public String editingFrequency, editingAmplitude;
Textfield frequencyTextField, amplitudeTextField;
Button submitButton;
Renderer renderer;

Cell[][] cells = new Cell[ROWS][COLUMNS];
Oscillator activeOut = null;
Oscillator activeIn = null;


void setup(){
  size(1200, 766);
  initializeCells();
  renderer = new Renderer();
  setupOscillatorEditor();

}

void draw(){
  renderer.drawBackground();
  renderer.drawCells();
  renderer.drawOut();
  renderer.drawTitle();
  renderer.drawToolbar();
  renderer.drawOut();
  if (showOscillatorEditor) renderer.drawOscillatorEditor();
}

void initializeCells(){
  int sideMargin = (int) (SIDE_MARGIN*(WIDTH/COLUMNS));
  ySegment = (int) Math.round(HEIGHT/(ROWS+HEADER_HEIGHT + FOOTER_HEIGHT));
  xSegment = (int) Math.round((WIDTH-sideMargin*2)/COLUMNS);
    
  audioOut = new AudioOut();
  int leftTopY = HEADER_HEIGHT * ySegment;
  int leftTopX = sideMargin;
  System.out.println(sideMargin);
  
  for (int i = 0; i<cells.length; i++){
    leftTopX = sideMargin;
    for (int j = 0; j<cells[i].length; j++){
      cells[i][j] = new Cell(true, leftTopX, leftTopY, xSegment, ySegment);
      leftTopX = leftTopX + xSegment;
    }
    leftTopY += ySegment;
  }
}

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
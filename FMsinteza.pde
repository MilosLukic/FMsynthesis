import java.util.*;

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
Renderer renderer;

Cell[][] cells = new Cell[ROWS][COLUMNS];
Oscillator activeOut = null;
Oscillator activeIn = null;


void setup(){
  size(1200, 766);
  initializeCells();
  renderer = new Renderer();
}

void draw(){
  renderer.drawBackground();
  renderer.drawCells();
  renderer.drawOut();
  renderer.drawTitle();
  renderer.drawToolbar();
  renderer.drawOut();
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
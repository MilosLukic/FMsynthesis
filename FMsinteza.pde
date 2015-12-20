public static int WIDTH = 1200;
public static int HEIGHT = 766;
public static int COLUMNS = 6;
public static int ROWS = 7;
public int HEADER_HEIGHT = 2;
public int FOOTER_HEIGHT = 1;
public int xSegment;
public int ySegment;

Renderer renderer;

Cell[][] cells = new Cell[ROWS][COLUMNS];

void setup(){
  size(1200, 766);
  initializeCells();
  renderer = new Renderer();
}

void draw(){
  renderer.drawCells();
  renderer.drawOut();
  renderer.drawTitle();
  renderer.drawHelp();
}

void initializeCells(){
  ySegment = (int) Math.round(HEIGHT/(ROWS+HEADER_HEIGHT + FOOTER_HEIGHT));
  xSegment = (int) Math.round(WIDTH/COLUMNS);
    
  int leftTopY = HEADER_HEIGHT * ySegment;
  int leftTopX = 0;
  
  for (int i = 0; i<cells.length; i++){
    leftTopX = 0;
    for (int j = 0; j<cells[i].length; j++){
      cells[i][j] = new Cell(true, leftTopX, leftTopY, xSegment, ySegment);
      leftTopX = leftTopX + xSegment;
    }
    leftTopY += ySegment;
  }
}
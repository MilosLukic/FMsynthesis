public static int WIDTH = 1200;
public static int HEIGHT = 766;
public static int COLUMNS = 6;
public static int ROWS = 7;
Renderer renderer;

Cell[][] cells = new Cell[ROWS][COLUMNS];

void setup(){
  size(1200, 766);
  initializeCells();
  renderer = new Renderer();
}

void draw(){
  renderer.drawGrid();
  renderer.drawOut();
}

void initializeCells(){
  for (Cell[] row : cells){
    for (Cell c : row){
      c = new Cell(true);
    }
  }
}
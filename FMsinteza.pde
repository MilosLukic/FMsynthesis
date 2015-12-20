int WIDTH = 1200;
int HEIGHT = 766;

int COLUMNS = 10;
int ROWS = 10;

Cell[][] cells = new Cell[ROWS][COLUMNS];

void setup(){
  size(1200, 766);
  initializeCells();
}

void draw(){
  drawGrid();
}

void initializeCells(){
  for (Cell[] row : cells){
    for (Cell c : row){
      c = new Cell(true);
    }
  }
}
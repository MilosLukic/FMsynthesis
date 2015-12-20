int WIDTH = 1200;
int HEIGHT = 766;
int GRID_WIDTH = 10;
int GRID_HEIGHT = 10;

void setup(){
  size(1200, 766);
}

void draw(){
  drawGrid();
}

void drawGrid(){
  int ySegment = (int) Math.round(HEIGHT/GRID_HEIGHT);
  int xSegment = (int) Math.round(WIDTH/GRID_WIDTH);
  
  for(int j = 0; j<GRID_HEIGHT; j++){
    line(0, ySegment*j, width, ySegment*j);
  }  
  for(int i = 0; i<GRID_WIDTH; i++){
    line(xSegment*i, 0, xSegment*i, height);
  }
}
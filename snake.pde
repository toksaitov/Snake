class Snake {
  // State (vars)
  final int COLOUR = 0xFF395000;
  final int DEAD_COLOUR = 0xFF72A000;
  final int SCORE_SIZE = 40;
  final int SCORE_COLOUR = 0xFFB1D654;
  final int MESSAGE_SIZE = 50;
  final int MESSAGE_COLOUR = 0xFFB1D654;
  final int MARGIN_TOP = 160;

  Field field;
  int[] x;
  int[] y;
  int dx;
  int dy;
  int head;
  int length;
  boolean alive;
  int colour;
  int score;

  // Behaviour (method)
  Snake(Field field, int x, int y, int dx, int dy) {
    this.field = field;
    
    this.dx = dx;
    this.dy = dy;
    
    head = 0;
    length = 5;
    alive = true;
    
    this.x = new int[length];
    this.y = new int[length];
    for (int i = 0; i < length; i++) {
      this.x[i] = x;
      this.y[i] = y;
    }
    colour = COLOUR;
    
    score = 0;
  }
  
  boolean isColliding(int x, int y) {
    for (int i = 0; i < length; i++) {
      if (this.x[i] == x && this.y[i] == y) {
        return true;
      }
    }
    
    return false;
  }
  
  void turnUp() {
    if (dy != 1) {
      dx = 0;
      dy = -1;
    }
  }
  
  void turnDown() {
    if (dy != -1) {
      dx = 0;
      dy = 1;
    }
  }
  
  void turnLeft() {
    if (dx != 1) {
      dx = -1;
      dy = 0;
    }
  }
  
  void turnRight() {
    if (dx != -1) {
      dx = 1;
      dy = 0;
    }
  }
  
  void move() {
    if (!alive) return;
    
    int nextX = x[head] + dx;
    int nextY = y[head] + dy;
    if (field.areCoordsInside(nextX, nextY) && !isColliding(nextX, nextY)) {
      if (apple.isColliding(nextX, nextY)) {
        apple = new Apple();

        head = (head + 1) % length;
        int[] newX = new int[length + 1];
        int[] newY = new int[length + 1];
        for (int i = 0; i < head; i++) {
          newX[i] = x[i];
          newY[i] = y[i];
        }
        newX[head] = nextX;
        newY[head] = nextY;
        for (int i = head; i < length; i++) {
          newX[i + 1] = x[i];
          newY[i + 1] = y[i];
        }
        x = newX; //<>//
        y = newY;

        length++;
        score++;
      } else {
        head = (head + 1) % length;
        x[head] = nextX;
        y[head] = nextY;
      }
    } else {
      alive = false;
      colour = DEAD_COLOUR;
    }
  }
  
  void draw() {
    stroke(0);
    fill(colour);
    for (int i = 0; i < length; i++) {
      int pixelX = centeringShiftX + x[i] * cellPixelSize;
      int pixelY = centeringShiftY + y[i] * cellPixelSize;
      rect(pixelX, pixelY, cellPixelSize, cellPixelSize);
    }
    
    if (!alive) {
      fill(MESSAGE_COLOUR);
      textAlign(CENTER, CENTER);
      textSize(MESSAGE_SIZE);
      text("You lost...", width / 2, height - MARGIN_TOP);
    }
  }
  
  void drawScore() {
    fill(SCORE_COLOUR);
    textAlign(CENTER, CENTER);
    textSize(SCORE_SIZE);
    text("Score: " + score, width / 2, MARGIN_TOP);
  }
}

final int TITLE_SIZE = 60;
final int TITLE_COLOUR = 0xFFB1D654;
final int TITLE_MARGIN_TOP = 80;

Field field = new Field(20, 20);
Snake snake = new Snake(field, 0, 0, 0, 1);
Apple apple = new Apple();

void setup() {
  fullScreen();
  background(0);

  recalcDrawingSizes();
}

void draw() {
  background(0);
  
  switch (keyCode) {
    case UP:
      snake.turnUp();
      break;
    case DOWN:
      snake.turnDown();
      break;
    case LEFT:
      snake.turnLeft();
      break;
    case RIGHT:
      snake.turnRight();
      break;
  }
  
  snake.move();

  fill(TITLE_COLOUR);
  textAlign(CENTER, CENTER);
  textSize(TITLE_SIZE);
  text("Super Mega Snake", width / 2, TITLE_MARGIN_TOP);

  field.draw();
  apple.draw();
  snake.draw();
  snake.drawScore();
  
  delay(200);
}

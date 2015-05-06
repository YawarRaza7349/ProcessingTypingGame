TypingGame game;
int lastTime;

void setup()
{
  size(800, 600);
  game = new TypingGame("program.txt");
}

void draw()
{
  game.update(millis() - lastTime);
  lastTime = millis();
}

void keyPressed()
{
  game.keyPress(key, keyCode);
}

void keyReleased()
{
  game.keyRelease(key, keyCode);
}

import java.text.DecimalFormat;
import java.util.Arrays;

private class TypingGame
{
  private static final int ERROR = -1;
  private static final int START = 0;
  private static final int GAME = 1;
  private static final int END = 2;

  private String[] lines;
  private int gameState;
  private int currentLine;
  private TypingBox typingBox;
  private PFont font;
  private String indent;
  private boolean shift;
  private int milliseconds;
  private DecimalFormat floatFormatter;

  public TypingGame(String filename)
  {
    floatFormatter = new DecimalFormat("#0.000");
    readFile(filename);
    font = createFont("Consolas", 72, true);
  }

  private void readFile(String filename)
  {
    lines = loadStrings(filename);
    if (lines != null)
    {
      gameState = START;
      currentLine = 0;
      indent = "";
      typingBox = new TypingBox(indent);
    }
    else
    {
      gameState = ERROR;
    }
  }

  public void update(int msPassed)
  {
    switch(gameState)
    {
    case START:
      updateStart();
      break;
    case GAME:
      updateGame(msPassed);
      break;
    case END:
      updateEnd();
      break;
    case ERROR:
      updateError();
      break;
    default:
      break;
    }
  }

  private void updateStart()
  {
    float textSize;
    pushStyle();
    background(0, 255, 0);
    fill(0);
    textFont(font);
    textSize(textSize = 36);
    String message = "PRESS ENTER TO START";
    text(message, width/2 - textWidth(message)/2, height/2 - textSize/2);
    popStyle();
  }

  private void updateGame(int msPassed)
  {
    float textSize;
    float margin;
    milliseconds += msPassed;
    pushStyle();
    textFont(font);
    background(255);
    fill(0);
    textSize(textSize = 18);
    margin = 10;
    if (currentLine != 0)
    {
      text(lines[currentLine-1], margin, height/5 + textSize/2);
    }
    if (currentLine != lines.length - 1)
    {
      text(lines[currentLine+1], margin, 4*height/5 + textSize/2);
    }
    textSize(textSize = 24);
    text(lines[currentLine], margin, 2*height/5 + textSize/2);
    pushStyle();
    fill(255, 128, 0);
    text(typingBox.getTyped(), margin, 3*height/5 + textSize/2);
    popStyle();
    // inspired by http://stackoverflow.com/a/16812721
    char[] widthReference = new char[typingBox.getCursor()];
    Arrays.fill(widthReference, ' ');
    rect(10 + textWidth(new String(widthReference)), 3*height/5 - textSize/4, 3, textSize);
    textSize(textSize = 12);
    String time = "Time: " + floatFormatter.format(milliseconds/1000.0);
    text(time, width - textWidth(time) - margin, margin);
    popStyle();
  }

  private void updateEnd()
  {
    float textSize;
    pushStyle();
    textFont(font);
    background(0, 0, 255);
    fill(255);
    String message = "Total time: " + milliseconds/1000.0 + " seconds";
    textSize(textSize = 36);
    text(message, width/2 - textWidth(message)/2, height/2 + textSize/2);
    popStyle();
  }

  private void updateError()
  {
    float textSize;
    pushStyle();
    textFont(font);
    background(255, 0, 0);
    fill(255);
    String errorMessage = "ERROR: File could not be read.";
    textSize(textSize = 24);
    text(errorMessage, width/2 - textWidth(errorMessage)/2, height/2 + textSize/2);
    popStyle();
  }

  private void keyPress(char key, int keyCode)
  {
    switch(gameState)
    {
    case START:
      keyPressStart(key, keyCode);
      break;
    case GAME:
      keyPressGame(key, keyCode);
      break;
    case END:
      keyPressEnd(key, keyCode);
      break;
    default:
      break;
    }
  }

  private void keyPressStart(char key, int keyCode)
  {
    switch(key)
    {
    case ENTER:
      milliseconds = 0;
      gameState = GAME;
      break;
    default:
      break;
    }
  }

  private void keyPressGame(char key, int keyCode)
  {
    switch(key)
    {
    case CODED:
      switch(keyCode)
      {
      case LEFT:
        typingBox.moveCursor(-1);
        break;
      case RIGHT:
        typingBox.moveCursor(1);
        break;
      case SHIFT:
        shift = true;
        break;
      case java.awt.event.KeyEvent.VK_HOME:
        typingBox.cursorToHome();
        break;
      case java.awt.event.KeyEvent.VK_END:
        typingBox.cursorToEnd();
        break;
      default:
        break;
      }
      break;
    case ENTER:
    case RETURN:
      if (lines[currentLine].equals(typingBox.getTyped()) && typingBox.cursorAtEnd())
      {
        indent = "";
        while (typingBox.getTyped().startsWith(indent + " "))
        {
          indent += " ";
        }
        if (lines[currentLine].endsWith("{"))
        {
          indent += "  ";
        }
        ++currentLine;
        if (currentLine == lines.length)
        {
          gameState = END;
        }
        typingBox.resetBox(indent);
      }
      break;
    case TAB:
      if (!shift)
      {
        typingBox.insertTab();
      }
      else
      {
        typingBox.unindent();
      }
      break;
    case BACKSPACE:
      typingBox.backspace();
      break;
    case DELETE:
      typingBox.delete();
      break;
    default:
      typingBox.typeChar(key);
      if (typingBox.getTyped().trim().equals("}"))
      {
        typingBox.unindent();
      }
      break;
    }
  }

  private void keyPressEnd(char key, int keyCode)
  {
    switch(key)
    {
    case ENTER:
      currentLine = 0;
      indent = "";
      typingBox.resetBox(indent);
      gameState = START;
      break;
    default:
      break;
    }
  }

  public void keyRelease(char key, int keyCode)
  {
    switch(gameState)
    {
    case GAME:
      keyReleaseGame(key, keyCode);
      break;
    default:
      break;
    }
  }
  
  private void keyReleaseGame(char key, int keyCode)
  {
    switch(key)
    {
    case CODED:
      switch(keyCode)
      {
      case SHIFT:
        shift = false;
        break;
      default:
        break;
      }
    default:
      break;
    }
  }
}

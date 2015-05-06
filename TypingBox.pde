private class TypingBox
{
  private String typed;
  private int cursor;

  public TypingBox(String init)
  {
    resetBox(init);
  }

  public void resetBox(String init)
  {
    typed = init;
    cursor = init.length();
  }

  public String getTyped()
  {
    return typed;
  }

  public int getCursor()
  {
    return cursor;
  }

  public void typeChar(char c)
  {
    typed = typed.substring(0, cursor) + c + typed.substring(cursor);
    ++cursor;
  }

  public void insertTab()
  {
    typeChar(' ');
    typeChar(' ');
  }

  public void unindent()
  {
    if (typed.startsWith("  "))
    {
      typed = typed.substring(2);
      cursor = constrain(cursor - 2, 0, typed.length());
    }
  }

  public void backspace()
  {
    if (cursor != 0)
    {
      typed = typed.substring(0, cursor-1) + typed.substring(cursor);
      --cursor;
    }
  }
  
  public void delete()
  {
    if (cursor != typed.length())
    {
      typed = typed.substring(0, cursor) + typed.substring(cursor+1);
    }
  }
  
  public void moveCursor(int diff)
  {
    cursor = constrain(cursor + diff, 0, typed.length());
  }
  
  public void cursorToEnd()
  {
    cursor = typed.length();
  }
  
  public void cursorToHome()
  {
    cursor = 0;
  }

  public boolean cursorAtEnd()
  {
    return cursor == typed.length();
  }

  public boolean checkIndent()
  {
    return typed.substring(0, cursor).trim().equals("");
  }

  public boolean checkUnindent()
  {
    return typed.startsWith("  ");
  }
}

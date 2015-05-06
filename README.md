# ProcessingTypingGame
This is a game that measures how fast you can type out a computer program. When you start the game, it will show you a line of code, which you must type in correctly in order to move on. Then, it will iterate through all the lines in the input file. When you have typed in all the lines, you have won, and the game will tell you how much time you spent.

## Controls
You have a cursor that moves as you type, but you can also move the cursor yourself using the left and right arrow keys, as well as the Home and End keys. You can also press Backspace to remove the character before the cursor, and Delete to remove the character after the cursor. To move to the next line, make sure your input matches the given line and your cursor is at the end of the line, then press Enter/Return. The motivation for requiring the cursor at the end of the line is to replicate typing in a text editor (where pressing Enter/Return in the middle of a line would split the line in two where your cursor was).

As this game is oriented towards typing programs, it will automatically indent and unindent your code based on whether you just typed a left or right brace (signifying a code block). An indent corresponds to two spaces (like the Processing code editor), and if the Tab key is pressed, two spaces are inserted where the cursor is. If Shift-Tab is pressed and the line has at least two leading spaces, then two leading spaces will be removed.

## Limitations
This game is catered towards input programs written in curly-brace programming languages, using the coding convention where opening braces are placed either at the end of a line or on a line by themselves, and closing braces are placed either at the beginning of a line or on a line by themselves (although it also supports having blocks that are fully contained on a single line, such as array initializers). It also doesn't autoindent switch-statements properly.

I haven't tested this, but I anticipate the game won't work properly on Macs. The code interprets ASCII character 8 as "Backspace" (remove previous character) and ASCII character 127 as "Delete" (remove following character). However, the Delete key on Macs produces ASCII character 127, even though it is usually used like Backspace is on PCs. There also does not seem to be a character for producing ASCII character 8 on Macs.

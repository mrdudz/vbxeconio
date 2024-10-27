VBXE 80-column Conio replacement for cc65 Atari 8-bit target

Compile with the .o file and the library to use the VBXE overlay which will replace all conio library functions with VBXE versions.

cl65 -t atari vbxeconio.o <yourprog>.c -lib vbxeconio.lib -o <yourprog>.xex

If you want also to use the textcolor() function and set text colors, also include "vbxeconio.h" into your program after atari.h, which undefines the macros from atari.h and sets new ones.  You can also pass any value (0-7F) into textcolor to get that color from the VBXE default palette, instead of using the color constants. Background colors are not supported, since VBXE doesn't really support them (without palette tricks).

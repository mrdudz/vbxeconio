<h1>VBXE 80-column Conio replacement for cc65 Atari 8-bit target</h1>

<b>Overview</b>

A replacement conio implementation for VBXE 80-column.  When included with your program, the same conio functions will write to the VBXE 80-column mode. Most of the library code is compiled into the LOWCODE segment, as an implemented the VBXE banking window is at $4000-6000.  This can cause problems if the origin of your code is higher in memory and overlaps this area.  If you need a different VBXE banking window, you can change the source code and recompile the library.

<b>Compiling</b>

I've only included a Windows batch file to compile the library.  Run this and it will compile the library and the vbxeconio.o file needed.  If someone wants to contribute a proper Makefile for Linux based systems, please do!

<b>Usage</b>

Compile with the .o file and the library to use the VBXE overlay which will replace all conio library functions with VBXE versions.

cl65 -t atari vbxeconio.o yourprog.c -lib vbxeconio.lib -o yourprog.xex

If you want also to use the textcolor() function and set text colors, also include "vbxeconio.h" into your program after atari.h, which undefines the macros from atari.h and sets new ones.  You can also pass any value (0-7F) into textcolor to get that color from the VBXE default palette, instead of using the color constants. Background colors are not supported, since VBXE doesn't really support them (without palette tricks).

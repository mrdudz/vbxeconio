#ifndef VBXECONIO_H
#define VBXECONIO_H

/* Undefine some macros that get set in Atari.h> */
#undef _textcolor
#undef _bgcolor

#undef COLOR_BLACK
#undef COLOR_WHITE
#undef COLOR_RED
#undef COLOR_CYAN
#undef COLOR_PURPLE
#undef COLOR_GREEN
#undef COLOR_BLUE
#undef COLOR_YELLOW
#undef COLOR_ORANGE
#undef COLOR_BROWN
#undef COLOR_LIGHTRED
#undef COLOR_GRAY1
#undef COLOR_GRAY2
#undef COLOR_LIGHTGREEN
#undef COLOR_LIGHTBLUE
#undef COLOR_GRAY3

/* New color defines - NTSC*/
#define COLOR_BLACK             0x00
#define COLOR_WHITE             0x0F
#define COLOR_RED               0x33
#define COLOR_CYAN              0x74
#define COLOR_PURPLE            0x67
#define COLOR_GREEN             0x18
#define COLOR_BLUE              0x71
#define COLOR_YELLOW            0x2F
#define COLOR_ORANGE            0x38
#define COLOR_BROWN             0x25
#define COLOR_LIGHTRED          0x44
#define COLOR_GRAY1             0x0A
#define COLOR_GRAY2             0x06
#define COLOR_LIGHTGREEN        0x18
#define COLOR_LIGHTBLUE         0x73
#define COLOR_GRAY3             0x04


/* Extra functions */

/* Copy a custom font to VBXE memory to be used immediately. Font to be copied must not sit in the $4000-$6000
   area, which is used for the VBXE banking window.
*/
void __fastcall__ vbxeconio_copyfont(void *font);


#endif
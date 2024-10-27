@ECHO OFF
ca65 -t atari vbxe_clrscr.s
ca65 -t atari vbxe_cclear.s
ca65 -t atari vbxe_color.s
ca65 -t atari vbxe_copyfont.s
ca65 -t atari vbxe_cputc.s
ca65 -t atari vbxe_cputs.s
ca65 -t atari vbxe_chline.s
ca65 -t atari vbxe_cvline.s
ca65 -t atari vbxe_gotox.s
ca65 -t atari vbxe_gotoy.s
ca65 -t atari vbxe_gotoxy.s
ca65 -t atari vbxe_helpers.s
ca65 -t atari vbxe_revers.s
ca65 -t atari vbxe_cursor.s
ca65 -t atari vbxe_screensize.s
ca65 -t atari vbxe_wherex.s
ca65 -t atari vbxe_wherey.s
ca65 -t atari vbxeconio_init.s

ca65 -t atari vbxeconio.s

ar65 r vbxeconio.lib vbxe_clrscr.o
ar65 r vbxeconio.lib vbxe_cclear.o
ar65 r vbxeconio.lib vbxe_color.o
ar65 r vbxeconio.lib vbxe_copyfont.o
ar65 r vbxeconio.lib vbxe_cputc.o
ar65 r vbxeconio.lib vbxe_cputs.o
ar65 r vbxeconio.lib vbxe_chline.o
ar65 r vbxeconio.lib vbxe_cvline.o
ar65 r vbxeconio.lib vbxe_gotox.o
ar65 r vbxeconio.lib vbxe_gotoy.o
ar65 r vbxeconio.lib vbxe_gotoxy.o
ar65 r vbxeconio.lib vbxe_helpers.o
ar65 r vbxeconio.lib vbxe_revers.o
ar65 r vbxeconio.lib vbxe_cursor.o
ar65 r vbxeconio.lib vbxe_screensize.o
ar65 r vbxeconio.lib vbxe_wherex.o
ar65 r vbxeconio.lib vbxe_wherey.o
ar65 r vbxeconio.lib vbxeconio_init.o

move *.lib library

ca65 -t atari vbxeconio.s
move vbxeconio.o library


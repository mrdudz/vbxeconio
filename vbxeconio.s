;
; Shawn Jefferson  July 30, 2024
;
; import/overload stubs for the vbxe conio


; vbxe_clrscr.s
        .import vbxe_clrscr
        .export _clrscr := vbxe_clrscr

; vbxe_screensize.s
	.import vbxe_screensize
      	.export _screensize := vbxe_screensize	 	

; vbxe_gotox.s
	.import vbxe_gotox
	.export _gotox := vbxe_gotox

; vbxe_gotoy.s
	.import vbxe_gotoy
	.export _gotoy := vbxe_gotoy

; vbxe_gotoxy.s
	.import vbxe_gotoxy
	.export _gotoxy := vbxe_gotoxy

; vbxe_wherex.s
	.import vbxe_wherex
	.export _wherex := vbxe_wherex

; vbxe_wherey.s
	.import vbxe_wherey
	.export _wherey := vbxe_wherey

; vbxe_cputc.s
        .import vbxe_cputc
        .import vbxe_cputcxy
        .export _cputc := vbxe_cputc
        .export _cputcxy := vbxe_cputcxy

; vbxe_cputs.s
	.import vbxe_cputs
	.import vbxe_cputsxy
	.export _cputs := vbxe_cputs
	.export _cputsxy := vbxe_cputsxy

; vbxe_color.s
        .import vbxe_set_textcolor
        .import vbxe_set_bgcolor
        .export _textcolor := vbxe_set_textcolor
        .export _bgcolor := vbxe_set_bgcolor

; vbxe_chline.s
	.import vbxe_chline
	.import vbxe_chlinexy
	.export _chline := vbxe_chline
	.export _chlinexy := vbxe_chlinexy

; vbxe_cvline.s
	.import vbxe_cvline
	.import vbxe_cvlinexy
	.export _cvline := vbxe_cvline
	.export _cvlinexy := vbxe_cvlinexy

; vbxe_cclear.s
	.import vbxe_cclear
	.import	vbxe_cclearxy
	.export _cclear := vbxe_cclear
	.export _cclearxy := vbxe_cclearxy

; vbxe_revers.s
	.import vbxe_reverse
	.export _revers := vbxe_reverse

; vbxe_cursor.s
	.import vbxe_cursor
	.export _cursor := vbxe_cursor




;char cpeekc (void);
;unsigned char cpeekcolor (void);
;unsigned char cpeekrevers (void);
;void __fastcall__ cpeeks (char* s, unsigned int length);

;void __fastcall__ cputhex8 (unsigned char val);
;void __fastcall__ cputhex16 (unsigned val);
        
        ; vbxe_cpeekc.s
        ;.import vbxe_cpeekc
        ;.export _cpeekc := vbxe_cpeekc                ; cpeekc.s

        ; vbxe_cpeekcolor.s
        ;.import vbxe_cpeekcolor
        ;.export _cpeekcolor := vbxe_cpeekcolor        ; cpeekcolor.s

        ; vbxe_cpeekrevers.s
        ;.import vbxe_cpeekrevers
        ;.export _cpeekrevers := vbxe_cpeekrevers      ; cpeekrevers.s

        ; vbxe_cpeeks.s
        ;.import vbxe_cpeeks
        ;.export _cpeeks := vbxe_cpeeks                ; cpeeks.s


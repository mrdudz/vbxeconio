;
; Shawn Jefferson  July 30, 2024
;
; VBXE wherex

        .include "vbxeconio.inc"
        .importzp vbxe_x
        
        .export vbxe_wherex


vbxe_wherex:
	lda vbxe_x
	ldx #$0
	rts
	
;
; Shawn Jefferson  July 30, 2024
;
; VBXE wherey

        .include "vbxeconio.inc"
        .importzp vbxe_y
        
        .export vbxe_wherey


vbxe_wherey:
	lda vbxe_y
	ldx #$0
	rts
	
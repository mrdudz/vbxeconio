;
; Shawn Jefferson  July 30, 2024
;
; VBXE revers

        .include "vbxeconio.inc"
        .importzp vbxe_revers
        
        .export vbxe_reverse


vbxe_reverse:
	tax			; remember reverse setting
	lda vbxe_revers		; grab old setting
	pha			; save old setting
	stx vbxe_revers		; store new setting
	ldx #$0			; high byte of return
	pla			; return old setting
	rts
	
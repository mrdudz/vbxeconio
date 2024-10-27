;
; Shawn Jefferson  July 30, 2024
;
; VBXE color

        .include "vbxeconio.inc"
	.import popa, tmp1

        .importzp vbxe_textcolor, vbxe_bgcolor        
        .export vbxe_set_textcolor, vbxe_set_bgcolor


vbxe_set_textcolor:
	and #$7F				; clip off bgcolor bits if they were passed in
	ldx vbxe_textcolor
	sta vbxe_textcolor
	txa
	rts

; currently doesn't chang the bg color, since you don't have proper control over the BG color on VBXE without a custom palette
vbxe_set_bgcolor:
	lda #0				; return old bgcolor ($#0)
	rts
	
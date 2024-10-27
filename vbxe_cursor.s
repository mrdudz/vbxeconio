;
; Shawn Jefferson  July 30, 2024
;
; VBXE cursor

        .include "vbxeconio.inc"
        .importzp tmp1
        .importzp vbxe_curs
        .import toggle_cursor
        
        .export vbxe_cursor


	.segment	"LOWCODE"

vbxe_cursor:
	sta tmp1		; save A for later
	cmp vbxe_curs		; same as old setting?
	beq @1			; just exit if so
	
	lda vbxe_curs		; load old setting
	pha			; save for later
	lda tmp1		; restore what we wanted to set
	sta vbxe_curs		; save new setting
	jsr toggle_cursor	; set the cursor at current screen position
	pla			; restore old setting into A reg
	
@1:	ldx #$0			; set X for high value
	rts

;
; Shawn Jefferson  July 30, 2024
;
; VBXE gotox

        .include "vbxeconio.inc"
        .import test_cursor_state
        .importzp vbxe_x, vbxe_curs
        
        .export vbxe_gotox


	.segment	"LOWCODE"

vbxe_gotox:
	pha			; push A onto stack for now
	
	;lda vbxe_curs		; deal with cursor
	;cmp #$1			; cursor on?
	;bne @1			; nope	
	;jsr toggle_cursor	; turn cursor off at current position

	jsr test_cursor_state	; deal with cursor

@1:	pla
	sta vbxe_x
	
	jsr test_cursor_state	; deal with cursor
	rts
	
;
; Shawn Jefferson  July 30, 2024
;
; VBXE gotoy

        .include "vbxeconio.inc"
        .import test_cursor_state
        .importzp vbxe_y, vbxe_curs
             
        .export vbxe_gotoy


	.segment	"LOWCODE"

vbxe_gotoy:
	pha			; push A onto stack for now
	
	;lda vbxe_curs		; deal with cursor
	;cmp #$1			; cursor on?
	;bne @1			; nope	
	;jsr toggle_cursor	; turn cursor off at current position
	
	jsr test_cursor_state	; deal with cursor
	
@1:	pla			; pull A back	
	sta vbxe_y

	jsr test_cursor_state	; deal with cursor
	rts
	
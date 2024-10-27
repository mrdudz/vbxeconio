;
; Shawn Jefferson  July 30, 2024
;
; VBXE gotox

        .include "vbxeconio.inc"
	.import popa
        .import test_cursor_state
        .importzp vbxe_x, vbxe_y, vbxe_curs
        
        .export vbxe_gotoxy
        

	.segment	"LOWCODE"

vbxe_gotoxy:
	pha			; push y coord onto stack for now
	jsr popa		; pop x coord off C stack
	pha			; push x coord onto stack for now
	
	;lda vbxe_curs		; deal with cursor
	;cmp #$1			; cursor on?
	;bne @1			; nope	
	;jsr toggle_cursor	; turn cursor off at current position

	jsr test_cursor_state	; deal with cursor

@1:	pla			; pull x coord off stack
	sta vbxe_x		
	pla			; pull y coord off stack
	sta vbxe_y

	jsr test_cursor_state	; deal with cursor
	rts

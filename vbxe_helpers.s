;
; Shawn Jefferson  July 30, 2024
;
; VBXE Conio helpers

	.include "vbxeconio.inc"

	.export		vbxe_getxy_address, vbxe_get_address
	.export		inc_screenx, inc_screeny, toggle_cursor, test_cursor_state

        .importzp       ptr1
 	.import 	vrow_lookup_hi, vrow_lookup_lo 
 	.importzp	vbxe_regs, vbxe_x, vbxe_y, vbxe_ptr, vbxe_textcolor, vbxe_curs
 


	.segment	"CODE"

; calculate the vbxe screen address and store in ptr1 (destroys all regs)
 vbxe_getxy_address:			; entry point to get xy location for address lookup
  	ldx	vbxe_x
 	ldy	vbxe_y
 vbxe_get_address:			; entry point for arbitrary address lookup (pass x and y in X and Y regs)	
	lda	vrow_lookup_lo,y
	sta	vbxe_ptr
	lda	vrow_lookup_hi,y
	sta	vbxe_ptr+1

	txa				; transfer x value to a reg     
	asl				; multiply it by two
	clc
	adc vbxe_ptr			; add to screen address point
	bcc @1
	inc vbxe_ptr+1			; increment high byte since we overflowed
@1:	sta vbxe_ptr			; store x value
	rts

; increment screen x coord, moving cursor as necessary, if cursor moves beyond screen, wrap around (destroys X and Y reg)
inc_screenx:
	ldx vbxe_x
	inx
	cpx #SCRSIZE_X
	bne @1
	ldx #0
	jsr inc_screeny

@1:	stx vbxe_x	
	rts
			
inc_screeny:
	ldy vbxe_y
	iny
	cpy #SCRSIZE_Y
	bne @1
	ldy #0

@1:	sty vbxe_y
	rts


	.segment	"LOWCODE"

toggle_cursor:
	vbxebank VBXE_SCRBANK
	jsr vbxe_getxy_address	; 
	ldy #0			; offset to screen pointer
	lda (vbxe_ptr),y	; get the char at screen xy position
	eor #$80		; flip reverse video bit of char
	sta (vbxe_ptr),y	; write character back
	iny
	lda vbxe_textcolor	; make sure the textcolor is set!
	sta (vbxe_ptr),y
	vbxebank VBXE_BANKOFF
	rts	

test_cursor_state:
	lda vbxe_curs		; deal with cursor
	cmp #$1			; cursor on?
	bne @1			; nope	
	jsr toggle_cursor	; turn cursor off at current position

@1:	rts

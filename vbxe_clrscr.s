;
; Shawn Jefferson  July 30, 2024
;
; VBXE Conio clrscr

        .include "vbxeconio.inc"
               
        .importzp ptr2
        .importzp vbxe_regs, vbxe_x, vbxe_y
        
        .export	vbxe_clrscr	
 
 
	.segment "LOWCODE"			; need to be in LOWCODE due to banking window

vbxe_clrscr:
; bank in the VBXE memory
	vbxebank VBXE_SCRBANK

; clear VBXE bank 1 which holds the screen
	lda #VBXEBANK_LO	; low byte of VBXE bank memory location (always $0)
	ldx #VBXEBANK_HI	; high byte of VBXE bank memory location ($4000 usually)
	sta ptr2
	stx ptr2+1
	ldy #$0
@1:
	sta (ptr2),y		; A should be $0 here already
	iny
	bne @1
	inx				; high value still in X
	cpx #(VBXEBANK_HI + $10)	; clear 4k		
	beq clrdone			; cleared 4k now?
	stx ptr2+1			; store it back to ZP	
	jmp @1				; clear another 256 bytes
clrdone:
; reset cursor position to top left
	lda #$0	
	sta vbxe_x
	sta vbxe_y
	
; bank out the VBXE memory
	vbxebank VBXE_BANKOFF
	rts


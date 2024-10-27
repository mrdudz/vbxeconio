;
; Shawn Jefferson  July 30, 2024
;
; VBXE Conio clrscr

        .include "vbxeconio.inc"
        .include "atari.inc"
        
        .import vbxe_getxy_address, inc_screenx, inc_screeny, test_cursor_state
       
        .import popa
        .importzp ptr1, tmp4
        .importzp vbxe_regs, vbxe_ptr, vbxe_x, vbxe_y, vbxe_textcolor, vbxe_bgcolor, vbxe_revers, vbxe_curs
 
        .export	vbxe_cputc, vbxe_cputcxy, cputc_screencode
 
 
        
	.segment "LOWCODE"			; need to be in LOWCODE due to banking window

vbxe_cputcxy:
	pha					; push char onto stack for later
	
	;lda vbxe_curs				; handle cursor
	;cmp #$1					; is cursor on?
	;bne @1
	;jsr toggle_cursor			; turn the cursor off at old location
	jsr test_cursor_state			; deal with cursor if on
	
	
@1:	jsr popa				; grab X and Y from C stack
	sta vbxe_y
	jsr popa
	sta vbxe_x
	pla					; bring char back from stack (cputc expects it in A)

vbxe_cputc:
	sta tmp4				; save C for later
; process newline, carriage return	
	cmp #$0D				; Carriage return
	beq cr
	cmp #$0A				; newline
	beq nl
	cmp #ATEOL				; atari end of line
	beq nl

; following code stolen from Atari cputc.s
	lda tmp4				; get the char back
						; FIXME: need to take into account revers() state
        asl a               			; shift out the inverse bit
        adc #$c0            			; grab the inverse bit; convert ATASCII to screen code
        bpl codeok          			; screen code ok?
        eor #$40            			; needs correction
codeok: lsr a               			; undo the shift
        bcc @1
        eor #$80            			; restore the inverse bit

@1:	ldx vbxe_revers				; reverse video on?
	cpx #$1
	bne cputc_screencode
	ora #$80				; set the reverse bit

cputc_screencode:
	pha					; push our character onto stack temporarily
	vbxebank VBXE_SCRBANK			; bank in the screen memory
	jsr vbxe_getxy_address			; get the screen address in vbxe_ptr1		
	pla					; get our character back

@2:	ldy #0		
	sta (vbxe_ptr),y			; write char into screen memory
	
	; need to do some stuff with bgcolor/fgcolor
	lda vbxe_textcolor			; not going to support bgcolor, no need to do anything else here
	iny
	sta (vbxe_ptr),y			; write char attribute (color)
	jsr inc_screenx				; increment the cursor
	
	;lda vbxe_curs				; handle cursor
	;cmp #$1					; cursor on?
	;bne exit				; cursor is off, do nothing
	;jsr toggle_cursor			; toggle the reverse bit in next screen location to show cursor (turns off VBXE BANK!)
	
	jsr test_cursor_state			; deal with cursor if on
	jmp exit

nl:	jsr inc_screeny				; increment the screen y
	jmp exit				; for some reason conio doesn't set X to 0 on a newline <shrug>	

cr:	lda #$0					; return to 0 for x, stay on this line
	sta vbxe_x				
		
exit:	vbxebank VBXE_BANKOFF			; turn VBXE bank off, even if we didn't bank it in
	rts
	

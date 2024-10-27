;
; Shawn Jefferson  July 30, 2024
;
; VBXE copyfont


       	.include "vbxeconio.inc"
        .importzp ptr1, ptr2, ptr3
        .importzp vbxe_regs
             
        .export _vbxeconio_copyfont, vbxe_copyfont


	.segment	"LOWCODE"

; Function to copy font into VBXE memory, will be callable from C, font address in AX (font cannot be in $4000-$6000 range!)
_vbxeconio_copyfont:
	pha				; save the font address for later
	txa
	pha			
	vbxebank VBXE_XDLBANK		; overwrites A and Y registers
	pla				; pull font address back into AX
	tax
	pla

vbxe_copyfont:				; entry point for calling within init
	sta ptr1			; font data in main memory passed in AX, XDL bank already in
	stx ptr1+1

	lda #$0				; font location in VBXE bank 0 ($4800)
	ldx #(VBXEFONT_HI)	
	sta ptr2
	stx ptr2+1	
	ldx #(VBXEFONT_HI + $04)		; start of inverse characters (char code 128-256)
	sta ptr3				; A is still $0
	stx ptr3+1
	
	ldy #$0
@1:
	lda (ptr1),y
	sta (ptr2),y			; regular character
	eor #$FF			; reverse the character bits	
	sta (ptr3),y			; inverse character	
	iny
	bne @1				; have we coped a page?
	inc ptr1+1			
	inc ptr3+1		
	inc ptr2+1
	lda ptr2+1			; load ptr2 to cmp
	cmp #(VBXEFONT_HI + $04)	;$48+$4	  font data is $400 (1024) bytes long
	beq copydone			; completely done, copied 1024 bytes?
	bne @1				; copy next page
copydone:
	vbxebank VBXE_BANKOFF		; turn VBXE bank off
	rts
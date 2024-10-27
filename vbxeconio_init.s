;
; Shawn Jefferson  July 30, 2024
;
; VBXE Conio constructors/destructors

	.include "vbxeconio.inc"
	.include "atari.inc"

        .constructor    vbxeconio_init, 8
        .destructor     vbxeconio_shutdown

	.import		vbxe_copyfont
        .importzp       ptr1, ptr2, ptr3

	.exportzp	vbxe_regs, vbxe_ptr, vbxe_x, vbxe_y, vbxe_curs, vbxe_textcolor, vbxe_revers
	.export		vrow_lookup_hi, vrow_lookup_lo


	.segment "ZEROPAGE"			; 9 bytes in zeropage

vbxe_regs:		.res	2		; pointer to vbxe registers
vbxe_ptr:		.res	2		; general use pointer for vbxe functions (into regs and screen)
vbxe_x:			.res	1		; x coord on vbxe screen
vbxe_y:			.res 	1		; y coord on vbxe screen
vbxe_curs:		.res	1		; cursor status (1 for on)
vbxe_revers:		.res	1		; reverse character status (1 for on)
vbxe_textcolor:		.res	1		; current textcolor
;vbxe_bgcolor:		.res	1		; bgcolor not used/available


	.segment "BSS"

sdmctl_save:		.res	1


	.segment "LOWCODE"		; 48 byte screen address lookup table for row address in LOWCODE

vrow_lookup_hi: 	.byte	$41, $42, $43, $43, $44, $45, $45, $46, $46, $47, $48, $48, $49, $4A, $4A, $4B, $4B, $4C, $4D, $4D, $4E, $4F, $4F, $50
vrow_lookup_lo: 	.byte	$E0, $80, $20, $C0, $60, $00, $A0, $40, $E0, $80, $20, $C0, $60, $00, $A0, $40, $E0, $80, $20, $C0, $60, $00, $A0, $40


	.segment "STARTUP"

;VBXE REQUIRED text in internal screen codes
missing_text:		.byte	54, 34, 56, 37, 0, 50, 37, 49, 53, 41, 50, 37, 36
.define MISSING_TEXT_LEN 	13

; VBXE XDL for text mode
vbxe_xdl:			.word	XDLC_TMON+XDLC_RPTL+XDLC_OVADR+XDLC_CHBASE+XDLC_OVATT+XDLC_END			
				.byte 	215			; repeat 215 lines
				.byte	$00			; screen memory address start
				.byte	$20			; $002000
				.byte	$00
				.byte	160			; default step for text mode
				.byte	0
				.byte	1			; CHBAS at $800
				.byte	1			; Normal playfield
				.byte	255			; default priority
				
.define VBXE_XDL_LEN		11


	.segment "STARTUP"

vbxe_detect:
	ldx #$D6        	; try $D640 first
	ldy #$40
	lda #0
	sta $D640
	lda $D640
	cmp #$10        	; $10 = FX core
	beq fxcore
	inx             	; try $D740
	sta $D740
	lda $D740
	cmp #$10        	; $10 = FX core
	beq fxcore

	lda #0
	ldx #0          	; no fx core
	rts

fxcore: tya             	; move low byte into a
	rts

vbxe_missing_text:
	lda SAVMSC		; save screen address into ptr1
	sta ptr1
	lda SAVMSC+1
	sta ptr1+1
	ldy #$0
	ldx #MISSING_TEXT_LEN
missing_loop:
	lda missing_text,y
	sta (ptr1),y
	iny
	dex
	bne missing_loop
	
lockup:	jmp lockup


; these functions need to be in LOWCODE segment to avoid VBXE banking window ($4000-6000)
		.segment	"LOWCODE"

; bank needs to already be banked in via vbxeregs, clears $4000 - $5FFF
clear_bank:
	lda #VBXEBANK_LO
	ldx #VBXEBANK_HI
	sta ptr2
	stx ptr2+1
	ldy #$0
zeroloop:
	sta (ptr2),y		; A should be $0 here
	iny
	bne zeroloop
	inx			; high value still in X
	stx ptr2+1		; store it back to ZP
	cpx #(VBXEBANK_HI + $20)			
	beq zerodone		; at $60 now?
	bne zeroloop		; clear another 256 bytes
zerodone:		
	rts


; VBXE Conio Constructor, initialize VBXE
vbxeconio_init:
	jsr vbxe_detect
	sta vbxe_regs
	stx vbxe_regs+1
	bne have_vbxe
	jsr vbxe_missing_text
have_vbxe:
	lda SDMCTL		; save original SDMCTL value
	sta sdmctl_save	
	lda #$0
	sta SDMCTL		; turn off normal screen
; turn off VBXE screen processing
	vbxeregwrite VIDEO_CONTROL,$0
; setup VBXE banking
	vbxeregwrite MEMAC_CONTROL,$49			; bank at $4000, CPU enable, 8k bank

; bank in the VBXE screen memory for clearing
	vbxebank VBXE_SCRBANK
	jsr clear_bank
	vbxebank VBXE_XDLBANK
	jsr clear_bank

; copy the XDL and font data to VBXE bank 0
	;vbxebank VBXE_XDLBANK				// already banked in
	
	lda #<vbxe_xdl
	sta ptr2
	lda #>vbxe_xdl
	sta ptr2+1
	lda #VBXEBANK_LO
	sta ptr3
	lda #VBXEBANK_HI
	sta ptr3+1
	
	ldy #$0
	ldx #VBXE_XDL_LEN
xdl_loop:
	lda (ptr2),y
	sta (ptr3),y
	iny
	dex
	bne xdl_loop

; copy the system font to vbxe memory
	lda #$00
	ldx #$E0		; default font data location on Atari
	jsr vbxe_copyfont	; turns off the vbxe memory banking

; tell VBXE where the XDL starts ($000000)
	ldy #XDL_ADR0
	lda #$00
	sta (vbxe_regs),y		; XDL_ADR0
	iny
	sta (vbxe_regs),y		; XDL_ADR1
	iny
	sta (vbxe_regs),y		; XDL_ADR2

; turn on XDL processing
	vbxeregwrite VIDEO_CONTROL, $01

; set initial cursor position and state
	lda #$0
	sta vbxe_x
	sta vbxe_y
	sta vbxe_curs
	sta vbxe_revers
	;sta vbxe_bgcolor
	
	lda #INITIAL_TEXTCOLOR		; set initial textcolor
	sta vbxe_textcolor

; turn off VBXE memory bank
	;vbxebank VBXE_BANKOFF		; vbxe bank is already off
	rts	


; Conio Destructor, tursn off VBXE and restores the screen, doesn't need to be in LOWCODE
	.segment "CODE"

vbxeconio_shutdown:
	vbxebank VBXE_BANKOFF
	vbxeregwrite VIDEO_CONTROL, $0

	lda sdmctl_save
	sta SDMCTL
	rts

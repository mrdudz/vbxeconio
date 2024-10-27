;
; Shawn Jefferson  July 30, 2024
;
; internal constants for VBXE conio


; Misc defines
.define SCRSIZE_X 		80		; vbxe screen size
.define SCRSIZE_Y		24
.define INITIAL_TEXTCOLOR  	$0F		; white

; VBXE banking
.define VBXEBANK	$4000		; vbxe memory bank location
.define VBXEBANK_HI  	$40		; high byte of VBXE bank widnow	
.define VBXEFONT_HI	$48		; high byte of font location in VBXE memory
.define VBXEBANK_LO 	$00		; vbxe bank always starts at low byte of $0
.define VBXE_SCRBANK 	$82		; bank 1 is screen bank (using 2k banks)
.define VBXE_XDLBANK 	$80		; bank 0 has XDL and font
.define VBXE_BANKOFF 	$00		; turn VBXE banking off

; VBXE register struct
; define some aliases for read register names
.define CORE_VERSION        VIDEO_CONTROL
.define MINOR_VERSION       XDL_ADR0
.define COLDETECT           COLCLR
.define BLT_COLLISION_CODE  BL_ADR0
.define BLITTER_BUSY        BLITTER_START
.define IRQ_STATUS          IRQ_CONTROL

; VBXE_REGS offsets
.define	VIDEO_CONTROL	0
.define XDL_ADR0	1
.define	XDL_ADR1	2
.define XDL_ADR2	3
.define	CSEL		4
.define PSEL		5
.define COLRED		6
.define COLGREEN	7
.define	COLBLUE		8
.define	COLMASK		9
.define	COLCLR		10
.define	BL_ADR0		16
.define	BL_ADR1		17
.define	BL_ADR2		18
.define	BLITTER_START	19
.define	IRQ_CONTROL	20
.define	P0		21
.define	P1		22
.define	P2		23
.define	P3		24
.define	MEMAC_B_CONTROL 29
.define	MEMAC_CONTROL   30
.define	MEMAC_BANK_SEL	31

; XDCL values
.define XDLC_TMON       $0001
.define XDLC_GMON       $0002
.define XDLC_OVOFF      $0004
.define XDLC_MAPON      $0008
.define XDLC_MAPOFF     $0010
.define XDLC_RPTL       $0020
.define XDLC_OVADR      $0040
.define XDLC_OVSCRL     $0080
.define XDLC_CHBASE     $0100
.define XDLC_MAPADR     $0200
.define XDLC_MAPPAR     $0400
.define XDLC_OVATT      $0800
.define XDLC_HR         $1000
.define XDLC_LR         $2000
;$4000 is reserved
.define XDLC_END        $8000

;.define XDLC 		XDLC_TMON+XDLC_RPTL+XDLC_OVADR+XDLC_CHBASE+XDLC_OVATT+XDLC_END
;.define XDLC 		$8961


; Macros for accessing vbxe registers
.macro	vbxebank	_bank			;  (uses Y and A, requires importzp of vbxe_regs)
	ldy #MEMAC_BANK_SEL
	lda #_bank
	sta (vbxe_regs),y
.endmacro

.macro vbxeregwrite 	reg, value		; (uses Y and A, requires importzp of vbxe_regs)
	ldy #reg
	lda #value
	sta (vbxe_regs),y
.endmacro


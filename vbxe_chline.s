; Shawn Jefferson August 19, 2024 based on cc65 written by
; Ullrich von Bassewitz, 08.08.1998
;
; void chlinexy (unsigned char x, unsigned char y, unsigned char length);
; void chline (unsigned char length);
;

   	.include	"atari.inc"
   
   	.export         vbxe_chlinexy, vbxe_chline
        .import         vbxe_gotoxy, vbxe_cputc, cputc_screencode
        .import		popa
        .importzp       tmp1


CHRCODE =       $12 + 64


	.segment	"LOWCODE"

; using tmp1 here as cputc doesn't use it
vbxe_chlinexy:
        pha                     	; Save the length
        jsr	popa			; pop Y into A for gotoxy
        jsr     vbxe_gotoxy     	; Call this one, will pop params
        pla                     	; Restore the length

vbxe_chline:
        cmp     #0              	; Is the length zero?
        beq     L9              	; Jump if done
        sta     tmp1
L1:     lda     #CHRCODE        	; Horizontal line, ATASCII code
        jsr     cputc_screencode	; Direct output
        dec     tmp1
        bne     L1
L9:     rts

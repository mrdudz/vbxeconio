;
; Ullrich von Bassewitz, 08.08.1998
;
; void cclearxy (unsigned char x, unsigned char y, unsigned char length);
; void cclear (unsigned char length);
;

        .export         vbxe_cclearxy, vbxe_cclear
        .import         vbxe_gotoxy, vbxe_cputc
        .import		popa
        .importzp       tmp1


	.segment	"LOWCODE"

vbxe_cclearxy:
        pha                     	; Save the length
        jsr	popa			; pop y for next call
        jsr     vbxe_gotoxy     	; Call this one, will pop params
        pla                     	; Restore the length and run into _cclear

vbxe_cclear:
        cmp     #0              	; Is the length zero?
        beq     L9              	; Jump if done
        sta     tmp1
L1:     lda     #32             	; Blank - atascii code
        jsr     vbxe_cputc      	; Direct output
        dec     tmp1
        bne     L1
L9:     rts





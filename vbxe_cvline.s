;
; Ullrich von Bassewitz, 08.08.1998
;
; void cvlinexy (unsigned char x, unsigned char y, unsigned char length);
; void cvline (unsigned char length);
;
        .include "atari.inc"

        .export         vbxe_cvlinexy, vbxe_cvline
        .import         vbxe_gotoxy, vbxe_cputc, cputc_screencode, vbxe_cursor, toggle_cursor
        .importzp	vbxe_x, vbxe_y, vbxe_curs
        .import		popa
        .importzp       tmp1, tmp2, tmp3

CHRCODE =       $7C             ; Vertical bar


	.segment	"LOWCODE"

vbxe_cvlinexy:
        pha                     	; Save the length
        jsr	popa			; pop y into A for next call
        jsr     vbxe_gotoxy     	; Call this one, will pop params
        
        lda vbxe_curs			
        sta tmp3			; save cursor state
        lda #0
        jsr vbxe_cursor			; turn off cursor for the vertical line
        
        pla                     	; Restore the length and run into _cvline

vbxe_cvline:
        cmp     #0              	; Is the length zero?
        beq     @2              	; Jump if done
        sta     tmp1
        lda	vbxe_y		
        sta	tmp2
@1:     lda     vbxe_x			; save both x and y
        pha
        lda     #CHRCODE        	; Vertical bar
        jsr     cputc_screencode      	; Write, increments x and y
        pla
        sta     vbxe_x			; restore old x value
        lda	tmp2			; restore old y value	
       	inc	tmp2			; increment y
        sta     vbxe_y			; store it back
        dec     tmp1
        bne     @1

	lda tmp3			; get saved cursor state
	beq @2				; if it wasn't on, just exit
	sta vbxe_curs			; restore cursor state
	jsr toggle_cursor		; deal with cursor again

@2:     rts

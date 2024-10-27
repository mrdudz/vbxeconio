; Shawn Jefferson  August 19, 2024 based on cc65 Conio library code by
; Ullrich von Bassewitz, 06.08.1998
;
; void cputsxy (unsigned char x, unsigned char y, const char* s);
; void cputs (const char* s);
;

        .export         vbxe_cputsxy, vbxe_cputs
        .import         vbxe_gotoxy, vbxe_cputc
        .import		popa
        .importzp       ptr3, tmp2


	.segment	"LOWCODE"

vbxe_cputsxy:
        sta     ptr3         	; Save s for later
        stx     ptr3+1
        jsr 	popa		; pop y value, as gotoxy expects it in A
        jsr     vbxe_gotoxy     ; Set cursor, pop x and y
        jmp     L0              ; Same as cputs...

vbxe_cputs:
	sta     ptr3            ; Save s
        stx     ptr3+1
L0:     ldy     #0
L1:     lda     (ptr3),y
        beq     L9              ; Jump if done
        iny
        sty     tmp2            ; Save offset
        jsr     vbxe_cputc      ; Output char, advance cursor
        ldy     tmp2         	; Get offset
        bne     L1              ; Next char
        inc     ptr3+1          ; Bump high byte
        bne     L1

; Done

L9:     rts



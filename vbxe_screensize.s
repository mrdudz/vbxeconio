;
; Shawn Jefferson  July 30, 2024
;
; VBXE Conio screensize

        .include "vbxeconio.inc"
        
        .export vbxe_screensize
        .importzp ptr1, ptr2
        .import popptr1
 
  
vbxe_screensize:
	sta ptr2
	stx ptr2+1
        jsr popptr1         ; Get the x pointer into ptr1
	
	ldy #0
	lda #SCRSIZE_X
	sta (ptr1),y
	
	lda #SCRSIZE_Y
	sta (ptr2),y
	rts

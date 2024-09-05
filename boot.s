.CODE16

.GLOBAL _start

_start:
	CLI
	LJMP $0x0, $MAIN

MAIN:
	XOR %AX, %AX
	MOV %AX, %DS
	MOV %AX, %FS
	MOV %AX, %GS
	MOV %AX, %SS
	MOVW $0x9C00, %SP

	MOVW $0x0013, %AX
	INT $0x10

	MOV $0x027D, %AX
	MOV $0x0002, %CX
	MOV $0xA000, %BX
	MOV %BX, %ES
	XOR %DH, %DH
	XOR %BX, %BX
	INT $0x13
.LOOP:
	JMP .LOOP


.FILL 0x1EB-(.-_start), 0x01, 0x00
.ASCIZ "im gonna touch you"
.WORD 0xAA55

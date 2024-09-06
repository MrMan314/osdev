.CODE16

.GLOBAL _start

_start:
	JMP MAIN
	NOP

DISK_LABEL: .ASCII "FREAKOS "
BPS: .WORD 512
SPC: .BYTE 1
RFB: .WORD 1
FAT_COUNT: .BYTE 2
ROOT_ENTRIES: .WORD 224
SECTOR_COUNT: .WORD 2880
MEDIUM_BYTE: .BYTE 0xF0
SPF: .WORD 9
SPT: .WORD 18
SIDES: .WORD 2
HIDDEN: .INT 0
LARGE: .INT 0
DRV_NUM: .WORD 0
SIG: .BYTE 41
VOL_ID: .INT 0
VOL_LABEL: .ASCII "FREAKOS    "
FS: .ASCII "FAT12   "

MAIN:
	XOR %AX, %AX
	MOV %AX, %DS
	MOV %AX, %ES
	MOV %AX, %FS
	MOV %AX, %GS
	MOV %AX, %SS
	MOVW $0x9C00, %SP

	MOVW $0x0013, %AX
	INT $0x10

	MOV $HELLO, %SI
	CALL PRINT

	XOR %AX, %AX
	MOV %AX, %DS
	CLD

	MOV $0x0210, %AX
	MOV $0x0002, %CX
	XOR %DH, %DH
	XOR %BX, %BX
	MOV %BX, %ES
	MOV $0x1000, %BX
	INT $0x13
	JC .ERR

	LJMP $0x0, $0x1000

	JC .ERR2
PRINT:
	PUSHA
PRINTSTART:
	XORB %BH, %BH
	MOVB $0x0F, %BL
	MOVB $0x0E, %AH
	LODSB
	OR %AL, %AL
	JZ PRINTDONE
	INT $0x10
	JMP PRINTSTART
PRINTDONE:
	POPA
	RET

.ERR2:
	MOV $ERR2, %SI
	CALL PRINT
	JMP .LOOP
.ERR:
	MOV $ERR, %SI
	CALL PRINT
.LOOP:
	JMP .LOOP


BD: .WORD 0x0000
HELLO: .ASCIZ "hello vro\r\n"
ERR: .ASCIZ "help vro\r\n"
ERR2: .ASCIZ "VRO HELP ME\r\n"
.FILL 510-(.-_start), 0x01, 0x00
.WORD 0xAA55

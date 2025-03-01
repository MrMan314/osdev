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

GDT_START:

GDT_NULL:
	.WORD 0x0000
	.WORD 0x0000
	.BYTE 0x00
	.BYTE 0x00
	.BYTE 0x00
	.BYTE 0x00
GDT_CODE:
	.WORD 0xFFFF
	.WORD 0x0000
	.BYTE 0x00
	.BYTE 0x9A
	.BYTE 0xCF
	.BYTE 0x00
GDT_DATA:
	.WORD 0xFFFF
	.WORD 0x0000
	.BYTE 0x00
	.BYTE 0x92
	.BYTE 0xCF
	.BYTE 0x00

GDT_END:

GDTR:
	SIZE: .WORD GDT_END - GDT_START - 1
	OFFSET: .LONG GDT_START

.EQU GDT_CS, GDT_CODE - GDT_START
.EQU GDT_DS, GDT_DATA - GDT_START

MAIN:
	XOR %AX, %AX
	MOV %AX, %DS
	MOV %AX, %ES
	MOV %AX, %FS
	MOV %AX, %GS
	MOV %AX, %SS
	MOVW $0x9C00, %SP

	MOV $HELLO, %SI
	CALL PRINT

	MOV $0x0220, %AX
	MOV $0x0002, %CX
	XOR %DH, %DH
	MOV $0x1000, %BX
	INT $0x13
	JC .ERR

	INB $0x70, %AL
	OR $0x80, %AL
	OUTB %AL, $0x70
	INB $0x71, %AL

	INB $0x92, %AL
	OR $2, %AL
	OUTB %AL, $0x92

	CLI
	LGDT (GDTR)
	MOV %CR0, %EAX
	OR $1, %AL
	MOV %EAX, %CR0
	LJMP $GDT_CS, $PM_MAIN

	JMP .ERR2

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

.CODE32
PM_MAIN:
	MOV $0x112345, %EDI
	MOV $0x012345, %ESI
	MOV %ESI, (%ESI)
	MOV %EDI, (%EDI)
	CMPSL
	POPA
	JNE .HELLO
	JMP PM_LOOP
.HELLO:
	MOV $0x0F690F68, %EAX
	MOV $0xB8000, %EBX
	MOV %EAX, (%EBX)
	MOV $GDT_DS, %AX
	MOV %AX, %DS
	MOV %AX, %ES
	MOV %AX, %FS
	MOV %AX, %GS
	MOV %AX, %SS
	MOV $0x3000, %ESP
	LJMP $GDT_CS, $0x1000

PM_LOOP:
	JMP PM_LOOP

BD: .WORD 0x0000
HELLO: .ASCIZ "hello vro\r\n"
FOUND: .ASCIZ "i found the os!!!11\r\n"
ERR: .ASCIZ "help vro\r\n"
ERR2: .ASCIZ "VRO HELP ME\r\n"
.FILL 510-(.-_start), 0x01, 0x00
.WORD 0xAA55

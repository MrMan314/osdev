.CODE32
.GLOBL NL
.GLOBL PRINT
.GLOBL PRINT_HEX_8
.GLOBL PRINT_HEX_16
.GLOBL PRINT_HEX_32

PRINT:
	PUSH %EAX
	MOV %CH, %AH
	PRINT_LOOP:
	LODSB
	OR %AL, %AL
	JZ PRINT_DONE
	STOSW
	JMP PRINT_LOOP
	PRINT_DONE:
	POP %EAX
	RET

PRINT_HEX_32:
	PUSH %EAX
	SHR $16, %EAX
	AND $0xFFFF, %EAX
	CALL PRINT_HEX_16
	MOV (%ESP), %EAX
	AND $0xFFFF, %EAX
	CALL PRINT_HEX_16
	POP %EAX
	RET

PRINT_HEX_16:
	PUSH %EAX
	SHR $8, %EAX
	AND $0xFF, %EAX
	CALL PRINT_HEX_8
	MOV (%ESP), %EAX
	AND $0xFF, %EAX
	CALL PRINT_HEX_8
	POP %EAX
	RET

PRINT_HEX_8:
	PUSH %EBX
	PUSH %EAX
	SHR $4, %EAX
	AND $0x0F, %EAX
	MOV $HEX, %EBX
	ADD %EAX, %EBX
	MOV (%EBX), %AL
	MOV %CH, %AH
	STOSW
	MOV (%ESP), %EAX
	AND $0x0F, %EAX
	MOV $HEX, %EBX
	ADD %EAX, %EBX
	MOV (%EBX), %AL
	MOV %CH, %AH
	STOSW
	POP %EAX
	POP %EBX
	RET

NL:
	PUSH %EAX
	PUSH %EBX
	PUSH %EDX
	SUB $0xB8000, %EDI
	MOV %EDI, %EAX
	XOR %EDX, %EDX
	MOV $160, %EBX
	DIV %EBX
	INC %EAX
	MOV $160, %EBX
	MUL %EBX
	MOV %EAX, %EDI
	ADD $0xB8000, %EDI
	POP %EDX
	POP %EBX
	POP %EAX
	RET

.SECTION .rodata
HEX: .ASCII "0123456789ABCDEF"

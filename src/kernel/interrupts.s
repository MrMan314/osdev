.CODE32
.GLOBL ISR_HANDLER
.GLOBL IRQ_HANDLER
ISR_HANDLER:
	MOV 40(%ESP), %ECX
	MOV $0x0A000A00, %EAX

	PUSH %ECX
	AND $0xF0, %ECX
	SHR $4, %ECX

	MOV $HEX, %EBX
	ADD %ECX, %EBX
	MOV (%EBX), %CL
	AND $0xFF, %ECX
	OR %ECX, %EAX
	POP %ECX

	AND $0x0F, %ECX

	MOV $HEX, %EBX
	ADD %ECX, %EBX
	MOV (%EBX), %CL
	AND $0xFF, %ECX
	SHL $16, %ECX
	OR %ECX, %EAX

	MOV $0xB8000, %EBX
	MOV %EAX, (%EBX)
	RET

IRQ_HANDLER:
	MOV 40(%ESP), %ECX
	MOV $0x0A000A00, %EAX

	PUSH %ECX
	AND $0xF0, %ECX
	SHR $4, %ECX

	MOV $HEX, %EBX
	ADD %ECX, %EBX
	MOV (%EBX), %CL
	AND $0xFF, %ECX
	OR %ECX, %EAX
	POP %ECX

	AND $0x0F, %ECX

	MOV $HEX, %EBX
	ADD %ECX, %EBX
	MOV (%EBX), %CL
	AND $0xFF, %ECX
	SHL $16, %ECX
	OR %ECX, %EAX

	MOV $0xB8000, %EBX
	MOV %EAX, (%EBX)

	MOV 40(%ESP), %ECX
	CMP $0x1, %CL
	JNE .CONT

	IN $0x60, %AL

	.CONT:
	MOV $0x20, %AL
	OUT %AL, $0x20
	RET

HEX: .ASCIZ "0123456789ABCDEF"

.SECTION .rodata
EXCEPTIONS:
	.LONG ISR0
	.LONG ISR1
	.LONG ISR2
	.LONG ISR3
	.LONG ISR4
	.LONG ISR5
	.LONG ISR6
	.LONG ISR7
	.LONG ISR8
	.LONG ISR9
	.LONG ISR10
	.LONG ISR11
	.LONG ISR12
	.LONG ISR13
	.LONG ISR14
	.LONG ISR15
	.LONG ISR16
	.LONG ISR17
	.LONG ISR18
	.LONG ISR19
	.LONG ISR20
	.LONG ISR21
	.LONG ISR22
	.LONG ISR23
	.LONG ISR24
	.LONG ISR25
	.LONG ISR26
	.LONG ISR27
	.LONG ISR28
	.LONG ISR29
	.LONG ISR30
	.LONG ISR31
ISR0: .ASCIZ "zero division"
ISR1: .ASCIZ "debug"
ISR2: .ASCIZ "nmi"
ISR3: .ASCIZ "breakpoint"
ISR4: .ASCIZ "into detected overflow"
ISR5: .ASCIZ "out of bounds"
ISR6: .ASCIZ "invalid opcode"
ISR7: .ASCIZ "no coprocessor"
ISR8: .ASCIZ "double fault"
ISR9: .ASCIZ "coprocessor segment overrun"
ISR10: .ASCIZ "bad tss"
ISR11: .ASCIZ "segment not present"
ISR12: .ASCIZ "stack fault"
ISR13: .ASCIZ "general protection fault"
ISR14: .ASCIZ "page fault"
ISR15: .ASCIZ "unknown interrupt"
ISR16: .ASCIZ "coprocessor fault"
ISR17: .ASCIZ "alignment check"
ISR18: .ASCIZ "machine check"
ISR19: .ASCIZ "reserved"
ISR20: .ASCIZ "reserved"
ISR21: .ASCIZ "reserved"
ISR22: .ASCIZ "reserved"
ISR23: .ASCIZ "reserved"
ISR24: .ASCIZ "reserved"
ISR25: .ASCIZ "reserved"
ISR26: .ASCIZ "reserved"
ISR27: .ASCIZ "reserved"
ISR28: .ASCIZ "reserved"
ISR29: .ASCIZ "reserved"
ISR30: .ASCIZ "reserved"
ISR31: .ASCIZ "reserved"


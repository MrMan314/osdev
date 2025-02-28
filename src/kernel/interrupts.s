.CODE32
.GLOBL ISR_HANDLER
.GLOBL IRQ_HANDLER
.GLOBL IRQ_DONE
.EXTERN PRINT
.EXTERN PRINT_HEX_8
.EXTERN KBD
ISR_HANDLER:
	MOV 40(%ESP), %EAX
	MOV $0xB8000, %EDI
	MOV $0x0C, %CH
	CALL PRINT_HEX_8

	SHL $2, %EAX

	LEA EXCEPTIONS, %EBX
	ADD %EAX, %EBX
	MOV (%EBX), %ESI

	MOV $0xB8006, %EDI
	MOV $0x0C, %CH

	CALL PRINT

	RET

IRQ_HANDLER:
	MOV 40(%ESP), %EAX
	MOV $0xB8000, %EDI
	MOV $0x0A, %CH
	CALL PRINT_HEX_8

	AND $0x0F, %EAX
	SHL $2, %EAX
	MOV $IRQ_TABLE, %EBX
	ADD %EAX, %EBX
	PUSH (%EBX)
	RET

IRQ_TABLE:
	IRQ0: .LONG IRQ_DONE
	IRQ1: .LONG KBD
	IRQ2: .LONG IRQ_DONE
	IRQ3: .LONG IRQ_DONE
	IRQ4: .LONG IRQ_DONE
	IRQ5: .LONG IRQ_DONE
	IRQ6: .LONG IRQ_DONE
	IRQ7: .LONG IRQ_DONE
	IRQ8: .LONG IRQ_DONE
	IRQ9: .LONG IRQ_DONE
	IRQ10: .LONG IRQ_DONE
	IRQ11: .LONG IRQ_DONE
	IRQ12: .LONG MOUSE
	IRQ13: .LONG IRQ_DONE
	IRQ14: .LONG IRQ_DONE
	IRQ15: .LONG IRQ_DONE

MOUSE:
	IN $0x60, %AL
	JMP IRQ_DONE

IRQ_DONE:
	MOV $0x20, %AL
	OUT %AL, $0x20
	MOV 40(%ESP), %EAX
	CMP $0x8, %EAX
	JB IRQ_RET
	OUT %AL, $0xA0
IRQ_RET:
	RET

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


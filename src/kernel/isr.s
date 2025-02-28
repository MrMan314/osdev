.CODE32
.GLOBAL ISR_BEGIN
.EXTERN ISR_HANDLER
ISR_BEGIN:
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
	.LONG IRQ0
	.LONG IRQ1
	.LONG IRQ2
	.LONG IRQ3
	.LONG IRQ4
	.LONG IRQ5
	.LONG IRQ6
	.LONG IRQ7
	.LONG IRQ8
	.LONG IRQ9
	.LONG IRQ10
	.LONG IRQ11
	.LONG IRQ12
	.LONG IRQ13
	.LONG IRQ14
	.LONG IRQ15
ISR0:
	CLI
	PUSHL $0
	PUSHL $0
	JMP ISR_COMMON_STUB
ISR1:
	CLI
	PUSHL $0
	PUSHL $1
	JMP ISR_COMMON_STUB
ISR2:
	CLI
	PUSHL $0
	PUSHL $2
	JMP ISR_COMMON_STUB
ISR3:
	CLI
	PUSHL $0
	PUSHL $3
	JMP ISR_COMMON_STUB
ISR4:
	CLI
	PUSHL $0
	PUSHL $4
	JMP ISR_COMMON_STUB
ISR5:
	CLI
	PUSHL $0
	PUSHL $5
	JMP ISR_COMMON_STUB
ISR6:
	CLI
	PUSHL $0
	PUSHL $6
	JMP ISR_COMMON_STUB
ISR7:
	CLI
	PUSHL $0
	PUSHL $7
	JMP ISR_COMMON_STUB
ISR8:
	CLI
	NOP
	NOP
	PUSHL $8
	JMP ISR_COMMON_STUB
ISR9:
	CLI
	PUSHL $0
	PUSHL $9
	JMP ISR_COMMON_STUB
ISR10:
	CLI
	NOP
	NOP
	PUSHL $10
	JMP ISR_COMMON_STUB
ISR11:
	CLI
	NOP
	NOP
	PUSHL $11
	JMP ISR_COMMON_STUB
ISR12:
	CLI
	NOP
	NOP
	PUSHL $12
	JMP ISR_COMMON_STUB
ISR13:
	CLI
	NOP
	NOP
	PUSHL $13
	JMP ISR_COMMON_STUB
ISR14:
	CLI
	NOP
	NOP
	PUSHL $14
	JMP ISR_COMMON_STUB
ISR15:
	CLI
	PUSHL $0
	PUSHL $15
	JMP ISR_COMMON_STUB
ISR16:
	CLI
	PUSHL $0
	PUSHL $16
	JMP ISR_COMMON_STUB
ISR17:
	CLI
	PUSHL $0
	PUSHL $17
	JMP ISR_COMMON_STUB
ISR18:
	CLI
	PUSHL $0
	PUSHL $18
	JMP ISR_COMMON_STUB
ISR19:
	CLI
	PUSHL $0
	PUSHL $19
	JMP ISR_COMMON_STUB
ISR20:
	CLI
	PUSHL $0
	PUSHL $20
	JMP ISR_COMMON_STUB
ISR21:
	CLI
	PUSHL $0
	PUSHL $21
	JMP ISR_COMMON_STUB
ISR22:
	CLI
	PUSHL $0
	PUSHL $22
	JMP ISR_COMMON_STUB
ISR23:
	CLI
	PUSHL $0
	PUSHL $23
	JMP ISR_COMMON_STUB
ISR24:
	CLI
	PUSHL $0
	PUSHL $24
	JMP ISR_COMMON_STUB
ISR25:
	CLI
	PUSHL $0
	PUSHL $25
	JMP ISR_COMMON_STUB
ISR26:
	CLI
	PUSHL $0
	PUSHL $26
	JMP ISR_COMMON_STUB
ISR27:
	CLI
	PUSHL $0
	PUSHL $27
	JMP ISR_COMMON_STUB
ISR28:
	CLI
	PUSHL $0
	PUSHL $28
	JMP ISR_COMMON_STUB
ISR29:
	CLI
	PUSHL $0
	PUSHL $29
	JMP ISR_COMMON_STUB
ISR30:
	CLI
	PUSHL $0
	PUSHL $30
	JMP ISR_COMMON_STUB
ISR31:
	CLI
	PUSHL $0
	PUSHL $31
	JMP ISR_COMMON_STUB
IRQ0:
	CLI
	PUSHL $0
	PUSHL $0
	JMP IRQ_COMMON_STUB
IRQ1:
	CLI
	PUSHL $0
	PUSHL $1
	JMP IRQ_COMMON_STUB
IRQ2:
	CLI
	PUSHL $0
	PUSHL $2
	JMP IRQ_COMMON_STUB
IRQ3:
	CLI
	PUSHL $0
	PUSHL $3
	JMP IRQ_COMMON_STUB
IRQ4:
	CLI
	PUSHL $0
	PUSHL $4
	JMP IRQ_COMMON_STUB
IRQ5:
	CLI
	PUSHL $0
	PUSHL $5
	JMP IRQ_COMMON_STUB
IRQ6:
	CLI
	PUSHL $0
	PUSHL $6
	JMP IRQ_COMMON_STUB
IRQ7:
	CLI
	PUSHL $0
	PUSHL $7
	JMP IRQ_COMMON_STUB
IRQ8:
	CLI
	PUSHL $0
	PUSHL $8
	JMP IRQ_COMMON_STUB
IRQ9:
	CLI
	PUSHL $0
	PUSHL $9
	JMP IRQ_COMMON_STUB
IRQ10:
	CLI
	PUSHL $0
	PUSHL $10
	JMP IRQ_COMMON_STUB
IRQ11:
	CLI
	PUSHL $0
	PUSHL $11
	JMP IRQ_COMMON_STUB
IRQ12:
	CLI
	PUSHL $0
	PUSHL $12
	JMP IRQ_COMMON_STUB
IRQ13:
	CLI
	PUSHL $0
	PUSHL $13
	JMP IRQ_COMMON_STUB
IRQ14:
	CLI
	PUSHL $0
	PUSHL $14
	JMP IRQ_COMMON_STUB
IRQ15:
	CLI
	PUSHL $0
	PUSHL $15
	JMP IRQ_COMMON_STUB

IRQ_COMMON_STUB:
	PUSHAL
	MOV %DS, %AX
	PUSH %EAX
	MOV $0x10, %AX
	MOV %AX, %DS
	MOV %AX, %ES
	MOV %AX, %FS
	MOV %AX, %GS
	
	CALL IRQ_HANDLER

	POP %EAX
	MOV %AX, %DS
	MOV %AX, %ES
	MOV %AX, %FS
	MOV %AX, %GS
	POPAL
	ADD $8, %ESP
	STI
	IRET

ISR_COMMON_STUB:
	PUSHAL
	MOV %DS, %AX
	PUSH %EAX
	MOV $0x10, %AX
	MOV %AX, %DS
	MOV %AX, %ES
	MOV %AX, %FS
	MOV %AX, %GS
	
	CALL ISR_HANDLER

	POP %EAX
	MOV %AX, %DS
	MOV %AX, %ES
	MOV %AX, %FS
	MOV %AX, %GS
	POPAL
	ADD $8, %ESP
	STI
	IRET


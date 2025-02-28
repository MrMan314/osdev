print(".CODE32\n.GLOBAL ISR_BEGIN\n.EXTERN ISR_HANDLER\nISR_BEGIN:")

for i in range(32):
	print(f"ISR{i}:\n\tCLI\n\t{"NOP\n\tNOP" if i in [8, 10, 11, 12, 13, 14] else "PUSHL $0"}\n\tPUSHL ${i}\n\tJMP ISR_COMMON_STUB\n\t.LONG 0\n\t.WORD 0")

print("""ISR_COMMON_STUB:
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
""")

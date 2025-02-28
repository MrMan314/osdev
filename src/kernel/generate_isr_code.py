print(".CODE32\n.GLOBAL ISR_BEGIN\n.EXTERN ISR_HANDLER\nISR_BEGIN:")

for i in range(32):
	print(f"\t.LONG ISR{i}")
for i in range(16):
	print(f"\t.LONG IRQ{i}")
for i in range(32):
	print(f"ISR{i}:\n\tCLI\n\t{"NOP\n\tNOP" if i in [8, 10, 11, 12, 13, 14] else "PUSHL $0"}\n\tPUSHL ${i}\n\tJMP ISR_COMMON_STUB")
for i in range(16):
	print(f"IRQ{i}:\n\tCLI\n\tPUSHL $0\n\tPUSHL ${i}\n\tJMP IRQ_COMMON_STUB")

print()
for i in ["IRQ", "ISR"]:
	print(f"""{i}_COMMON_STUB:
	PUSHAL
	MOV %DS, %AX
	PUSH %EAX
	MOV $0x10, %AX
	MOV %AX, %DS
	MOV %AX, %ES
	MOV %AX, %FS
	MOV %AX, %GS
	
	CALL {i}_HANDLER

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

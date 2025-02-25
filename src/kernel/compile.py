print(".GLOBL CURSOR\n.SECTION .rodata\nCURSOR:\n\tWIDTH:\n\t.WORD 12\n\tHEIGHT:\n\t.WORD 19\n\tDATA:")
with open("cursor_mask", "rb") as mask:
	with open("cursor", "rb") as img:
		while True:
			try:
				print(f"\t.WORD {hex((mask.read(1)[0] << 8) | img.read(1)[0])}")
			except:
				break;
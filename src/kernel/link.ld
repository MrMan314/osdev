OUTPUT_FORMAT(binary)
SECTIONS {
	. = 0x1000;
	PROVIDE(_start = .);

	.text	ALIGN(0x1000):
		ALIGN(0x1000) {
			*(.text)
		}

	.rodata	ALIGN(0x1000):
		ALIGN(0x1000) {
			*(.rodata)
		}

	.data	ALIGN(0x1000):
		ALIGN(0x1000) {
			*(.data)
		}

	.bss	ALIGN(0x1000):
		ALIGN(0x1000) {
			*(.COMMON)
			*(.bss)
		}

	/DISCARD/ : {
		*(.note.gnu.property)
	}
}

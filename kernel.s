.CODE16

.GLOBAL _start

_start:
	MOV $TEST, %SI
	CALL 0x7C48
.LOOP:
	JMP .LOOP

TEST: .ASCIZ "test\r\n"

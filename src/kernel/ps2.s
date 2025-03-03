.CODE32

.GLOBL PS2_INIT
.EXTERN PRINT
.EXTERN PRINT_HEX_8
.EXTERN PRINT_HEX_32

PS2_INIT:
	PS2_DISABLE:
	CALL PS2_WAIT_WRITE
	MOV $0xAD, %AL
	OUT %Al, $0x64
	CALL PS2_WAIT_WRITE
	MOV $0xA7, %AL
	OUT %AL, $0x64

	PS2_FLUSH:
	CALL PS2_WAIT_READ
	IN $0x60, %AL

	PS2_CONFIG:
	CALL PS2_WAIT_WRITE
	MOV $0x20, %AL
	OUT %AL, $0x64

	MOV $0x0F, %CH
	LEA CONFIG_MSG, %ESI
	CALL PRINT

	CALL PS2_WAIT_READ
	IN $0x60, %AL
	CALL PRINT_HEX_8
	AND $0b10101110, %AL

	CALL PRINT_HEX_8

	CALL NL

	PUSH %EAX

	CALL PS2_WAIT_WRITE
	MOV $0x60, %AL
	OUT %AL, $0x64

	POP %EAX

	CALL PS2_WAIT_WRITE
	OUT %AL, $0x60

	PS2_TEST:
	CALL PS2_WAIT_WRITE
	MOV $0xAA, %AL
	OUT %AL, $0x64

	LEA TEST_MSG, %ESI
	CALL PRINT
	CALL PS2_WAIT_READ
	IN $0x60, %AL
	CMP $0x55, %AL
	JNE PS2_FAIL
	MOV $0x0A, %CH
	LEA TEST_PASS, %ESI
	CALL PRINT
	CALL NL

	MOV $0x0F, %CH

	PS2_CHANNELS:
	CALL PS2_WAIT_WRITE
	MOV $0xA8, %AL
	OUT %AL, $0x64

	CALL PS2_WAIT_WRITE
	MOV $0x20, %AL
	OUT %AL, $0x64
	CALL PS2_WAIT_READ
	IN $0x60, %AL
	AND $0x20, %AL
	JNZ PS2_SINGLE_CHANNEL
	LEA DUAL_CHANNEL, %ESI
	CALL PRINT
	CALL PS2_WAIT_WRITE
	MOV $0xA7, %AL
	OUT %AL, $0x64

	JMP PS2_INTERFACE_TEST
	PS2_SINGLE_CHANNEL:
	MOV $0x01, IS_SINGLE_CHANNEL
	LEA SINGLE_CHANNEL, %ESI
	CALL PRINT

	PS2_INTERFACE_TEST:
	CALL NL
	LEA PORT1_NAME, %ESI
	CALL PRINT
	CALL PS2_WAIT_WRITE
	MOV $0xAB, %AL
	OUT %AL, $0x64
	CALL PS2_WAIT_READ
	IN $0x60, %AL
	JNZ PS2_FAIL
	MOV $0x0A, %CH
	LEA TEST_PASS, %ESI
	CALL PRINT
	CALL NL
	MOV $0x0F, %CH

	LEA PORT2_NAME, %ESI
	CALL PRINT
	CALL PS2_WAIT_WRITE
	MOV $0xA9, %AL
	OUT %AL, $0x64
	CALL PS2_WAIT_READ
	IN $0x60, %AL
	JNZ PS2_FAIL
	MOV $0x0A, %CH
	LEA TEST_PASS, %ESI
	CALL PRINT
	CALL NL
	MOV $0x0F, %CH

	XOR %AL, %AL
	OR IS_SINGLE_CHANNEL, %AL
	JZ PS2_ENABLE

	CALL PS2_WAIT_WRITE
	MOV $0xA8, %AL
	OUT %AL, $0x64

	PS2_ENABLE:
	CALL PS2_WAIT_WRITE
	MOV $0xAE, %AL
	OUT %AL, $0x64

	PS2_CONFIG2:
	CALL PS2_WAIT_WRITE
	MOV $0x20, %AL
	OUT %AL, $0x64

	LEA CONFIG_MSG, %ESI
	CALL PRINT

	CALL PS2_WAIT_READ
	IN $0x60, %AL
	CALL PRINT_HEX_8
	OR $0b01000011, %AL
	AND $0b11001111, %AL

	CALL PRINT_HEX_8

	CALL NL

	PUSH %EAX

	CALL PS2_WAIT_WRITE
	MOV $0x60, %AL
	OUT %AL, $0x64

	POP %EAX

	CALL PS2_WAIT_WRITE
	OUT %AL, $0x60

	CALL PS2_WAIT_WRITE
	MOV $0xF5, %AL
	OUT %AL, $0x60

	CALL PS2_WAIT_READ
	IN $0x60, %AL

	LEA PORT1_RESET, %ESI
	CALL PRINT
	CALL PS2_WAIT_WRITE
	MOV $0xFF, %AL
	OUT %AL, $0x60
	CALL PS2_WAIT_READ
	IN $0x60, %AL
	CMP $0xFA, %AL
	JNE PS2_FAIL
	MOV $0x0A, %CH
	LEA TEST_PASS, %ESI
	CALL PRINT
	CALL NL
	MOV $0x0F, %CH

	CALL PS2_WAIT_READ
	IN $0x60, %AL

	CALL PS2_WAIT_WRITE
	MOV $0xF5, %AL
	OUT %AL, $0x60
	CALL PS2_WAIT_READ
	IN $0x60, %AL

	CALL PS2_SECOND
	MOV $0xF5, %AL
	OUT %AL, $0x60
	CALL PS2_WAIT_READ
	IN $0x60, %AL

	LEA PORT2_RESET, %ESI
	CALL PRINT
	CALL PS2_SECOND
	MOV $0xFF, %AL
	OUT %AL, $0x60
	CALL PS2_WAIT_READ
	IN $0x60, %AL
	CMP $0xFA, %AL
	JNE PS2_FAIL
	MOV $0x0A, %CH
	LEA TEST_PASS, %ESI
	CALL PRINT
	CALL NL
	MOV $0x0F, %CH

	WAIT_FOR_AA:
	CALL PS2_WAIT_READ
	IN $0x60, %AL
	CMP $0xAA, %AL
	JNE WAIT_FOR_AA

	CALL PS2_WAIT_WRITE
	MOV $0xF4, %AL
	OUT %AL, $0x60

	WAIT_FOR_P1_ACK:
	CALL PS2_WAIT_READ
	IN $0x60, %AL
	CMP $0xFA, %AL
	JNE WAIT_FOR_P1_ACK

	CALL PS2_SECOND
	JC PS2_FAIL
	MOV $0xF4, %AL
	OUT %AL, $0x60

	WAIT_FOR_P2_ACK:
	CALL PS2_WAIT_READ
	IN $0x60, %AL
	CMP $0xFA, %AL
	JNE WAIT_FOR_P2_ACK

	RET

PS2_FAIL:
	MOV $0x0C, %CH
	LEA TEST_FAIL, %ESI
	CALL PRINT
	CALL PRINT_HEX_8
	CALL NL
PS2_HANG:
	JMP PS2_HANG

PS2_WAIT_READ:
	PUSHAL
	MOV $10000, %ECX
	.PS2_READ_LOOP:
	PAUSE
	IN $0x64, %AL
	DEC %ECX
	JZ .PS2_TIMEOUT
	AND $0x02, %AL
	JNZ .PS2_READ_LOOP
	JMP .PS2_DONE

PS2_WAIT_WRITE:
	PUSHAL
	MOV $10000, %ECX
	.PS2_WRITE_LOOP:
	PAUSE
	IN $0x64, %AL
	DEC %ECX
	JZ .PS2_TIMEOUT
	AND $0x01, %AL
	JZ .PS2_WRITE_LOOP
	JMP .PS2_DONE

.PS2_TIMEOUT:
	STC
.PS2_DONE:
	POPAL
	RET

PS2_SECOND:
	CALL PS2_WAIT_WRITE
	PUSH %EAX
	MOV $0xD4, %AL
	OUT %AL, $0x64
	POP %EAX
	CALL PS2_WAIT_READ
	RET

IS_SINGLE_CHANNEL: .BYTE 0x00

.SECTION .rodata
CONFIG_MSG: .ASCIZ "[ PS/2 ] config byte: "
TEST_MSG: .ASCIZ "[ PS/2 ] Controller self-test "
SINGLE_CHANNEL: .ASCIZ "[ PS/2 ] Single channel"
DUAL_CHANNEL: .ASCIZ "[ PS/2 ] Dual channel"

TEST_PASS: .ASCIZ "OK"
TEST_FAIL: .ASCIZ "FAILED: 0x"

PORT1_NAME: .ASCIZ "[ PS/2 ] Port 1 test "
PORT2_NAME: .ASCIZ "[ PS/2 ] Port 2 test "

PORT1_RESET: .ASCIZ "[ PS/2 ] Port 1 reset "
PORT2_RESET: .ASCIZ "[ PS/2 ] Port 2 reset "


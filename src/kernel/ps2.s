.CODE16

.GLOBL PS2_START
.EXTERN NL
.EXTERN PRINT
.EXTERN PRINT_HEX
.EXTERN .TEST_FAIL

PS2_START:
	PS2_DISABLE:
	CALL PS2_WAIT_WRITE
	MOVB $0xAD, %AL
	OUTB %AL, $0x64
	CALL PS2_WAIT_WRITE
	MOVB $0xA7, %AL
	OUTB %AL, $0x64


	PS2_FLUSH:
	CALL PS2_WAIT_READ
	INB $0x60, %AL

	PS2_CONFIG:
	CALL PS2_WAIT_WRITE
	MOVB $0x20, %AL
	OUTB %AL, $0x64

	MOV $CONFIG_MSG, %SI
	CALL PRINT

	CALL PS2_WAIT_READ
	INB $0x60, %AL
	CALL PRINT_HEX
//	ORB $0b00000000, %AL
	AND $0b10101110, %AL

	CALL PRINT_HEX
	MOV $NL, %SI
	CALL PRINT

	PUSH %AX

	CALL PS2_WAIT_WRITE
	MOVB $0x60, %AL
	OUTB %AL, $0x64

	POP %AX

	CALL PS2_WAIT_WRITE
	OUTB %AL, $0x60

	PS2_TEST:
	CALL PS2_WAIT_WRITE
	MOVB $0xAA, %AL
	OUTB %AL, $0x64

	MOV $TEST_MSG, %SI
	CALL PRINT
	CALL PS2_WAIT_READ
	INB $0x60, %AL
	CMP $0xFC, %AL
	JE .TEST_FAIL
	MOV $TEST_PASS, %SI
	CALL PRINT

	PS2_CHANNELS:
	CALL PS2_WAIT_WRITE
	MOVB $0xA8, %AL
	OUTB %AL, $0x64

	CALL PS2_WAIT_WRITE
	MOVB $0x20, %AL
	OUTB %AL, $0x64
	CALL PS2_WAIT_READ
	INB $0x60, %AL
	AND $0x20, %AL
	JNZ PS2_SINGLE_CHANNEL
	MOV $DUAL_CHANNEL, %SI
	CALL PRINT
	CALL PS2_WAIT_WRITE
	MOVB $0xA7, %AL
	OUTB %AL, $0x64

	JMP PS2_INTERFACE_TEST
	PS2_SINGLE_CHANNEL:
	MOVB $0x01, IS_SINGLE_CHANNEL
	MOV $SINGLE_CHANNEL, %SI
	CALL PRINT

	PS2_INTERFACE_TEST:
	MOV $PORT1_NAME, %SI
	CALL PRINT
	CALL PS2_WAIT_WRITE
	MOVB $0xAB, %AL
	OUTB %AL, $0x64
	CALL PS2_WAIT_READ
	INB $0x60, %AL
	JNZ .TEST_FAIL
	MOV $TEST_PASS, %SI
	CALL PRINT

	MOV $PORT2_NAME, %SI
	CALL PRINT
	CALL PS2_WAIT_WRITE
	MOVB $0xA9, %AL
	OUTB %AL, $0x64
	CALL PS2_WAIT_READ
	INB $0x60, %AL
	JNZ .TEST_FAIL
	MOV $TEST_PASS, %SI
	CALL PRINT

	XORB %AL, %AL
	OR IS_SINGLE_CHANNEL, %AL
	JZ PS2_ENABLE

	CALL PS2_WAIT_WRITE
	MOVB $0xA8, %AL
	OUTB %AL, $0x64

	PS2_ENABLE:
	CALL PS2_WAIT_WRITE
	MOVB $0xAE, %AL
	OUTB %AL, $0x64

	PS2_CONFIG2:
	CALL PS2_WAIT_WRITE
	MOVB $0x20, %AL
	OUTB %AL, $0x64

	MOV $CONFIG_MSG, %SI
	CALL PRINT

	CALL PS2_WAIT_READ
	INB $0x60, %AL
	CALL PRINT_HEX
	ORB $0b01000011, %AL
	AND $0b11001111, %AL

	CALL PRINT_HEX

	MOV $NL, %SI
	CALL PRINT

	PUSH %AX

	CALL PS2_WAIT_WRITE
	MOVB $0x60, %AL
	OUTB %AL, $0x64

	POP %AX

	CALL PS2_WAIT_WRITE
	OUTB %AL, $0x60

	CALL PS2_WAIT_WRITE
	MOV $0xF5, %AL
	OUTB %AL, $0x60

	CALL PS2_WAIT_READ
	INB $0x60, %AL

	MOV $PORT1_RESET, %SI
	CALL PRINT
	CALL PS2_WAIT_WRITE
	MOVB $0xFF, %AL
	OUTB %AL, $0x60
	CALL PS2_WAIT_READ
	INB $0x60, %AL
	CMP $0xFA, %AL
	JNE .TEST_FAIL
	MOV $TEST_PASS, %SI
	CALL PRINT
	CALL PS2_WAIT_READ
	INB $0x60, %AL

	CALL PS2_WAIT_WRITE
	MOV $0xF5, %AL
	OUTB %AL, $0x60
	CALL PS2_SECOND
	OUTB %AL, $0x60

	CALL PS2_WAIT_READ
	INB $0x60, %AL

	MOV $PORT2_RESET, %SI
	CALL PRINT
	CALL PS2_SECOND
	MOVB $0xFF, %AL
	OUTB %AL, $0x60
	CALL PS2_WAIT_READ
	INB $0x60, %AL
	CMP $0xFA, %AL
	JNE .TEST_FAIL
	MOV $TEST_PASS, %SI
	CALL PRINT
	CALL PS2_WAIT_READ
	INB $0x60, %AL

	CALL PS2_WAIT_WRITE
	MOV $0xF4, %AL
	OUTB %AL, $0x60

	CALL PS2_SECOND
	JC .TEST_FAIL
	OUTB %AL, $0x60

	RET

PS2_WAIT_READ:
	PUSH %CX
	MOV $0x2710, %CX
	PUSH %AX
.PS2_READ_LOOP:
	PAUSE
	INB $0x64, %AL
	DEC %CX
	JZ .PS2_TIMEOUT
	AND $0x02, %AL
	JNZ .PS2_READ_LOOP
	JMP .PS2_DONE

PS2_WAIT_WRITE:
	PUSH %CX
	MOV $0x2710, %CX
	PUSH %AX
.PS2_WRITE_LOOP:
	PAUSE
	INB $0x64, %AL
	DEC %CX
	JZ .PS2_TIMEOUT
	AND $0x01, %AL
	JZ .PS2_WRITE_LOOP
	JMP .PS2_DONE

.PS2_TIMEOUT:
	STC
.PS2_DONE:
	POP %AX
	POP %CX
	RET

PS2_SECOND:
	CALL PS2_WAIT_WRITE
	PUSH %AX
	MOV $0xD4, %AL
	OUTB %AL, $0x64
	POP %AX

	CALL PS2_WAIT_READ
	RET

IS_SINGLE_CHANNEL: .BYTE 0x00

.SECTION .rodata
CONFIG_MSG: .ASCIZ "PS/2 config byte: "
TEST_MSG: .ASCIZ "Controller self-test "
SINGLE_CHANNEL: .ASCIZ "Single channel PS/2\r\n"
DUAL_CHANNEL: .ASCIZ "Dual channel PS/2\r\n"

TEST_PASS: .ASCIZ "OK\r\n"

PORT1_NAME: .ASCIZ "PS/2 1 test "
PORT2_NAME: .ASCIZ "PS/2 2 test "

PORT1_RESET: .ASCIZ "PS/2 1 reset "
PORT2_RESET: .ASCIZ "PS/2 2 reset "

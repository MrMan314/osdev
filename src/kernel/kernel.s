.CODE16

.GLOBL _start
.GLOBL .TEST_FAIL
.EXTERN NL
.EXTERN PRINT
.EXTERN PRINT_HEX
.EXTERN PS2_START
.EXTERN KBHAND
.EXTERN MOUSEHAND
.EXTERN CURSOR_X
.EXTERN CURSOR_Y
.EXTERN CURSOR

_start:
	JMP MAIN

TIMERHAND:
	PUSH %AX
	PUSH %DI
	PUSH %SI
	PUSH %ES

	CALL CLEAR_SCREEN

	MOV $0x9000, %AX
	MOV %AX, %ES

	MOV CURSOR_Y, %AX
	MOV $320, %DX
	MUL %DX
	ADD CURSOR_X, %AX 
	MOV %AX, %DI

	MOV $CURSOR, %SI
	CALL IMG_SHOW

	CALL BUF_SHOW

	MOV $0x20, %AL
	OUT %AL, $0x20

	POP %ES
	POP %SI
	POP %DI
	POP %AX
	IRET

DIVZHAND:
	POP %AX
	ADD $0x2, %AX
	PUSH %AX
	PUSH %SI
	MOV $DIVZ_TEXT, %SI
	CALL PRINT
	MOV $0x20, %AL
	OUT %AL, $0x20
	POP %SI
	XOR %AX, %AX
	XOR %DX, %DX
	IRET

MAIN:
	MOV $TEST, %SI
	CALL PRINT

	XOR %AX, %AX
	MOV %AX, %DS
	MOV %AX, %ES
	MOV %AX, %FS
	MOV %AX, %GS
	MOV %AX, %SS
	MOVW $0x3000, %SP

	CLI

	CALL PS2_START
//	CALL CLEAR_SCREEN
//	CALL BUF_SHOW

	MOVW $DIVZHAND, %ES:(0x00*4)
	MOVW $0x0, %ES:(0x00*4+2)
	MOVW $TIMERHAND, %ES:(0x1C*4)
	MOVW $0x0, %ES:(0x1C*4+2)
	MOVW $KBHAND, %ES:(0x09*4)
	MOVW $0x0, %ES:(0x09*4+2)
	MOVW $MOUSEHAND, %ES:(0x74*4)
	MOVW $0x0, %ES:(0x74*4+2)

	STI

.LOOP:
	JMP .LOOP
.TEST_FAIL:
	MOV $TEST_FAIL, %SI
	CALL PRINT
	CALL PRINT_HEX
	MOV $NL, %SI
	CALL PRINT
	JMP .LOOP

CLEAR_SCREEN:
	PUSH %AX
	PUSH %CX
	PUSH %ES
	PUSH %DI
	MOV $0x9000, %AX
	MOV %AX, %ES
	MOV $32000, %CX
//	XOR %AX, %AX
	XOR %DI, %DI
	MOV $0x0101, %AX
	CLEAR_LOOP:
	STOSW
	LOOP CLEAR_LOOP
	POP %DI
	POP %ES
	POP %CX
	POP %AX
	RET

BUF_SHOW:
	PUSH %AX
	PUSH %CX
	PUSH %ES
	PUSH %DS
	PUSH %DI
	PUSH %SI
	MOV $0xA000, %AX
	MOV %AX, %ES
	MOV $0x9000, %AX
	MOV %AX, %DS
	MOV $32000, %CX
	XOR %DI, %DI
	XOR %SI, %SI
	BUF_LOOP:
	LODSW
	STOSW
	LOOP BUF_LOOP
	POP %SI
	POP %DI
	POP %DS
	POP %ES
	POP %CX
	POP %AX
	RET

IMG_SHOW:
	PUSH %AX
	PUSH %BX
	PUSH %CX
	PUSH %DX
	PUSH %DI
	PUSH %ES

	LODSW
	MOV %AX, IMG_WIDTH
	LODSW
	MOV %AX, IMG_HEIGHT

	MUL IMG_WIDTH
	MOV %AX, %CX

	MOV $0x9000, %AX
	MOV %AX, %ES

	MOV %DI, %AX
	XOR %DX, %DX
	MOV $320, %BX
	DIV %BX

	MOV %DX, IMG_X
	MOV %DX, IMG_OX

	XOR %AX, %AX
	MOVW %AX, IMG_DX
	MOV IMG_WIDTH, %BX
	SHOW_LOOP:
		CMP $64000, %DI
		JAE .TRUNCATE
		LODSW
		CMP %BX, IMG_DX
		JB .NEXT
		ADD $320, %DI
		SUB IMG_WIDTH, %DI
		MOVW $0x0000, IMG_DX
		MOV IMG_OX, %DX
		MOV %DX, IMG_X
		.NEXT:
		MOV IMG_X, %DX
		CMPW $320, %DX
		JB NOT_EDGING
		XOR %AH, %AH
		NOT_EDGING:
		INCW IMG_DX
		INCW IMG_X
		OR %AH, %AH
		JNZ .SHOW
		ADD $0x01, %DI
		JMP .NOSHOW
		.SHOW:
		STOSB
		.NOSHOW:
		LOOP SHOW_LOOP
	.TRUNCATE:
	POP %ES
	POP %DI
	POP %DX
	POP %CX
	POP %BX
	POP %AX
	RET

IMG_HEIGHT: .WORD 0x0000
IMG_WIDTH: .WORD 0x0000
IMG_DX: .WORD 0x0000
IMG_X: .WORD 0x0000
IMG_OX: .WORD 0x0000

.SECTION .rodata
TEST_FAIL: .ASCIZ "FAILED: "
TEST: .ASCIZ "welcome to freaky os\r\n"
TIMER_TEXT: .ASCIZ "hello bro\r\n"
DIVZ_TEXT: .ASCIZ "bro divided by zero\r\n"

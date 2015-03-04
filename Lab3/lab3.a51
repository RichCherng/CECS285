			ORG 000
			mov R0,#11000000b
			LJMP MAIN
			
MAIN: 		;LJMP PATTERN1
			mov A,P0
			ANL A,#000000111b
			mov P2,A
			ACALL DELAY
			CJNE A,#001b,N1
			LJMP PATTERN1
			SJMP MAIN
			;CJNE A,#001,N1
			;LJMP PATTERN1
			;JMP MAIN
N1:		mov P2,A
		CJNE A,#010b,N2
		mov P1,#00000010b
		LJMP MAIN
		
N2:		mov P2,A
		CJNE A,#011b,N3
		mov P1,#00000011b
		LJMP MAIN
		
N3:		mov P2,A
		CJNE A,#100b,N4
		mov P1,#00000100b
		LJMP MAIN
		
N4:		mov P2,A
		CJNE A,#101b,N5
		mov P1,#00000101b
		LJMP MAIN
		
N5:		mov P2,A
		CJNE A,#110b,N6
		mov P1,#00000110b
		LJMP MAIN
		
N6:		mov P2,A
		mov P1,#00000111b
		LJMP MAIN		
			
		
PATTERN1: 	mov A, R0
			CJNE A,#11000000b,CHECK ; call check if false
			mov R1,A ; indicator to go right
			LJMP ROTATE
			;ANL A,#11000000b
			;JZ  CHANGE
			
			CHECK: 		mov A,R0
						CJNE A,#00000011b,ROTATE; Rotate if non of the condition is met
						mov R1,#0 ; indicator to go left
						LJMP ROTATE
			
			ROTATE: 	mov A, R1
						JNZ RROTATE; rotate right
						mov A, R0
						RL A
						mov R0,A
						mov P1,A
						LJMP MAIN
					
			RROTATE:	mov A,R0
						RR A
						mov R0,A
						mov P1,A
						LJMP MAIN
		  


DELAY: mov r5,#30H
lp3:   mov r4,#0FFH
lp2:   mov r3,#0FFH
lp1:   djnz r3,lp1
       djnz r4,lp2
	   djnz r5,lp3
	   RET
	   
	   

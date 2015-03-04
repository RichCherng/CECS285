			ORG 000
			mov R0,#11000000b
			mov R6,#00011100b
			mov 10,#00010000b
			mov 11,#00001000b
			mov 12,#1
			mov 50H,#07H
			LJMP MAIN
			
MAIN: 		;LJMP PATTERN1
			mov A,P0
			ANL A,#11100000b
			mov P2,A
			ACALL DELAY
			CJNE A,#20H,N1
			LJMP PATTERN1
			SJMP MAIN
			;CJNE A,#001,N1
			;LJMP PATTERN1
			;JMP MAIN
			
N1:		mov P2,A
		CJNE A,#040H,N2
		LJMP PATTERN2
		LJMP MAIN
		
N2:		mov P2,A
		CJNE A,#060H,N3
		LJMP PATTERN2
		LJMP MAIN
		
N3:		mov P2,A
		CJNE A,#080H,N4
		LJMP PATTERN4
		LJMP MAIN
		
N4:		mov P2,A
		CJNE A,#0A0H,N5
		mov P1,#0A0H
		LJMP PATTERN5
		LJMP MAIN
		
N5:		mov P2,A
		CJNE A,#0C0H,N6
		LJMP PATTERN6
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
		  
PATTERN2:	mov A,10
			RL	A
			mov 10,A
			mov A,11
			RR	A
			mov 11,A
			ADD A,10
			mov P1,A
			LJMP MAIN
			
PATTERN3:		
				;Generate random 0-8bits
	RAND: 		mov A,50H
				jnz RANDB
				cpl A
				mov 50H, A
					
	RANDB: 		ANL A,#10111000b
				mov C, P
				mov A, 50H
				RLC A
				mov 50H, A
				mov 14,50H
				mov 15,#00H ;counter couting bit
				mov 13,#08H ;counter for 8 loops
				
			
	CHECKB:		mov A, 50H
				mov p3, 50H
				RLC A
				mov 50H, A
				JNC Decrement
				INC 15
				CLR c
				
				;Decrement loop counter without INC bit counter
	Decrement:	
				mov p3, 13
				mov p3, 15
				mov A, 15
				DJNZ 13, CHECKB
				;if random number contain only 3 bit then pass
				CJNE A,#03H,RAND
				mov P1, 14
				mov 50H, 14
				LJMP MAIN
			
PATTERN4:	
			mov A, 12
			CPL A
			mov 12, A
			CJNE A,#11111110b,SHOW
			mov P1,#01010101b
			LJMP MAIN
			
			SHOW:	mov P1,#10101010b
					LJMP MAIN
		
PATTERN5: 	mov P1,R6
			mov A, R6
			RL	A
			mov R6,A
			LJMP MAIN
			
PATTERN6: 	mov P1,R6
			mov A, R6
			RR	A
			mov R6,A
			LJMP MAIN

DELAY: mov r5,#30H
lp3:   mov r4,#0FFH
lp2:   mov r3,#0FFH
lp1:   djnz r3,lp1
       djnz r4,lp2
	   djnz r5,lp3
	   RET
	   
	   

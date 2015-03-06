			ORG 000
			mov R0,#11000000b
			mov R6,#00011100b
			mov 10,#00010000b
			mov 11,#00001000b
			mov 12,#1
			mov 50H,#07H
			LJMP MAIN
			
MAIN: 		;Delay before execute the program everytime
			;each pattern will execute one step then call main
			ACALL DELAY
			mov A,P0 				;read input from port 0
			ANL A,#11100000b 		;read the first 3 bit and mask the rest
			CJNE A,#20H,N1 			;check for pattern
			LJMP PATTERN1 			;execute pattern #1
			
			;process of checking switches for pattern
	N1:		CJNE A,#040H,N2
			LJMP PATTERN2
			
	N2:		CJNE A,#060H,N3
			LJMP PATTERN3
			
	N3:		CJNE A,#080H,N4
			LJMP PATTERN4
			
	N4:		CJNE A,#0A0H,N5
			mov P1,#0A0H
			LJMP PATTERN5
			
	N5:		CJNE A,#0C0H,N6
			LJMP PATTERN6
			
	N6:		LJMP PATTERN7
	
			;First pattern for switches 001, 2 bits moving back and forth
PATTERN1: 	mov A, R0				;Load the pattern for pattern #1
			CJNE A,#11000000b,CHECK ;if the 2 bits reached the left end then change direction
			mov R1,A
			LJMP ROTATE
			
			;if 2 bits didnt reaches the edges, keep the previous indicator (R1)
	CHECK: 	mov A,R0
			CJNE A,#00000011b,ROTATE;if the 2 bits reached the right end then change direction 
			mov R1,#0 				; indicator to go left
						
			;rotate bit left/right depend on the indicator (R1)
	ROTATE: mov A, R1
			JNZ RROTATE				; rotate right, if indicator is 1
			mov A, R0
			RL A
			mov R0,A
			mov P1,A
			LJMP MAIN
			
	RROTATE:mov A,R0
			RR A
			mov R0,A
			mov P1,A
			LJMP MAIN
			;Second pattern for switches 010,2 bits moving in opposite direction back and forth
PATTERN2:	mov A,10
			RL	A
			mov 10,A
			mov A,11
			RR	A
			mov 11,A
			ADD A,10
			mov P1,A
			LJMP MAIN
			
			;Pattern #3 for switches 011, generate 3-bits random number
PATTERN3:	;Generate random 0-8bits
	RAND: 	mov A,50H
			jnz RANDB
			cpl A
			mov 50H, A
					
	RANDB: 	ANL A,#10111000b
			mov C, P
			mov A, 50H
			RLC A
			mov 50H, A
				
			;checking for exactly 3 bits
			mov R7,50H
			mov R1,#00H 			;counter couting bit
			mov R2,#08H 			;counter for 8 loops
	CHECKB:	mov A, 50H
			RLC A
			mov 50H, A
			JNC Decrement
			INC R1
						
			;Decrement loop counter without INC bit counter
	Decrement:	
			DJNZ R2, CHECKB
			mov 50H,R7
			mov A, R1
			CJNE A,#03H,RAND		;if random number contain only 3 bit then pass
			mov P1, R7
			LJMP MAIN
			;Pattern #4 for switches 100, flashing led	
PATTERN4:	mov A, 12 ;load in indicator
			CPL A
			mov 12, A
			CJNE A,#11111110b,SHOW
			mov P1,#01010101b
			LJMP MAIN
					
	SHOW:	mov P1,#10101010b
			LJMP MAIN
			;Pattern #5 for switches 101, rotate 3 bits left
PATTERN5: 	mov P1,R6
			mov A, R6
			RL	A
			mov R6,A
			LJMP MAIN
			;Pattern #6 for switches 110, rotate 3 bits right
PATTERN6: 	mov P1,R6
			mov A, R6
			RR	A
			mov R6,A
			LJMP MAIN
			;Pattern#7 for switches 111, switching 4 bits from side to side
PATTERN7:   mov A, 12 ;load in the indicator
			CPL A
			mov 12, A
			CJNE A,#11111110b,SHOWP7
			mov P1,#11110000b
			LJMP MAIN
			
			SHOWP7:	mov P1,#00001111b
					LJMP MAIN
			;delay, to slow down the program
DELAY: 		mov A, p0 				;read in the input from port 0
			ANL A,#00000111b 		; mask everything except last 3
			;first and the slowest speed, 000
			CJNE A,#00000000b,s2
			mov r5,#0A0H
			LJMP lp3
			;Second speed, 001
	s2:		CJNE A,#00000001b, s3
			mov r5,#090H
			LJMP lp3
			;third speed, 010
	s3:		CJNE A,#00000010b, s4
			mov r5,#080H
			LJMP lp3
			;fourth speed, 011
	s4:		CJNE A,#00000011b, s5
			mov r5,#070H
			LJMP lp3
			;fifth speed, 100
	s5:		CJNE A,#00000100b, s6
			mov r5,#060H
			LJMP lp3
			;sixth speed, 101
	s6:		CJNE A,#00000101b, s7
			mov r5,#050H
			LJMP lp3
			;seventh speed, 110
	s7:		CJNE A,#00000110b, s8
			mov r5,#040H
			LJMP lp3
			;Last and fastest speed, 111
	s8:		CJNE A,#00000111b, s3
			mov r5,#030H

		lp3:mov r4,#0FFH
		lp2:mov r3,#0FFH
		lp1:djnz r3,lp1
			djnz r4,lp2
			djnz r5,lp3
			RET
	   
	   

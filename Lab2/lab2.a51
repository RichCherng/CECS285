LJMP	main

ORG	0100H

MAIN:

MOV	P1,#0AAH 	;8 LEDS OFF

ACALL	DelAY	;STAY .5 SEC

MOV	P1,#055H	;8 LEDS ON

ACALL	Delay	;STAY .5 SEC

LJMP MAIN

Delay:	mov	r3,#30H

lp3:	mov	r2,#0FFH

lp2:	mov	r1,#0FFH

lp1:	djnz	r1,lp1

djnz	r2,lp2

djnz	r3,lp3

RET
end
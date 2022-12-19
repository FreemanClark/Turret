		AREA mycode, CODE, READONLY
		EXPORT update_motor
		EXTERN bearing[SIZE=4]
		ALIGN
		ENTRY
update_motor	PROC
;       //* Step C0 C1 C2 C3
;// *    1       1  0  1  0
;// *    2       0  1  1  0
;// *    3       0  1  0  1
;// *    4       1  0  0  1
		;setup for left/right motor
		
		;LDR R1, =0x2009C054 ;FIO2PIN
		LDR R3, =0x2009C034 ;R3 is the address for FIO1PIN
		LDR R0, =0x2009C014 ;FIO0PIN
	
;While 1.24 is on, register will be loaded to ___, and then we step through each step until it goes back to original val


loop	LDR R2, [R3]        ; R2 is the value of FIO1PIN (shows if pins are on or off)
		
		; TODO: Determine if you should jump to up, down, left, or right
		; based on the value in R2
		
		tst r2, #0x00800000
		BEQ up
	
		tst r2, #0x02000000
		BEQ down
	
		tst r2, #0x04000000 ;hex value that is a 1 for 26
		BEQ left
	
		tst r2, #0x01000000 ;hex value that is a 1 for 24
		BEQ right
	
		;B loop 		; change to endofproc when not main fxn
		B endofproc
up		; TODO: Increment R0 and jump to wait
		LDR R0, =0x2009C014 ;FIO0PIN
;set a 1 to 2.2 and 2.5
		mov R2, #0x18
		str R2, [R1]
		;store location of pos
		;LDR R6, =bearing
		;MOV R7, #60 ;stores degree pos in R7
		;STR R7, [R6]
		BL waitHundredms
		
		
		;set a 1 to 2.3 and 2.5
		mov R2, #0x0C
		str R2, [R1]
		;store location of pos
;		LDR R6, =bearing
;		MOV R7, #45 ;stores degree pos in R7
;		STR R7, [R6]
		BL waitHundredms
		
		;set a 1 to 2.3 and 2.4
		mov R2, #0x24
		str R2, [R1]
		;store location of pos
;		LDR R6, =bearing
;		MOV R7, #30 ;stores degree pos in R7
;		;STR R7, [R6]
		BL waitHundredms
		
		;Set a 1 to 2.2 and 2.4
		mov R2, #0x30
		str R2, [R1]
		;store location of pos
		LDR R12, =bearing
		LDR R2, [R12]
		ADD R2, #1 ;stores degree pos in R7
		STR R2, [R12]
		BL waitHundredms
		B loop
		
down	; TODO: Decrement R0 and jump to wait
		LDR R0, =0x2009C014 ;FIO0PIN
;Set a 1 to 2.2 and 2.4
		mov R2, #0x30
		str R2, [R1]
		;store location of pos
		;LDR R6, =bearing
		;MOV R7, #15 ;stores degree pos in R7
		;STR R7, [R6]
		BL waitHundredms
	
		;set a 1 to 2.3 and 2.4
		mov R2, #0x24
		str R2, [R1]
		;store location of pos
		;LDR R6, =bearing
		;MOV R7, #30 ;stores degree pos in R7
		;STR R7, [R6]
		BL waitHundredms
	
		;set a 1 to 2.3 and 2.5
		mov R2, #0x0C
		str R2, [R1]
		;store location of pos
		;LDR R6, =bearing
		;MOV R7, #45 ;stores degree pos in R7
		;STR R7, [R6]
		BL waitHundredms
	
		;set a 1 to 2.2 and 2.5
		mov R2, #0x18
		str R2, [R1]
		;store location of pos
		;LDR R6, =bearing
		;MOV R7, #60 ;stores degree pos in R7
		;STR R7, [R6]
		BL waitHundredms
		B loop
	
right
		LDR R1, =0x2009C054 ;FIO2PIN
;set a 1 to 2.2 and 2.5
		mov R2, #0x18
		str R2, [R1]
		;store location of pos
		;LDR R6, =bearing
		;MOV R7, #60 ;stores degree pos in R7
		;STR R7, [R6]
		BL waitHundredms
		
		
		;set a 1 to 2.3 and 2.5
		mov R2, #0x0C
		str R2, [R1]
		;store location of pos
;		LDR R6, =bearing
;		MOV R7, #45 ;stores degree pos in R7
;		STR R7, [R6]
		BL waitHundredms
		
		;set a 1 to 2.3 and 2.4
		mov R2, #0x24
		str R2, [R1]
		;store location of pos
;		LDR R6, =bearing
;		MOV R7, #30 ;stores degree pos in R7
;		;STR R7, [R6]
		BL waitHundredms
		
		;Set a 1 to 2.2 and 2.4
		mov R2, #0x30
		str R2, [R1]
		;store location of pos
		LDR R12, =bearing
		LDR R2, [R12]
		ADD R2, #1 ;stores degree pos in R7
		STR R2, [R12]
		BL waitHundredms
		B loop
		
		

left	
		LDR R1, =0x2009C054 ;FIO2PIN
;Set a 1 to 2.2 and 2.4
		mov R2, #0x30
		str R2, [R1]
		;store location of pos
		;LDR R6, =bearing
		;MOV R7, #15 ;stores degree pos in R7
		;STR R7, [R6]
		BL waitHundredms
	
		;set a 1 to 2.3 and 2.4
		mov R2, #0x24
		str R2, [R1]
		;store location of pos
		;LDR R6, =bearing
		;MOV R7, #30 ;stores degree pos in R7
		;STR R7, [R6]
		BL waitHundredms
	
		;set a 1 to 2.3 and 2.5
		mov R2, #0x0C
		str R2, [R1]
		;store location of pos
		;LDR R6, =bearing
		;MOV R7, #45 ;stores degree pos in R7
		;STR R7, [R6]
		BL waitHundredms
	
		;set a 1 to 2.2 and 2.5
		mov R2, #0x18
		str R2, [R1]
		;store location of pos
		;LDR R6, =bearing
		;MOV R7, #60 ;stores degree pos in R7
		;STR R7, [R6]
		BL waitHundredms
		B loop
endofproc
		ENDP
			
		EXPORT waitHundredms
waitHundredms PROC
	    ; TODO:	Write a procedure that "waits" for 100ms by wasting cycles
		; See Lesson 9 on cycle counting and Reference D from the website
		ldr r0, =70000
loop1   
		SUB R0, #1
		CMP R0, #0
		BNE loop1 
		
		BX LR
		ENDP
				
		EXPORT motorsetup
motorsetup PROC
	    ; sets 0x3C to direction registers for 0.2-5 and 2.2-5
		;setup for left/right motor
		LDR R0, =0x2009C040 ;FIO2DIR
		MOV R2, #0x3C	
		STR R2, [R0]	
		;setup for up/down motor
		LDR R0, =0x2009C000 ;FIO0DIR
		STR R2, [R0]
		BX LR
		ENDP
		END
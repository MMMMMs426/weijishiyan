DATA  	SEGMENT
    	 	INF1  DB "Please input a number (1-361):$"
		INF2  DB"1+2+...+$"
		INF3  DB"=$"
			IBUF	DB 7,0,6 DUP(?)

OBUF  	DB 6 DUP (?)
	DATA 	ENDS
CODE  	SEGMENT
      	ASSUME CS: CODE, DS: DATA
START:	MOV	AX, DATA
      	MOV  	DS, AX
		MOV  	DX, OFFSET INF1
			MOV  	AH, 09H
			INT  	21H	
			MOV  	DX, OFFSET IBUF		
			MOV  	AH, 0AH
     		INT  	21H
	MOV  	CL, IBUF+1			
			MOV  	CH, 0
	MOV  	SI, OFFSET IBUF+2	
			MOV  	AX, 0			
	AGAIN: 	MOV	DX, 10				
		MUL  	DX
  			AND  	BYTE PTR [SI], 0FH
            ADD  	AL, [SI]
            ADC  	AH, 0
            INC  	SI
 			LOOP 	AGAIN
			MOV  	CX, AX
			MOV  	AX, 0
			MOV  	BX, 1
LOOP2:			ADD	AX, BX
			INC	BX
		LOOP	LOOP2
			MOV  	BX, OFFSET OBUF+5
			MOV  	BYTE PTR [BX],'$'
			MOV  	CX, 10		
LOOP1:			MOV	DX, 0		
 			DIV  	CX
			ADD  	DL, 30H		
			DEC  	BX
    			MOV  	[BX], DL
			OR   	AX, AX
			JNZ  	LOOP1
			MOV	DL,0AH
			MOV	AH,02H
			INT	21H
			MOV	DX,OFFSET INF2
			MOV	AH,09H
			INT	21H
			MOV	CL,IBUF+1
			MOV	SI,OFFSET IBUF+2
LOOP3:
			MOV	DL,[SI]
			ADC	DL,30H
			MOV	AH,02H
			INT	21H
			
			INC	SI
			DEC	CL
			JNZ	LOOP3

			MOV	DX,OFFSET INF3
			MOV	AH,09H
			INT	21H		

			MOV  	DX, BX
			MOV  	AH, 09H
        		INT  	21H			

			MOV  	AH, 4CH
      			INT  	21H







CODE  	ENDS
      	END	START

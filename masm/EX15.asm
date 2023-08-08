DATA  	SEGMENT
      			INFOR1  DB 0AH,0DH,"I like panda $"
      			INFOR2  DB 0AH,0DH,"I like cat $"
      			INFOR3  DB 0AH,0DH,"I like rabbit $"
			INFOR4  DB 0AH,0DH,"I don't like pig$"
			INFOR5  DB 0AH,0DH,"You press an error key! $"
			INFOR6  DB 0AH,0DH,"1------------------------Panda $"
      			INFOR7  DB 0AH,0DH,"2------------------------Cat $"
      			INFOR8  DB 0AH,0DH,"3------------------------Rabbit $"
			INFOR9  DB 0AH,0DH,"4------------------------Pig $"
			INFOR10  DB 0AH,0DH,"5------------------------EXIT $"
		DATA  	ENDS
		CODE  	SEGMENT
      			ASSUME CS:CODE,DS:DATA
		START:	MOV  AX,DATA
      			MOV  DS,AX
			MOV  DX,OFFSET INFOR6
			MOV  AH,09H
			INT  21H
			MOV  DX,OFFSET INFOR7
			MOV  AH,09H
			INT  21H
			MOV  DX,OFFSET INFOR8
			MOV  AH,09H
			INT  21H
			MOV  DX,OFFSET INFOR9
			MOV  AH,09H
			INT  21H
			MOV  DX,OFFSET INFOR10
			MOV  AH,09H
			INT  21H
			MOV AH, 01H
    			INT 21H
      			CMP  AL,'1'
			JE  DIGIT
			CMP  AL,'2'
			JE  UPPER
			CMP  AL,'3'
			JE  LOWER
			CMP  AL,'4'
			JE  LOSER
			CMP  AL,'5'
			JE  PEND
			JMP OTHER
	LOWER:	
		MOV  DX,OFFSET INFOR3
		MOV  AH,09H
		INT  21H
		JMP  PEND	
	UPPER:	
		MOV  DX,OFFSET INFOR2
		MOV  AH,09H
		INT  21H
		JMP  PEND
	LOSER:	
		MOV  DX,OFFSET INFOR4
		MOV  AH,09H
		INT  21H
		JMP  PEND
	DIGIT:	MOV  DX,OFFSET INFOR1
		MOV  AH,09H
		INT  21H
		JMP  PEND
	OTHER:	
		MOV  DX,OFFSET INFOR5
		MOV  AH,09H
		INT  21H
		JMP  PEND
	PEND:	MOV  AH,4CH
    		INT  21H
		CODE  	ENDS
      			END  START
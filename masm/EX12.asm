STACK 	SEGMENT stack
      						STL  DW 100H  DUP(?)
STACK 	ENDS
CODE  	SEGMENT
      			ASSUME 	CS:CODE,SS:STACK
START:	MOV	AX, STACK
      						MOV  	SS, AX
   	MOV  	SP, LENGTH STL
；表达式“LENGTH  STL”的功能为计算STL中定义的变量的个数，
；汇编后其值为100H ，详见教材5.1.1
      	MOV  	AX, 0101101100001010B
      						MOV  	BX, 0100110010100011B
      						PUSH 	AX
      						PUSH 	BX
      						ADD  	AX, BX
      						POP  	AX
      						POP  	BX
      						AND  	AX, BX
      						MOV  	AH,4CH
      						INT  	21H
CODE  	ENDS
      						END  START
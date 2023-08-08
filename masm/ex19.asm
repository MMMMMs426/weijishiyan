DATA  SEGMENT 
  INF2 DB "1+2+...+$"
  INF3 DB "=$"
  SUM DW ?
  NUM DW ?
  
  OBUF1 DB 6 DUP(?)
  OBUF2 DB 6 DUP(?)

DATA ENDS
CODE SEGMENT
ASSUME CS: CODE,DS:DATA
START:  
  MOV AX,DATA
  MOV DS,AX
  

  ;MOV  CX,14
  MOV CX,60000
  MOV AX,0
  MOV   BX,1
LOOP2:
  ADD AX,BX   
  INC BX
  CMP CX,AX
  JA LOOP2

  ;会多一个
  DEC  BX
  MOV NUM,BX

  ;将AX中存放的二进制数转换为十进制数
  ;存入OBUF2中，BX偏移
  MOV CX,OFFSET OBUF2+5
  CALL BTD 
  PUSH BX

  ;输出1+2+...
  MOV DX,OFFSET INF2
  MOV AH,09H
  INT 21H
  
  ;输出NUM
  ;将AX中存放的二进制数转换为十进制数
  ;存入OBUF1中，BX偏移
  MOV CX,OFFSET OBUF1+5
  MOV AX,NUM
  CALL BTD

  ;显示OBUF1中，BX偏移
  MOV DX, BX
  MOV AH, 09H
  INT 21H
  
  

  ;输出=
  MOV DX,OFFSET INF3
  MOV AH,09H
  INT 21H

  POP BX

  ;输出SUM
  ;显示OBUF1，BX偏移
  MOV DX, BX
  MOV AH, 09H
  INT 21H
  ;显示转换得到的十进制数

  MOV AH, 4CH
  INT 21H




BTD PROC 
  MOV BX, CX
  MOV BYTE PTR [BX],'$'
  MOV CX, 10 ;做(DX):(AX)/10运算
LOOP1: 
  MOV DX,0
  ;被除数高16位清0
  DIV CX
  ADD DL, 30H
  ;将DL中的一位十进制数转换为ASCII码
  DEC BX
  MOV [BX], DL
  OR AX, AX
  JNZ LOOP1
  ;判断商是否为0，不为0继续
  
  ;MOV DX, BX
  ;MOV AH, 09H
  ;INT 21H
  ;显示转换得到的十进制数

  MOV SUM,BX

  RET

BTD ENDP


CODE  ENDS
END START

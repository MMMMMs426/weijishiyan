DATA SEGMENT
    DB 11H, 23H, 25H, 31H
    DB 0, 0
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA
    
START:
    MOV AX, DATA
    MOV DS, AX
    
    ; 初始化结果为 0
    MOV AL, 0
    MOV BX, 0
    
    ; 从 A 到 D 依次计算加法
    MOV SI, 0
    MOV CX, 4
CALCULATE:
    ; 取 A、B、C、D 中的一个
    LODSB
    
    ; 将其转换为 2 个 BCD 码
    MOV BL, AL
    AND BL, 0FH ; 取低 4 位
    MOV BH, AL
    SHR BH, 4  ; 取高 4 位
    
    ; 将其加入结果
    ADD BX, AX
    
    ; 检查进位
    MOV AL, BH
    ADD AL, BL
    AAA
    ADD BX, AX
    
    ; 继续计算下一个数
    LOOP CALCULATE
    
    ; 将结果保存到 RESULT 中
    MOV AL, BH
    MOV AH, 0
    AAM 10H
    OR AL, 30H
    STOSB
    
    MOV AL, BL
    AAM 10H
    OR AL, 30H
    STOSB
    
    ; 在屏幕上显示结果
    LEA DX, RESULT
    MOV AH, 09H
    INT 21H
    
    ; 结束程序
    MOV AH, 4CH
    INT 21H
    
CODE ENDS
END START

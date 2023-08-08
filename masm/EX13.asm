; 定义数据段
DATA SEGMENT
    ; 定义三个字符串并以$结尾，分别为:
    ; 提示用户输入第一个数据的字符串
    INFOR1 DB "Please Input the First Data (<10):$"
    ; 提示用户输入第二个数据的字符串
    INFOR2 DB 0AH, 0DH, "Please Input the Second Data (<10):$"
    ; 显示结果的字符串
    INFOR3 DB 0AH, 0DH, "The Result is:$"

; 结束数据段
DATA ENDS

; 定义代码段
CODE SEGMENT
    ; 设置段寄存器
    ASSUME CS: CODE, DS: DATA

    ; 程序入口
START:
    ; 将数据段的地址赋值给AX，然后将AX的值赋给DS
    MOV AX, DATA
    MOV DS, AX

    ; 提示用户输入第一个数据
    MOV AH, 09H
    LEA DX, INFOR1
    INT 21H

    ; 等待用户输入第一个数字
    MOV AH, 01H
    INT 21H
    SUB AL, 30H      ; 将字符转换为对应的数字
    MOV BL, AL       ; AL中存储第一个数字，将其备份到BL中

    ; 提示用户输入第二个数据
    MOV AH, 09H
    LEA DX, INFOR2
    INT 21H

    ; 等待用户输入第二个数字
    MOV AH, 01H
    INT 21H
    SUB AL, 30H      ; 将字符转换为对应的数字

    ; 将第一个数字和第二个数字相加
    ADD AL, BL

    ; 打印结果
    MOV AH, 09H
    LEA DX, INFOR3
    INT 21H
    ADD AL, 30H
    MOV AH, 02H    
    MOV DL, AL
    INT 21H

    ; 结束程序
    MOV AH, 4CH
    INT 21H

; 结束代码段
CODE ENDS

; 程序结束
END START

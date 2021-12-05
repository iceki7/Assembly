mydata segment

comment @
内存向高地址增长，little endian存放。


MOV	      内存、reg数据移动（不能修改CS和IP）
XCHG	      内存、寄存器数据交换。（不能均为内存，不能用IP、段寄存器）
PUSH	      压栈，内存向低地址增长
ADC         使用上一次运算的CF标志
IN/OUT   	读写I/O接口数据
LEA		传送变量的有效地址
CMP		做Dst-Src。若Dst>Src 则OF,CF相同
repe cmpsb       ;DS:[SI]-ES:[DI] repeat if equal(ZF=0)
movsb            ;ES:[DI]←DS:[SI]
scasb             ;AL(AX)-ES:[DI]
lodsb             ;AL(AX)←DS:[SI]
xlat             ;AL←[BX+AL]

LOOP       CX!=0时循环
LOOPE      CX!=0 & ZF=1

TEST	     与操作,只置位
CLI        IF=0，CPU不接受可屏蔽中断
CLD        DF=0
SAR        算术右移,符号位补齐。
JMP        无条件跳转
BP,SP  基址、栈顶指针

DI,SI 目标、源操作数偏移地址寄存器



CF:有进位或借位
AF:低4位有进/借位
PF:低字节有偶数个1
ZF
SF：与结果最高位相同
OF：操作数当作有符号数时溢出。
DF：串操作地址减少

BP,SP      暗含SS,向低地址增长


寻址：MOV AX,[BX]	;[DS*16+BX]
MOV AX,VAR[SI][BX]; [DS*16+SI+BX+VAR]

程序段内寻址：
JMP WORD PTR[BP+TABLE] ;修改IP
段间：
JMP DWORD PTR[BX] ;修改CS,IP
@




;seg var 求段基
org 66h    ;移动到偏移地址
varw dw 1234h,5h ;2B
varb db 3,4
align 4     ;对齐到倍数地址  even=align 2
            ;$		//即将分配的单元的偏移地址
vard dd 99999999H  ;4B
parameters db 100
message    db 'hello?'
           db NOT('A'-'A') ;FF
           db 3 LT 5 ;小于,FF
           db '$'
           dw 4108h
           k db 5 dup(?); size=length*type
           dw 7395h
mydata ends
mystack segment stack
        db 100 dup(?)
mystack ends
mycode segment
      assume cs:mycode,ds:mydata,ss:mystack     ;指定段寄存器
      start proc far    ;定义子程序,far:可被相同/不同CS程序调用
      push ds           
      mov ax,0
      push ax
      mov ax,mydata     
      mov ds,ax   ;设定数据段基地址

disp: lea dx,message;求偏移地址
      mov ah,09h  ;打印字符程序
      int 21h
      ret

start endp
mycode ends
end start
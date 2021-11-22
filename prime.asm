
data segment
note1 db 'input N:',10,'$'    ;提示信息
note2 db 'prime num in 1~N:',10,'$'
N     db 0,'$'          ;需要查找的素数的范围
data ends
 
stack segment
    
stack ends
 
code segment
    assume cs:code,ds:data,ss:stack
main proc far

      push ds
      xor ax,0
      push ax

      mov ax,data
      mov ds,ax   ;设定数据段基址


    lea dx,note1    ;显示提示信息
    mov ah,09h
    int 21h; 

  read: xor ax,ax  ;输入一个数字，然后转化为二进制码
      mov ah,1
      int 21h
      cmp al,0dh
      je  prepare   ;如果用户输入回车，则输入完毕
      sub al,48   ;ASCII转数字
      mov bh,al
      xor ax,ax
      mov al,10
      mul N
      mov N,al
      add N,bh   ;结果存入N
      jmp read

prepare:      
    inc N
    lea dx,note2    ;显示提示信息
    mov ah,09h
    int 21h; 


    mov bl, 2        ; 保存被除数
    mov bh, 1        ; 保存除数


judge:
    inc bh
    XOR ax,ax        ; 
    MOV al,bl        ; al是被除数
    div bh           ; bh是除数
    cmp ah,0         ; 余数为0吗？   
    jne judge        ; 余数不为0，则继续测试
    cmp bl,bh        ; 除数=被除数吗？
    jne nextnum      ;如果不是素数，则跳转，计算下一个数字



true:                ;是素数
    XOR bh,bh        ;
    mov ax,bx       ; 把质数移到ax中
    call print; 打印质数

nextnum:                ;参数复位，准备测试下一个数字
    inc bl          
    cmp bl,N        ; 如果达到了n，终止程序
    je stop
    mov bh,1         ; 
    jmp judge        ;

stop: ret

main endp
 
print proc near ;数字打印
    push ax
    push bx
    push cx
    push dx
 
    mov bx,10     ;进制
    mov cx,0
 
pushstack:
    mov dx,0
    div bx        ;将素数按10进制切分成单个数字，并压栈
    push dx       
    inc cx
    
    cmp ax,0      ;若素数已切分完，准备输出
    jz popstack   
    
    jmp pushstack
    
popstack:
    pop dx             ;一次弹出一个0~9之间的数字
    add dl,30h         ; 二进制数转ASCII码
    mov ah,2           ;输出
    int 21h
           
    loop popstack
    
    pop dx
    pop cx
    pop bx
    pop ax
    
    mov ah,2
    mov dl,0      
    int 21h
    ret

print endp
 

code ends
end main
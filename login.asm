data segment
comment *
密码验证
*comment

note  db 'Please Enter The Password:',10,'$'
buff     db 5+1     ;密码长度为5,但最后一个回车符会被读入
         db 10 dup(0)   ;用户输入字符的缓冲区
         db '$'
password db 'RIGHT' ;正确密码
msg_fail db 10,'41922118 Yan Zhexi$'      ;错误信息
msg_suc  db 10,'Welcome To Scce!$'        ;正确信息
data ends

code segment ;代码段定义开始
    assume cs:code,ds:data
start proc far
      push ds
      xor ax,0
      push ax

      mov ax,data
      mov ds,ax   ;为es,ds寄存器设定数据段基址
      mov es,ax


      mov ah,09h               ;显示提示信息  
      lea dx,note              
      int 21h  

      lea     dx,buff
      mov     ah,0ah          ;用户输入5位密码，读入缓冲区
      int     21h
      

compare:
      lea si,buff+2        ;用户输入字符的逻辑地址
      lea di,password          ;正确密码的逻辑地址
      mov cx,5   
      cld
      repe cmpsb       ;串比较，只有字符相等才会继续比较
      jnz fail         

      lea dx,msg_suc    ;验证通过
      mov ah,09h
      int 21h; 
      ret

fail:lea dx,msg_fail    ;验证不通过
      mov ah,09h        
      int 21h 
      ret
start endp

code ends  ;代码段结束  
       ;整个程序结束
end start
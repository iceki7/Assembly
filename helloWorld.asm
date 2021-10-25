mydata segment
;不加h代表十进制,ffff为真，0为假
;内存向高地址增长，little endian存放。
org 100h
varw dw 1234h,5678h
varb db 3,4
align 4
vard dd 12345678H
even
buff db 10 dup(?)
parameters db 100
           db ?
           db 100 dup(?)
message    db 'hello?'
           db '$'
mydata ends
mystack segment stack
        db 100 dup(?)
mystack ends
mycode segment
      assume cs:mycode,ds:mydata,ss:mystack
      start proc far
      push ds
      mov ax,0
      push ax
      mov ax,mydata
      mov ds,ax
disp: mov dx,offset message;显示message的内容
      mov ah,09h
      int 21h
key:  mov dx,offset parameters
      mov ah,0ah
      int 21h
      ret
start endp
mycode ends
end start
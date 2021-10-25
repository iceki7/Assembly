.model small      ;冒泡排序
.stack
.data
      array db 56h,63h,37h,4eh,0b0h
      count equ ($-array)/type array
      var   equ 0
      varr  equ 'hello'
.code
.startup
      mov cx,count;CX:元素个数=5
      dec cx
      outlp:mov dx,cx
            mov bx,offset array
      inlp: mov al,[bx]
            cmp al,[bx+1] ;bx 数据指针
            jna next
            xchg al,[bx+1]
            mov [bx],al ;iceki
      next: inc bx
            dec dx
            jnz inlp    ;若非0，进行内层循环
            loop outlp
.exit 0
end

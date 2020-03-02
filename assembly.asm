;This Program can read multiple digits and add them to an array then check for each element if they can be divisable by Y, If so then add X to the original value, then print the array
jmp start
num1: db 0,0,0,0,0
ans: db 0,0,0,0,0
x: db 0
y: db 0
s1: db 'Enter array: $'      
s2: db 'Enter x: $'
s3: db 'Enter y: $' 
s4: db 'The array is : $'
linefeed: db 10, '$' 
space: db 32, '$' 

readnum: mov bx, 0
begin:  mov ah, 01h
        int 21h
        cmp al, 0dh ; 0dh is the ascii code for carriage return
        je next
        mov ah, 0
        sub al, 30h
        push ax
        mov ax, 10
        mul bx
        pop bx
        add bx, ax
        jmp begin
next:   ret

readarray:
    call readnum
    mov [di],bx
    add di,1
    call newline
    loop readarray
    ret
             
start: mov dx, s1
       mov ah, 09h
       int 21h
       mov cx,5
       mov di,num1
       call readarray 
       
       mov dx,s2
       mov ah,09h
       int 21h
       call readnum  
       call newline
       mov [x],bx
       
       mov dx,s3
       mov ah,09h
       int 21h
       call readnum 
       call newline
       mov [y],bx   
       
       
       mov si,num1
       mov cx,5  
       mov di,y
       mov bl,[di]   ;y
       mov di,x
       mov bh,[di] ;x
       call sum  
       

       mov dx, s4
       mov ah, 09h
       int 21h
                      
       mov si,num1 
       mov cx,5
       call printarray
          
       
       
       mov ax, 0x4c00 ;terminate program
       int 21h
       
printarray:
     mov al, [si]
     mov ah,0
     call writenum
     add si,1 
     call newspace
     loop printarray
     ret

sum:        
    mov al,[si]
    mov ah,0
    div bl    ; AL=AX/operand AH-> remainder
    cmp ah,0
    jne next2
    add [si],bh
next2: add si,1
       loop sum
       ret  
       
             
writenum: push cx
         mov bx, 10
          mov cx, 0
up: mov dx, 0
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne up
l1: pop dx
    add dl, 30h
    mov ah, 02h
    int 21h
    dec cx
    jnz l1
    pop cx
    ret     

newline: mov dx, linefeed
         mov ah, 09h
         int 21h
         ret
newspace: mov dx, space
         mov ah, 09h
         int 21h
         ret

[bits 16]
[org 0x7e00]


    xor ax,ax
    mov ds,ax
    mov bx,MS 
    call print_string


    jmp main

main:
    mov bx,buffer 

    mov ah, 0x0e
    mov al, 13
    int 0x10
    mov al, 10
    int 0x10
 
    push bx              
    mov bx, prompt
    call print_string
    pop bx   

.get_char:
    mov ah, 0x00
    int 0x16
    cmp al,13
    je .correct
    mov ah,0x0e
    int 0x10
    mov [bx],al
    inc bx
    jmp .get_char
.correct:
    mov byte [bx],0
    ;ver
    mov si,buffer
    mov di,cmd_ver
    call strcmp
    cmp ax,0
    je .ver
    mov bx, unknown
    call print_string
    jmp main 
;commands
.ver:
    mov bx, v_msg
    call print_string
    jmp main 

;func
strcmp:
.loop:
    mov al, [si]
    mov dl, [di]
    cmp al, dl
    jne .not_equal      
    cmp al, 0           
    je .equal
    inc si
    inc di
    jmp .loop
.not_equal:
    mov ax,1
    ret

.equal:
    xor ax,ax
    ret
print_string:       
    mov ah, 0x0e
.loop:
    mov al,[bx]
    cmp al,0
    je .done
    mov ah,0x0e
    int 0x10
    inc bx
    jmp .loop
.done:
    ret
;storage
prompt db 'DoomOS> ',0
buffer times 64 db 0
MS db 'Welcome to DoomOS', 13, 10, 0
v_msg  db 13, 10,'DoomOS 0.1', 13, 10, 0
unknown db 'This is not an executable command', 13, 10, 0
cmd_ver db '/ver',0
times 512-($-$$) db 0
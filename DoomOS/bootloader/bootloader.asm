[bits 16]
[org 0x7c00]
 
start: 
    cli 
    mov ax, 0x0000
    mov ss, ax
    mov bp, 0x7c00  
    mov sp, bp 
    sti
    cld 
    mov [BOOT_DRIVE], dl  
    mov bx, MS              
    call print_string 
    call load_kernel         
    jmp 0x0000:0x7e00 

load_kernel:
    mov ah, 0x02            
    mov al, 1             
    mov ch, 0x00            
    mov dh, 0x00            
    mov cl, 0x02            
    mov dl, [BOOT_DRIVE]    
    mov bx, 0x7e00
    int 0x13                
    jc disk_error           
    ret

disk_error:
    mov bx, ERROR
    call print_string
    jmp $

print_string:                
    mov ah, 0x0e
.loop:
    mov al, [bx]    
    cmp al, 0               
    je .done                
    int 0x10                
    inc bx               
    jmp .loop               
.done:
    ret               

BOOT_DRIVE db 0
MS db "Loading Kernel...", 13, 10, 0 
ERROR db "Disk Error!", 0

times 510-($-$$) db 0
dw 0xAA55

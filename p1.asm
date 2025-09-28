section .data
    promptD1 db "Enter a single digit: ",10,0    ;set aside space and define space for messages
    msg1 equ $ - promptD1 

    promptD2 db "Enter a single digit: ",10,0
    msg2 equ $ - promptD2

    Result db "Result : ",10,0
    msg3 equ $ - Result



section .bss
    digit1 resb 2           ;set aside space for digit1 and digit2 and total
    digit2 resb 2
    total resb 3

section .text
    GLOBAL _start

_start:
    mov eax, 4              ;set system to write and stdout to print promptD1
    mov ebx, 1
    mov ecx, promptD1
    mov edx, msg1
    int 0x80

    mov eax, 3              ;set system to read and stdin to take user input
    mov ebx, 0
    mov ecx, digit1
    mov edx, 2
    int 0x80

    mov eax, 4              ;set system to write and stdout to print promptD2
    mov ebx, 1
    mov ecx, promptD2
    mov edx, msg2
    int 0x80

    mov eax, 3              ;set system to read and stdin to take user input
    mov ebx, 0
    mov ecx, digit2
    mov edx, 2
    int 0x80

    mov al, [digit1]        ;convert from ASCII
    sub al, '0'
    mov bl, [digit2]
    sub bl, '0'

    add al, bl
    add a1, '0'             ;convert back to ASCII
    
    mov [total], al
    mov byte [total+1], 10
    mov byte [total+2], 0

    mov eax, 4              ;set system to write and stdout to print "Result: "
    mov ebx, 1
    mov ecx, Result
    mov edx, msg3
    int 0x80

    mov eax, 4              ;set system to write and stdout to print "total"
    mov eax, 1
    mov ecx, total
    mov edx, 2
    int 0x80


    mov eax, 1              ;End program
    xor ebx,ebx
    int 0x80
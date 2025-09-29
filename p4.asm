;William Ward | CSC-3410 | Assignment2 | 09/29/25

section .data 
    Title db "The Swapping Program",10
    msg equ $ - Title
    Message1 db "Please enter a two character string: ",10
    msg1 equ $ - Message1
    Message2 db "The answer is: "
    msg2 equ $ - Message2

    newline db 10,0

section .bss
    Inpt resb 3                 ;set aside for user inputed string

section .text
    GLOBAL _start

_start:

    mov eax, 4                  ;print the program title
    mov ebx, 1
    mov ecx, Title
    mov edx, msg
    int 0x80

    mov eax, 4                  ;print "Please enter a two character string"
    mov ebx, 1  
    mov ecx, Message1
    mov edx, msg1
    int 0x80

    mov eax, 3                  ;take user input
    mov ebx, 0
    mov ecx, Inpt
    mov edx, 3
    int 0x80

    lea esi, [Inpt]            ;swap bit at address with bit at address+1

    mov al, [esi]
    mov bl, [esi+1]
    mov [esi], bl
    mov [esi+1], al

    mov eax, 4                  ;print "The answer is"
    mov ebx, 1
    mov ecx, Message2
    mov edx, msg2
    int 0x80

    mov eax, 4                  ;print reversed string
    mov ebx, 1
    mov ecx, Inpt
    mov edx, 3
    int 0x80

    mov eax, 4                  ;add newline to match example output
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 1                  ;sys_quit
    int 0x80


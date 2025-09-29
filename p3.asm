;William Ward | CSC-3410 | Assignment2 | 09/29/25

section .data
    Title db "The Dividing Program",10
    msg equ $ - Title

    promptD1 db "Please enter a single digit number: ",10    ;set aside space and define space for messages
    msg1 equ $ - promptD1 

    promptD2 db "Please enter a single digit number: ",10
    msg2 equ $ - promptD2

    Result db "The quotient is: ",0
    msg3 equ $ - Result

    Result2 db "The remainder is: ",0
    msg4 equ $ -Result2

    newline db 10,0

section .bss
    digit1 resb 2           ;set aside space for digit1 and digit2 and total
    digit2 resb 2
    total resb 2
    total2 resb 2

section .text
    GLOBAL _start

_start:

    mov eax, 4          ;print title of program
    mov ebx, 1
    mov ecx, Title
    mov edx, msg
    int 0x80

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

    mov al, [digit1]        ;reduce to one bit
    mov[digit1], al

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

    mov al, [digit2]        ;reduce to one bit
    mov [digit2], al

    mov al, [digit1]        ;convert from ascii
    sub al, '0'
    mov bl, [digit2]
    sub bl, '0'

    idiv bl                 ;one parameter integer division

    add al, '0'
    mov [total], al         ;converting back to ascii --of quotient and remainder

    add ah, '0'
    mov [total2], ah

    mov eax, 4              ;set system to write and stdout to print "Result: "
    mov ebx, 1
    mov ecx, Result
    mov edx, msg3
    int 0x80

    mov eax, 4              ;set system to write and stdout to print "total"
    mov ebx, 1
    mov ecx, total
    mov edx, 1
    int 0x80

    mov eax, 4              ;newline to match example output
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 4              ;print "the remainder is: "
    mov ebx, 1
    mov ecx, Result2
    mov edx, msg4
    int 0x80

    mov eax, 4              ;print the remainder
    mov ebx, 1
    mov ecx, total2
    mov edx, 1
    int 0x80

    mov eax, 4              ;newline to match example output
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80


    mov eax, 1              ;End program
    int 0x80
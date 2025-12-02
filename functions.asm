; William Ward | Functions for C Palindrome file | 12/01/25

section .data                           ;my messages
    msg1 db "Enter a string: ", 0
    len1 equ $ - msg1

    msg2 db "It is a palindrome!", 0
    len2 equ $ -msg2

    msg3 db "It is NOT a palindrome!", 0
    len3 equ $ - msg3

section .bss
    input resb 256          ;buffer for user input

section .text
    global is_palindromeASM,factstr,addstr,palindrome_check

    ;extern calls

    extern is_palindromeC
    extern printf
    extern fgets
    extern strlen
    extern atoi
    extern stdin
    extern fact

addstr:         ;convert strings to ints
    ;lets start
    push ebp
    mov ebp,esp
    push ebx

    ;first argument
    mov eax, [ebp+8]
    push eax
    call atoi
    add esp, 4
    mov ebx, eax

    ;repeat for second
    mov eax, [ebp+12]
    push eax
    call atoi
    add esp,4

    add eax, ebx ;add two numbers and store in eax

    pop ebx
    pop ebp
    ret


is_palindromeASM:

    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    mov esi, [ebp+8]    ;find string

    push esi
    call strlen ;get length
    add esp, 4

    mov ecx, eax        ;if it is empty then it must be a palindrome. so check and maybe jump
    test ecx, ecx
    jz .is_palindrome

    mov edi, esi
    add esi, eax
    dec esi

    shr ecx,1               ;math
    jz .is_palindrome

.main_loop:                 ;work through both ends and check if equal after dec/inc
    mov al, [edi]
    mov bl, [esi]
    cmp al,bl
    jne .not_palindrome

    inc edi
    dec esi
    loop .main_loop

.is_palindrome:
    mov eax,1
    jmp .end

.not_palindrome:
    xor eax,eax
    jmp .end


.end:
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

factstr:            ;convert string to into and call C fact()
    push ebp
    mov ebp, esp

    mov eax, [ebp+8]
    push eax
    call atoi
    add esp,4

    push eax
    call fact
    add esp,4

    pop ebp
    ret

;C function calls

palindrome_check:       ;take string and call C palindrome check()
    push ebp
    mov ebp, esp
    sub esp, 4

    push msg1
    call printf
    add esp,4
    mov eax, [stdin]

    push eax
    push 256
    push input
    call fgets
    add esp,12

    test eax,eax
    jz .end

    push input
    call strlen
    add esp,4

    test eax, eax
    jz .end

    mov ebx, input
    add ebx, eax
    dec ebx
    cmp byte [ebx], 0x0A
    jne .check_palindrome
    mov byte [ebx], 0

.check_palindrome:
    push input
    call is_palindromeC
    add esp,4

    test eax,eax
    jz .not_palindrome

    push msg2
    call printf
    add esp, 4
    jmp .end

.not_palindrome:
    push msg3
    call printf
    add esp,4

.end:
    pop ebx
    mov esp, ebp
    pop ebp
    ret
%include "../utils/printf32.asm"

section .data
    mystring db "This is my string", 0
    fmt_str db "[before]: %s\n[after]: ", 0
    store_string times 64 db 0

section .text
extern puts
extern printf
global main
global reverse_string

main:
    push ebp
    mov ebp, esp

    mov eax, mystring
    xor ecx, ecx
count_loop:
    mov bl, [eax]
    test bl, bl
    je length_done
    inc eax
    inc ecx
    jmp count_loop

length_done:
    push ecx
    push mystring
    push fmt_str
    call printf
    add esp, 8
    pop ecx

    push store_string
    push ecx
    push mystring
    call reverse_string
    add esp, 12

    push store_string
    call puts
    add esp, 4

    leave
    ret

reverse_string:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, [ebp + 8] ; eax=src
    mov ecx, [ebp + 12]
    add eax, ecx
    sub eax, 1

    mov edx, [ebp + 16]

copy_one_byte:
    mov bl, [eax]
    mov [edx], bl
    dec eax
    inc edx
    loop copy_one_byte

    mov byte [edx], 0 ; terminatorul

    pop ebx
    leave
    ret
%include "printf32.asm"

%define ARRAY_LEN 7

section .data

input dd 122, 184, 199, 242, 263, 845, 911
output times ARRAY_LEN dd 0

section .text

extern printf
global main
main:
    push ARRAY_LEN
    xor ecx, ecx

push_elem:
    push dword[input + 4 * ecx]
    add ecx, 1
    cmp ecx, ARRAY_LEN
    jb push_elem
    xor ecx, ecx

pop_elem:
    pop dword[output + 4 * ecx]
    add ecx, 1
    cmp ecx, ARRAY_LEN
    jb pop_elem
    xor ecx, ecx

print_array:
    mov edx, [output + 4 * ecx]
    PRINTF32 `%d\n\x0`, edx
    inc ecx
    cmp ecx, ARRAY_LEN
    jb print_array
    add esp, 4
    xor eax, eax
    ret

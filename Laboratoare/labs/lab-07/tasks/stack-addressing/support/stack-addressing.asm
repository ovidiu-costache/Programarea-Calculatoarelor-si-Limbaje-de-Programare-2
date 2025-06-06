%include "printf32.asm"

%define NUM 5

section .text

extern printf
global main
main:
    mov ebp, esp

    ; TODO 1: replace every push by an equivalent sequence of commands (use direct addressing of memory. Hint: esp)
    mov ecx, NUM
push_nums:
    sub esp, 4
    mov [esp], ecx
    loop push_nums

    sub esp, 4
    mov [esp], 0
    sub esp, 4
    mov [esp], "corn"
    sub esp, 4
    mov [esp], "has "
    sub esp, 4
    mov [esp], "Bob "

    lea esi, [esp]
    PRINTF32 `%s\n\x0`, esi

    mov eax, ebp

print_stack:
    PRINTF32 `0x%x: 0x%x\n\x0`, eax, [eax]

    sub eax, 4
    cmp eax, esp
    jge print_stack

    ; Print the string.
    lea esi, [esp]
    PRINTF32 `%s\n\x0`, esi

    ; Print the array.
    add esp, 16
    mov eax, esp
    
print_array:
    PRINTF32 `%d \x0`, [eax]

    add eax, 4
    cmp eax, ebp
    jl print_array
    PRINTF32 `\n\x0`

    ; Restore the previous value of the EBP (Base Pointer).
    mov esp, ebp

    ; Exit without errors.
    xor eax, eax
    ret

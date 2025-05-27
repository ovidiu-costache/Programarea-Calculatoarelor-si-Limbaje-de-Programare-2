section .text
global check_palindrome
global composite_palindrome

check_palindrome:
    ; create a new stack frame
    enter 0, 0

    push eax
    push ebx
    push ecx
    push edx

    ; adresa stringului
    mov eax, [ebp + 8]
    ; lungimea stringului
    mov ebx, [ebp + 12]

    ; verific daca stringul este NULL
    cmp eax, 0
    je fals

    ; verific daca lungimea este 0
    cmp ebx, 0
    je corect
    ; verific daca lungimea este 1
    cmp ebx, 1
    je corect

    ; setez ecx = index stanga = 0
    mov ecx, 0
    mov edx, ebx
    ; index dreapta = lungime - 1
    sub edx, 1

palindrom_loop:
    cmp ecx, edx
    jge corect

    ; bl = caracterul de pe poz ecx, adica stanga
    mov bl, [eax + ecx]
    ; bh = caracterul de pe poz edx, adica dreapta
    mov bh, [eax + edx]

    ; compar caracterele
    cmp bl, bh
    jne fals

    ; incrementez stanga si decrementez dreapta
    inc ecx
    dec edx
    jmp palindrom_loop

corect:
    pop edx
    pop ecx
    pop ebx
    pop eax

    ; returnez 1 prin eax daca este palindorm
    mov eax, 1
    leave
    ret

fals:
    pop edx
    pop ecx
    pop ebx
    pop eax

    ; nu este palindorm
    mov eax, 0
    leave
    ret

composite_palindrome:
    ; create a new stack frame
    enter 0, 0
    xor eax, eax
    leave
    ret


%include "../include/io.mac"

extern printf
global base64

section .data
    alphabet db 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
    fmt db "%d", 10, 0

section .text

base64:
    ;; DO NOT MODIFY

    push ebp
    mov ebp, esp
    pusha

    mov esi, [ebp + 8] ; source array
    mov ebx, [ebp + 12] ; n
    mov edi, [ebp + 16] ; dest array
    mov edx, [ebp + 20] ; pointer to dest length

    ;; DO NOT MODIFY

    ; -- Your code starts here --
    
    ; salvez pointerul la lungimea dest pe stiva ca sa pot folosi registrul si pt alte calcule
    push edx

    ; calculez nr de grupuri: grupuri = n / 3
    mov eax, ebx ; eax = n
    xor edx, edx ; il fac zero
    mov ecx, 3 ; divizorul
    div ecx ; eax = n / 3

    mov ecx, eax ; cnt pt bucla este egal cu nr de grupuri

    ; calculez lungimea sirului encodat = grupuri * 4
    mov eax, ecx
    shl eax, 2 ; inmultesc cu 4 shiftand la stanga

    pop edx ; il scot de pe stiva

    mov [edx], eax ; ptr_len = grupuri * 4

base64_loop:
    ; procesez fiecare grup de 3 octeti
    cmp ecx, 0 ; daca mai sunt grupuri
    je end

    ; iau primul octet si il mut pe cea mai semnificativa poz
    xor eax, eax
    mov al, byte [esi] ; al = primul octet
    shl eax, 16 ; deplasez octetul la poz 16 pt a-l poztionat pe 24 de biti

    ; acum iau al doilea octet
    xor ebx, ebx
    mov bl, byte [esi+1] ; bl = al doilea octet
    shl ebx, 8 ; pctetul ajunge pe poz 8-15
    or eax, ebx ; combin primul si al doilea octet in eax

    ; iau al treila octet
    xor ebx, ebx
    mov bl, byte [esi+2] ; bl = al treilea octet
    or eax, ebx ; acum eax contine cei 24 de biti

    ; extrag primul grup de 6 biti: eax>>18
    mov ebx, eax ; fac copie lui eax
    shr ebx, 18
    mov edx, 63
    and ebx, edx ; extrag 6 biti
    mov bl, [alphabet + ebx] ; caracterul corespunzator din alfabet
    mov [edi], bl ; scriu caracterul in target
    inc edi

    ; extrag al doilea grup: eax>>12
    mov ebx, eax
    shr ebx, 12
    mov edx, 63
    and ebx, edx
    mov bl, [alphabet + ebx]
    mov [edi], bl
    inc edi

    ; extrag al treilea grup: eax>>6
    mov ebx, eax
    shr ebx, 6
    mov edx, 63
    and ebx, edx
    mov bl, [alphabet + ebx]
    mov [edi], bl
    inc edi

    ; extrag al patrulea grup
    mov ebx, eax
    mov edx, 63
    and ebx, edx
    mov bl, [alphabet + ebx]
    mov [edi], bl
    inc edi

    add esi, 3 ; avansez 3 octeti pt urm grup
    dec ecx
    jmp base64_loop

    ; -- Your code ends here --

end:
    ;; DO NOT MODIFY

    popa
    leave
    ret

    ;; DO NOT MODIFY

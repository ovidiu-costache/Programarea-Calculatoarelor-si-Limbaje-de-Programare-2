section .text
global kfib

kfib:
    ; create a new stack frame
    enter 0, 0

    ; pun pe stiva registrii cu care voi lucra
    push ebx
    push esi
    push edi

    ; primul parametru "n", de la adresa [ebp + 8]
    mov esi, [ebp + 8]
    ; parametrul "k" de la adresa [ebp + 12]
    mov edi, [ebp + 12]

    ; compar n cu k
    cmp esi, edi
    jl return_zero
    je return_one

    ; folosesc ebx pt suma
    xor ebx, ebx
    ; ecx va avea valoarea curenta a indexului
    mov ecx, 1

sum_loop:
    ; verific daca am depasit nr de termeni k
    cmp ecx, edi
    jg done

    push ecx
    push edi

    ; calculez n-i pt apelul recursiv
    mov eax, esi
    sub eax, ecx

    ; apelez functia cu noii parametri
    ; parametrii sunt pusi pe stiva in ordinea: k, n-i
    push edi
    push eax
    call kfib

    ; sterg parametrii de pe stiva (2 parametrii * 4 bytes)
    add esp, 8

    pop edi
    pop ecx
    ; adaug rezultatul apelului la suma
    ; eax are rezultatul si in ebx e suma
    add ebx, eax
    inc ecx

    jmp sum_loop

return_zero:
    ; cazul n < k
    xor eax, eax
    jmp end

return_one:
    ; cazul n == k
    mov eax, 1
    jmp end

done:
    ; mut suma
    mov eax, ebx

end:
    pop edi
    pop esi
    pop ebx

    leave
    ret


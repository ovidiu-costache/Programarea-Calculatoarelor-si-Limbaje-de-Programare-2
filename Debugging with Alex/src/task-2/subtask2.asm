%include "../include/io.mac"

; declare your structs here
struc date
    .day: resb 1 ; 1 byte
    .month: resb 1 ; 1 byte
    .year: resw 1 ; 2 bytes
endstruc

struc event
    .name: resb 31 ; 31 bytes
    .valid: resb 1 ; 1 byte
    .date_field: resb 4 ; 4 bytes 
endstruc

section .text
    global sort_events
    extern printf

sort_events:
    ;; DO NOT MODIFY
    enter 0, 0
    pusha

    mov ebx, [ebp + 8]      ; events
    mov ecx, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here

    ; voi muta elementele cu validitate 1 la inceput si pe cele cu 0 la final
    ; apoi voi parcurge cei doi vectori si ii voi sorta dupa an, luna, zi
    mov esi, ebx ; esi pointer pt parcurgerea vectorului
    mov edi, ebx ; edi pointer pt inserarea elem cu validitate 1
    mov eax, ecx ; eax contor pt nr de evenimente

partition:
    cmp byte [esi + event.valid], 1 ; compar campul valid cu 1
    jne next_element
    cmp esi, edi ; daca elem curent este la poz corecta
    je skip_swap ; nu fac swap
    pusha ; urc pe stiva registrele inainte de swap

    ; calculez nr de dwords din event
    mov ecx, event_size/4 ; iterez de 9 ori pt a copia intreaga structura de 4 bytes

swap_partition:
    mov eax, [esi]
    mov edx, [edi]
    mov [edi], eax
    mov [esi], edx
    add esi, 4 ; avansez cu 4 bytes
    add edi, 4
    dec ecx
    cmp ecx, 0
    jne swap_partition ; repet swap-ul de 9 ori
    popa ; recuperez registrele de pe stiva

skip_swap:
    add edi, event_size

next_element:
    add esi, event_size ; trec la urm elem din vector
    dec eax ; scad contorul
    jnz partition ; repet pt toate elem

    ; calculez cate elem au validitate 1
    mov eax, edi ; eax va fi adresa finala a sectiunii cu elem valide
    sub eax, ebx
    xor edx, edx
    mov ecx, event_size ; ecx = dimensiunea unui element
    div ecx ; eax = nr de bytes ocupati / EVENT_SIZE = nr de evenimente cu validitate 1
    push eax

    ; sortez elem cu validitate 1
    mov ecx, eax ; nr de evenimente cu validitate 1
    dec ecx ; nr de iteratii pt bucla exetrna

valid1_out:
    xor edx, edx ; index pt bucla interioara
    mov esi, ebx ; pointer la primul elem din zona cu validitate 1

valid1_in:
    mov edi, esi
    add edi, event_size ; pointer la evenimentul urmator

    ; compar anul
    mov ax, [esi + event.date_field + date.year]
    cmp ax, [edi + event.date_field + date.year]
    jb no_swap1 ; ordine corecta
    ja swap1

    ; daca anul este egal, compar luna
    mov al, [esi + event.date_field + date.month]
    cmp al, [edi + event.date_field + date.month]
    jb no_swap1
    ja swap1

    ; daca luna este egala, compar ziua
    mov al, [esi + event.date_field + date.day]
    cmp al, [edi + event.date_field + date.day]
    jb no_swap1

swap1:
    pusha
    mov ecx, event_size/4

swap_loop1:
    mov eax, [esi] ; primul eveniment
    mov edx, [edi] ; al doilea eveniment
    mov [esi], edx
    mov [edi], eax
    add esi, 4
    add edi, 4
    dec ecx
    cmp ecx, 0
    jne swap_loop1
    popa

no_swap1:
    add esi, event_size ; trec la urmatorul eveniment
    inc edx ; creste indexul buclei interioare
    cmp edx, ecx ; daca nu s-au parcurs toate comparatiile
    jl valid1_in
    dec ecx
    cmp ecx, 0
    jne valid1_out

valid0:
    ; sortez evenimentele cu validitate 0
    pop eax ; recuperez nr de evenim cu validitate 1
    mov edx, [ebp + 12] ; nr total de evenimente
    sub edx, eax ; nr de evenim cu validitate 0
    cmp edx, 1
    jbe end_sort

    mov esi, ebx ; inceputul vectorului cu valid 0
    mov ecx, eax ; ecx o sa fie valid_count
    imul ecx, event_size ; ecx inceputul zonei cu validitate 0
    add esi, ecx ; adresa primului evenim cu valid 0
    mov ecx, edx ; nr de evenim cu valid 0
    dec ecx ; pt bucla exterioara

valid0_out:
    xor edx, edx
    mov edi, esi ; pointer la primul elem cu valid 0

valid0_in:
    mov eax, edi
    add eax, event_size ; urm evenim

    ; compar anul
    mov bx, [edi + event.date_field + date.year]
    cmp bx, [eax + event.date_field + date.year]
    jb no_swap0
    ja swap0

    ; compar luna
    mov bl, [edi + event.date_field + date.month]
    cmp bl, [eax + event.date_field + date.month]
    jb no_swap0
    ja swap0

    ; compar ziua
    mov bl, [edi + event.date_field + date.day]
    cmp bl, [eax + event.date_field + date.day]
    jb no_swap0

swap0:
    pusha
    mov ecx, event_size/4

swap_loop0:
    mov ebx, [edi]
    mov edx, [eax]
    mov [edi], edx
    mov [eax], ebx
    add edi, 4
    add eax, 4
    dec ecx
    cmp ecx, 0
    jne swap_loop0
    popa

no_swap0:
    add edi, event_size
    inc edx
    cmp edx, ecx
    jl valid0_in
    dec ecx
    cmp ecx, 0
    jne valid0_out

    ;; Your code ends here

end_sort:
    ;; DO NOT MODIFY
    popa                        ; Restaureaza registrii
    leave                       ; Elibereaza cadrul stivei
    ret
    ;; DO NOT MODIFY

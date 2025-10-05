%include "../include/io.mac"

; declare your structs here
struc date
    .day: resb 1 ; 1 byte
    .month: resb 1 ; 1 byte
    .year: resw 1 ; 2 bytes
ensdtruc

struc event
    .name: resb 31 ; 31 bytes
    .valid: resb 1 ; 1 byte
    .date_field: resb 4 ; 4 bytes 
endstruc

section .data

section .text
    global check_events
    extern printf

check_events:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov ebx, [ebp + 8]      ; events
    mov ecx, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here

check_loop:
    cmp ecx, 0
    je check_end

    ; setez valid ca zero
    mov byte [ebx + event.valid], 0

    ; verific daca anul este valid
    ; anul se afla in event, in date_field + 2, ca sa sara peste zi si luna
    ; folosesc ax pt a stoca 2 bytes si a nu ma complica cu movzx etc
    mov ax, word [ebx + event.date_field + date.year]
    cmp ax, 1990
    jb invalid
    cmp ax, 2030
    ja invalid

    ; verific daca luna este valida
    ; luna se afala in event, in date_filed + 1, ca sa sar peste zi
    ; folosesc al pt a stoca 1 byte
    mov al, byte [ebx + event.date_field + date.month]
    cmp al, 1
    jb invalid
    cmp al, 12
    ja invalid

    ; stabilesc ultima zi valida, iar implicit este 31
    mov dl, 31
    cmp al, 2
    je february ; cazul special in care februarie are doar 28 de zile
    ; verific pt lunile cu 30 de zile
    cmp al, 4
    je month_30days
    cmp al, 6
    je month_30days
    cmp al, 9
    je month_30days
    cmp al, 11
    je month_30days

    ; luna are 31 de zile
    jmp check_day

february:
    mov dl, 28
    jmp check_day

month_30days:
    mov dl, 30

check_day:
    mov al, byte [ebx + event.date_field] ; verific ziua
    cmp al, 1
    jb invalid
    cmp al, dl
    ja invalid

    ; daca se ajunge pana aici, toate conditiile sunt indeplinite
    mov byte [ebx + event.valid], 1
    jmp next_event

invalid:
    mov byte [ebx + event.valid], 0

next_event:
    add ebx, event_size
    dec ecx
    jmp check_loop

    ;; Your code ends here

check_end:
    ;; DO NOT MODIFY

    popa
    leave
    ret

    ;; DO NOT MODIFY

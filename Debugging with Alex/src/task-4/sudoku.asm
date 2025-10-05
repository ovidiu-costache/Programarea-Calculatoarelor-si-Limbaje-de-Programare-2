%include "../include/io.mac"

extern printf
global check_row
global check_column
global check_box
; you can declare any helper variables in .data or .bss

section .bss
    freq_row resb 9 ; vector de frecventa din check_row
    freq_col resb 9 ; "--" din check_column
    freq_box resb 9 ; "--" din check_box

section .text

; int check_row(char* sudoku, int row);
check_row:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov     esi, [ebp + 8]  ; char* sudoku, pointer to 81-long char array
    mov     edx, [ebp + 12] ; int row
    ;; DO NOT MODIFY

    ;; Freestyle starts here

    ; calculez adresa de inceput a liniei = row * 9
    mov eax, edx ; eax = row
    imul eax, 9 ; eax = row * 9
    add esi, eax ; esi pointer la inceputul liniei

    mov ebx, freq_row

    ; urmeaza sa initializez vectorul de frecventa cu zero
    mov ecx, 9
    mov edi, ebx ; vectorul de frecventa
    xor eax, eax

row_loop:
    mov byte [edi], al
    inc edi
    dec ecx
    cmp ecx, 0
    jne row_loop

    ; parcurg cele 9 celule ale liniei
    mov ecx, 9 ; cnt pentru celule

row_freq:
    cmp ecx, 0
    je end_row

    ; calculez indexul din cifra din celula curenta
    xor eax, eax
    mov al, byte [esi] ; valoarea celulei
    cmp al, 1
    jl row2
    cmp al, 9
    jg row2
    sub al, 1 ; al = valoare - 1
    inc byte [ebx + eax] ; incrementez vectorul la poz calculata
    cmp byte [ebx + eax], 1
    jg row2
    inc esi ; trec la urmatoarea celula
    dec ecx
    jmp row_freq

end_row:
    ; verific vectorul de frecventa
    mov ecx, 9
    mov edi, ebx

check_row_freq:
    cmp ecx, 0
    je row1
    cmp byte [edi], 1
    jne row2
    inc edi
    dec ecx
    jmp check_row_freq

row1:
    mov eax, 1 ; linie corecta
    jmp end_check_row

row2:
    mov eax, 2 ; linie gresita
    jmp end_check_row

	;; MAKE SURE TO LEAVE YOUR RESULT IN EAX BY THE END OF THE FUNCTION
    ;; Remember: OK = 1, NOT_OKAY = 2
    ;; ex. if this row is okay, by this point eax should contain the value 1 

    ;; Freestyle ends here

end_check_row:
    ;; DO NOT MODIFY

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    leave
    ret

	;; DO NOT MODIFY

; int check_column(char* sudoku, int column);
check_column:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov     esi, [ebp + 8]  ; char* sudoku, pointer to 81-long char array
    mov     edx, [ebp + 12] ; int column
    ;; DO NOT MODIFY

    ;; Freestyle starts here

    ; adresa celulei este sudoku + column
    add esi, edx

    mov ebx, freq_col

    ; urmeaza sa initializez vectorul de frecventa cu zero
    mov ecx, 9
    mov edi, ebx
    xor eax, eax

col_loop:
    mov byte [edi], al
    inc edi
    dec ecx
    cmp ecx, 0
    jne col_loop

    ; parcurg celulele de pe coloana
    mov ecx, 9

col_freq:
    cmp ecx, 0
    je end_col
    xor eax, eax
    mov al, byte [esi] ; valoarea celulei
    cmp al, 1
    jl col2
    cmp al, 9
    jg col2
    sub al, 1
    inc byte [ebx + eax]
    cmp byte [ebx + eax], 1
    jg col2
    add esi, 9 ; trec la celula de pe urmatorul rand
    dec ecx
    jmp col_freq

end_col:
    mov ecx, 9
    mov edi, ebx

check_col_freq:
    cmp ecx, 0
    je col1
    cmp byte [edi], 1
    jne col2
    inc edi
    dec ecx
    jmp check_col_freq

col1:
    mov eax, 1 ; coloana corecta
    jmp end_check_column

col2:
    mov eax, 2 ; coloana gresita
    jmp end_check_column

	;; MAKE SURE TO LEAVE YOUR RESULT IN EAX BY THE END OF THE FUNCTION
    ;; Remember: OK = 1, NOT_OKAY = 2
    ;; ex. if this column is okay, by this point eax should contain the value 1 

    ;; Freestyle ends here

end_check_column:
    ;; DO NOT MODIFY

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    leave
    ret

	;; DO NOT MODIFY

; int check_box(char* sudoku, int box);
check_box:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov     esi, [ebp + 8]  ; char* sudoku, pointer to 81-long char array
    mov     edx, [ebp + 12] ; int box
    ;; DO NOT MODIFY

    ;; Freestyle starts here

    ; calculez coordonatele de start pentru caseta
    ; row_start = (box / 3) * 3 , col_start = (box % 3) * 3
    mov eax, [ebp + 12] ; eax = box
    mov ecx, 3
    xor edx, edx
    div ecx ; eax = box/3 si edx = box % 3
    mov ecx, eax ; ecx = box/3
    imul ecx, 3 ; ecx = row_start
    mov ebx, edx ; ebx = box % 3
    imul ebx, 3 ; ebx = col_start

    ; calculez indicele casetei = (row_start * 9) + col_start
    mov eax, ecx ; eax = row_start
    imul eax, 9
    add eax, ebx ; eax = indice
    add esi, eax ; esi pointer la celula din stanga sus a casetei

    mov ebx, freq_box

    ; urmeaza sa initializez vectorul de frecventa cu zero
    mov ecx, 9
    mov edi, ebx
    xor eax, eax

box_loop:
    mov byte [edi], al
    inc edi
    dec ecx
    cmp ecx, 0
    jne box_loop

    ; parcurg cele 9 celule din caseta
    mov ecx, 3 ; contor pt randuri, o caseta are 3 randuri 3 coloane

box_row:
    mov edx, 3 ; contor pt celule pe rand

box_cell:
    cmp edx, 0
    je box_next_row
    xor eax, eax
    mov al, byte [esi] ; cifra din celula curenta
    cmp al, 1
    jl box2
    cmp al, 9
    jg box2
    sub al, 1
    inc byte [ebx + eax]
    cmp byte [ebx + eax], 1
    jg box2
    inc esi
    dec edx
    jmp box_cell

box_next_row:
    ; dupa ce am verificat 3 celule dintr-un rand, adaug 6 pentru a ajunge la inceputul
	; randului urmator al casetei (un rand de sudoku are 9 celule - 3 din caseta = 6)
    add esi, 6
    dec ecx
    cmp ecx, 0
    jne box_row

    ; verific daca fiecare element din vector este 1
    mov ecx, 9
    mov edi, ebx

check_box_freq:
    cmp ecx, 0
    je box1
    cmp byte [edi], 1
    jne box2
    inc edi
    dec ecx
    jmp check_box_freq

box1:
    mov eax, 1
    jmp end_check_box

box2:
    mov eax, 2
    jmp end_check_box

	;; MAKE SURE TO LEAVE YOUR RESULT IN EAX BY THE END OF THE FUNCTION
    ;; Remember: OK = 1, NOT_OKAY = 2
    ;; ex. if this box is okay, by this point eax should contain the value 1 

    ;; Freestyle ends here

end_check_box:
    ;; DO NOT MODIFY

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    leave
    ret

 	;; DO NOT MODIFY

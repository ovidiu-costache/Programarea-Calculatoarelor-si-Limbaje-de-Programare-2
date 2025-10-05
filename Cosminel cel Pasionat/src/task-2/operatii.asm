section .text
global sort
global get_words
global compare

extern qsort
extern strcmp

;; sort(char **words, int number_of_words, int size)
;  functia va trebui sa apeleze qsort pentru soratrea cuvintelor 
;  dupa lungime si apoi lexicografix
sort:
    ; create a new stack frame
    enter 0, 0
    ; salvez ebx pe stiva pt apel
    push ebx

    ; trebuie incarcati parametrii pt qsort
    ; adresa functiei de comparare pt qsort
    push dword compare
    ; dimensiunea unui elem
    push dword [ebp + 16]
    ; nr de cuvinte
    push dword [ebp + 12]
    ; adresa vectorului de cuvinte
    push dword [ebp + 8]

    call qsort
    ; sterg parametrii de pe stiva
    add esp, 16
    pop ebx

    leave
    ret

compare:
    ; create a new stack frame
    enter 0, 0
    push ebx
    push esi
    push edi

    ; primul parametru este adresa pointerului la cuvant
    mov eax, [ebp + 8]
    mov eax, [eax]
    ; al doilea cuvant
    mov ebx, [ebp + 12]
    mov ebx, [ebx]

    ; calculez lungimea primului cuvant
    xor ecx, ecx

len1:
    ; sfarsitul cuvantului
    cmp byte [eax + ecx], 0
    je len1_stop
    inc ecx
    jmp len1

len1_stop:
    ; lungimea
    mov edx, ecx

    ; calculez lungimea ccuvantului 2
    xor ecx, ecx

len2:
    ; sfarsitul cuvantului
    cmp byte [ebx + ecx], 0
    je len2_stop
    inc ecx
    jmp len2

len2_stop:
    ; lungimea
    mov esi, ecx

cmp_len:
    cmp edx, esi
    jne different

    ; daca lungimile sunt egale, compar alfabetic
    ; al doilea cuvant
    push ebx
    ; primul
    push eax
    call strcmp
    ; sterg de pe stiva
    add esp, 8
    jmp cmp_end

different:
    sub edx, esi
    mov eax, edx

cmp_end:
    pop edi
    pop esi
    pop ebx

    leave
    ret

;; get_words(char *s, char **words, int number_of_words)
;  separa stringul s in cuvinte si salveaza cuvintele in words
;  number_of_words reprezinta numarul de cuvinte
get_words:
    ; create a new stack frame
    enter 0, 0
    push ebx
    push esi
    push edi

    ; esi pointer la sirul sursa
    mov esi, [ebp + 8]
    ; ebx vectorul words
    mov ebx, [ebp + 12]
    ; edi cnt pt nr de cuvinte gasite
    xor edi, edi

skip:
    ; caracterul curent are un byte si il pun in al
    mov al, [esi]
    ; daca s-a ajuns la sfarsitul sirului
    cmp al, 0
    je done

    ; verific daca caracterul curent este delimitator
    ; daca e spatiu
    cmp al, ' '
    je delim

    ; daca e virgula
    cmp al, ','
    je delim

    ; daca e punct
    cmp al, '.'
    je delim

    ; compar cu newline
    ; daca scriu newline ca '\n', primesc warning
    ; operatii.asm:141: warning: byte data exceeds bounds [-w+number-overflow]
    cmp al, 10
    je delim

    ; daca nu e delimitator
    jmp start

delim:
    inc esi
    jmp skip

start:
    ; salvez adresa cuvantului in vector
    mov [ebx + edi * 4], esi

find_end:
    inc esi
    mov al, [esi]

    ; verific sfarsitul sirului
    cmp al, 0
    je end_string

    ; verific daca este delimitator
    cmp al, ' '
    je replace
    cmp al, ','
    je replace
    cmp al, '.'
    je replace
    ; compar cu newline
    ; daca scriu newline ca '\n', primesc warning
    ; operatii.asm:170: warning: byte data exceeds bounds [-w+number-overflow]
    cmp al, 10
    je replace

    jmp find_end

replace:
    ; pun NULL
    mov byte [esi], 0
    inc esi

end_string:
    inc edi
    ; verific daca am ajuns la nr de cuvinte
    cmp edi, [ebp + 16]
    jl skip

done:
    pop edi
    pop esi
    pop ebx

    leave
    ret


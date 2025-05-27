section .text
global sort

;   struct node {
;    int val;
;    struct node* next;
;   };

;; struct node* sort(int n, struct node* node);
;   The function will link the nodes in the array
;   in ascending order and will return the address
;   of the new found head of the list
; @params:
;   n -> the number of nodes in the array
;   node -> a pointer to the beginning in the array
;   @returns:
;   the address of the head of the sorted list
sort:
    ; create a new stack frame
    enter 0, 0
    xor eax, eax
    pusha

    ; ecx = n, numarul de noduri
    mov ecx, [ebp + 8]

    ; edx = adresa vectorului de noduri
    mov edx, [ebp + 12]

    ; verific daca n <= 1
    cmp ecx, 1
    jle first_case

    ; ebx = val curenta de cautat, incepand de la 1
    mov ebx, 1

bubble:
    cmp ebx, ecx
    jg head_start

    ; caut nodul cu val curenta
    xor eax, eax

curr_node:
    ; astea pot fi sterse
    cmp eax, ecx
    jge bubble

    ; valoarea nodului curent
    mov edi, [edx + eax * 8]

    cmp edi, ebx
    je curr_node_found

    inc eax
    jmp curr_node

curr_node_found:
    ; calculez adresa nodului curent
    mov ebp, eax
    ; calculez adresa nodului curent
    imul ebp, 8
    add ebp, edx
    mov esi, ebp

    ; calculez valoarea urmatoare, k+1
    mov eax, ebx
    inc eax

    cmp eax, ecx
    jg no_next

    ; salvez k+1 in edi
    mov edi, eax
    xor eax, eax

next_node:
    cmp eax, ecx
    jge no_next

    ; valoarea nodului curent
    mov ebp, [edx + eax * 8]
    cmp ebp, edi
    je next_node_found

    inc eax
    jmp next_node

next_node_found:
    mov ebp, eax
    ; calculez adresa nodului urmator
    imul ebp, 8
    add ebp, edx

    ; leg nodul curent de urmatorul
    mov [esi + 4], ebp

no_next:
    inc ebx
    jmp bubble

head_start:
    xor eax, eax

head:
    cmp eax, ecx
    jge final

    ; valoarea nodului curent
    mov edi, [edx + eax * 8]

    ; compar cu 1
    cmp edi, 1
    je head_found

    inc eax
    jmp head

head_found:
    ; copiez indexul in ebx
    mov ebx, eax

    ; inmultesc cu 8 ca sa obtin dimensiunea
    imul ebx, 8
    ; adaug la baza vectorului ca sa pbtin adresa
    add ebx, edx
    ; adresa rezultat se salveaza in eax
    mov eax, ebx

    ; salvez in poz de rezultat
    mov [esp + 28], eax
    jmp final

first_case:
    ; e doar un nod, ii returnez adresa
    mov eax, edx
    ; salvez in pozitia rezultat
    mov [esp + 28], eax

final:
    popa
    leave
    ret


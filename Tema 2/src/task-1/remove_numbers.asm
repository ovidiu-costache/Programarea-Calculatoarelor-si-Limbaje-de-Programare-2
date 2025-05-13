%include "../include/io.mac"

extern printf
global remove_numbers

section .data
	fmt db "%d", 10, 0

section .text

; function signature: 
; void remove_numbers(int *a, int n, int *target, int *ptr_len);

remove_numbers:
	;; DO NOT MODIFY
	push    ebp
	mov     ebp, esp
	pusha

	mov     esi, [ebp + 8] ; source array
	mov     ebx, [ebp + 12] ; n
	mov     edi, [ebp + 16] ; dest array
	mov     edx, [ebp + 20] ; pointer to dest length

	;; DO NOT MODIFY

	push edx ; pun pointerul pt ptr_len pe stiva

	;; Your code starts here
	xor ecx, ecx ; contorul pt elementele valide

loop:
	cmp ebx, 0
	jle end ; ies din bucla
	mov eax, [esi] ; nr curent

	; Subtask 1
	; verific paritatea nr curent shiftand
	mov edx, eax ; ii fac copie
	shr edx, 1
	shl edx, 1
	cmp edx, eax
	jne skip ; nr este impar

	; Subtask 2
	; verific daca este putere a lui 2 cu operatorul &
	mov edx, eax
	dec edx
	and edx, eax ; edx = eax & (eax - 1)
	cmp edx, 0 ; daca este egal, nr este putere a lui 2
	je skip

	; nr este par, deci il adaug in target
	mov [edi], eax
	add edi, 4
	inc ecx ; incrementez contorul

skip:
	add esi, 4
	dec ebx
	jmp loop

	;; Your code ends here

end:
	pop edx ; recuperez pointerul original pt ptr_len
	mov [edx], ecx ; salvez nr de elemente verificate

	;; DO NOT MODIFY

	popa
	leave
	ret
	
	;; DO NOT MODIFY

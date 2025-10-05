Costache Ovidiu-Stefan 313CC
Tema 2 IOCLA

Task 1 - Sortari

Am lucrat cu urmatorii registrii:
ecx - numarul de noduri "n"
edx - adresa vectorului de noduri
ebx - valoarea curenta cautata
eax - index de parcurgere
esi - adresa nodului curent cu valoarea ebx
ebp - adresa nodului urmator cu valoarea ebx + 1
edi - l-am folosit pentru a citi valori

Salvez toate registrele cu pusha. Daca n este mai mic sau egal cu 1, returnez
direct adresa primului nod. Pentru fiecare valoare de la 1 la n caut nodul cu
valoarea respectiva in lista, pe care o parcurg cu eax. Caut nodul cu valoarea
urmatoare, daca exista. Leg nodul curent de urmatorul si scriu adesa acestuia in
campul "next". Dupa legare, caut nodul cu valoarea 1, adica capul listei si
returnez adresa acestuia. La final restaurez registrii cu popa si ies din
functie.

Task 2 - Operatii

Am folosit registrii:
esi - pointer la sirul sursa, pentru get_words
ebx - pointer la vectorul de cuvinte
edi - contor pentru numarul de cuvinte gasite
ebp - parametrii pe stiva

sort:
Inainte sa apelez functia qsort, trebuie pusi pe stiva parametrii acesteia,
adica pointerul la vector, numarul de cuvinte, dimensiunea si functia de
comparare. Apoi apelez qsort.

get_words:
Parcurg sirul caracter cu carcater. Sar peste delimitatori (spatiu, virgula,
punct si newline). Pentru fiecare cuvant pe care il gasesc salvez adresa de
start in vectorul de cuvinte, parcurg pana la un delimitator sau la finalul
sirului. Inlocuiesc delimitatorul cu NULL ca sa inchei cuvantul si incrementez
contorul de cuvinte. Continui pana ajung la numarul de cuvinte sau la finalul
sirului.

Task 3 - KFib

Registrii folositi:
esi - n, adica pozitia termenului curent
edi - k, numarul de termeni adunati
ebx - suma partiala pentru termneul curent
ecx - index pentru termeni, de la 1 la k

Salvez toti registrii folositi pe stiva la inceput. Daca n < k, returnez
zero prin eax. Daca n este egal cu k, reax ia valoarea 1, iar daca n este mai
mare decat k, iterez cu ecx de la 1 k. Pentru fiecare "i", calculez recursiv
kfib(n-i, k). Pun parametrii pe stiva, apoi apelez si adun rezultatele in ebx.
la final, mut suma in eax si o returnez. La final restaurez registrii si ies
din functie.

Task 4 - Composite Palindrom

Am lucrat cu registrii:
eax - pointer la sirul de verifcaat
ebx - lungimea sirului
ecx - index pentru stanga
edx - index pentru dreapta

Subtask 1:
Verific daca sirul este NULL sau are lungimea 0 sau 1, cazuri in care este
palindrom. Acestea sunt cazuri speciale. Setez indexul pentru partea stanga,
ecx = 0 si pentru partea dreapta, edx = len - 1. Compar caracterele de la
stanga si dreapta si avansez spre centru. Daca gasesc o nepotrivire, returnez
zero, adica nu este palindrom. Daca parcurg tot sirul fara sa gasesc diferente,
returnez 1, adica este palindrom.

Subtask 2:
Nu am stiut sa implementez.

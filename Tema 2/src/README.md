Costache Ovidiu-Stefan 313CC
Tema 2 IOCLA

1) Task 1 - Numbers

1. Salvarea registrilor:
    "esi" - vectorul original
    "edi" - vectorul in care se vor copia numerele filtrate
    "ebx" - numarul de elemente
    "edx" - adresa la care se va scrie numarul de elemente filtrate

2. Parcurgerea vectorului:
    - Pentru fiecare element verific paritatea: Copiez in "edx" numarul, fac shiftare la dreapta,
    apoi la stanga. Daca rezultatul este diferit de valoarea initiala, numarul este impar si
    sar peste el.
    - Ca sa verific daca este putere a lui 2, calculez "eax & (eax - 1)". Daca
    rezultatul este zero, numarul este putere a lui 2 si se trece mai departe, fara a-l copia.
    - Daca numarul este par si nu este putere a lui 2, se copiaza in vectorul "target" si se
    incrementeaza contorul de elemente valide, adica "ecx".
    - Dupa procesarea tuturor elementelor, se scrie valoarea contorului in registrul "edx".

2) Task 2 - Events

    Subtask 1:

1. Salvarea registrilor:
    "ebx" - pointer la începutul vectorului de evenimente
    "ecx" - numarul total de evenimente

2. Pentru fiecare eveniment:
    - Setez campul "valid" la zero.
    - Extrag anul, de la EVENT_DATE + 2 si verific daca este corect. Daca anul este mai mic decat
    1990 sau mai mare decat 2030, evenimentul ramane invalid.
    - Extrag luna de la EVENT_DATE + 1 si verific daca este corecta. Daca luna este mai mica
    decat 1 sau mai mare decat 12, evenimentul este invaalid.
    - Setez ultima zi valida in functie de luna. Daca luna este a doua, adica Februarie, ultima
    zi este a 28-a. Daca luna este 4, 6, 9 sau 11, ultima zi va fi 30, iar in rest ramane 31.
    - Extrag ziua de la EVENT_DATE si o verific. Daca este mai mica decat 1 sau mai mare decat
    ultima zi stabilita, evenimentul este invalid.
    - Daca toate conditiile sunt indeplinite, setez campul "valid" la 1.
    - La finalul fiecarui eveniment, trec la urmatorul incrementand pointerul cu EVENT_SIZE bytes.

    Subtask 2:

1. Separarea evenimentelor:
    - Parcurg vectorul folosind doi pointeri:
        "esi" - parcurge vectorul de evenimente
        "edi" - indica pozitia la care se vor insera evenimentele cu validitate 1.
    - Evenimentele cu validitate 1 sunt mutate la inceputul vectorului.

2. Sortarea evenimentlor valide:
    - Compar evenimentele din zona valida dupa:
        - An, de la EVENT_YEAR
        - Luna, de la EVENT_MONTH
        - Zi, de la EVENT_DAY
    - Daca datele sunt identice, trebuie comparat numele evenimentelor, similar cu functia
    strcmp, insa eu nu am reusit sa fac asta. Implementare mea rezolva testele in care datele
    sunt diferite.
    - Pentru a le ordona, schimb blocurile de memorie de dimensiunea unui eveniment.

3. Sortarea evenimentelor invalide:
    - Se sorteaza separat evenimentele cu validitate 0, dupa acelasi criteriu. (Mai intai am
    ordonat evenimentele dupa validitate si apoi dupa an, luna, zi, pentru a fi mai usor de
    scris si pentru a evita segmentation fault-uri pe care nu am putut sa le rezolv in alte
    incercari de a rezolva task-ul).

3) Task 3 - Base64

1. Salvarea registrilor:
    "esi" - pointer la vectorul sursa
    "ebx" - lungimea sursei
    "edi" - pointer catre destinatie
    "edx" - adresa la care se va scrie lungimea sirului codificat

2. Calcularea numarului de gruprui si lungimea sirului encodat:
    - Calculez numarul de grupuri (n / 3), pt ca fiecare grup are 3 octeti.
    - Lungimea sirului encodat este (nr_gruprui * 4) si va fi stocata la adresa indicata
    de pointerul din "edx".

3. Procesarea grupurilor:
    - Se citeste primul octet si se deplaseaza la pozitia cea mai semnificativa (shiftare la
    stanga cu 16 biti).
    - Se citeste al doilea octet si se deplaseaza la pozitia din mijloc (shiftare la stanga
    cu 8 biti).
    - Se citeste al treilea octet, ramane la pozitia cea mai putin semnificativa.
    - Se combina cei 3 octeti intr-un singur bloc de 24 de biti, stocat in "eax".

    - Se extrage primul grup de 6 biti, shiftez la dreapta cu 18 bitisi se aplica masca
    pt a obtine 6 biti.
    - Se extrage al doilea grup, shiftare la dreapta cu 12 biti si se aplica masca.
    - Se extrage al treilea grup, shiftare la dreapta cu 6 biti, masca 63.
    - Se extrage ultimul grup pe care se aplica direct masca.

    - Fiecare grup de 6 biti este convertit in numar de la 0 laa 63.
    - Acest nr este folosit pt a indexa tabela Base64, adica vectorul "alphabet" si se obtine cate
    un caracter.
    - Caracterul obtinut se scrie la adresa inficata de "edi".

4. Actualizarea pointerilor:
    - Dupa procesarea unui grup, "esi" se incrementeaza cu 3, pt a trece la urmatorul grup
    de octeti.
    - Pentru fiecare dintre cele 4e caractere, "edi" se incrementeaza.
    - Procesul se repeta pana cand toate grupurile sunt procesate.

4) Task 4 - Sudoku

A. check_row:
    1. Calculez adresa de inceput a randului:
        - Se inmulteste indexul randului cu 9 (fiecare rand are 9 celule) si se adauga la
        pointerul array-ului.
    2. Parcurg cele 9 celule de pe rand:
        - Verific daca valoarea curenta se afla intre 1 si 9.
        - Incrementez pozitia corespunzatoare din vector, iar daca o cifra apare de mai multe ori,
        inseamna ca este duplicat.
    3. Dupa parcurgerea tuturor celulelor, verific daca fiecare element din vector este exact 1.
    Daca da, randul este corect sis e returneaza 1, iar in caz contrar se returneaza 2.

B. check_column:
    1. Calculez adresa initiala a coloanei.
    2. Parcurg cele 9 celule de pe coloana:
        - Pentru fiecare celula verific daca valoarea este intre 1 si 9.
        - Scad 1 pt index si se incrementeaza pozitia corespunzatoare din vector.
        - Daca apare o valoare duplicata, coloana este gresita.
        - Se trece la celula urmatoare prin adaugarea a 9 (sar la urmatorul rand).
    3. La final, daca vectorul de frecevnta are toate elementele egale cu 1, coloana este
    cprecta si se returneaza 1, altfel este gresita si se returneaza 2.

C. check_box:
    1. Calculez coordonatele de start ale casetei:
        - Randul de start: (box / 3) * 3
        - Coloana de start: (box % 3) * 3
        - Se calculeaza indicele in tabloul de sudoku: (row_start * 9) + col_start
    2. Setez pointerul la adresa primei celule din caseta.
    3. Procesez feicare dintre cele 3 randuri din caseta:
        - Pentru fiecare rand, parcurg 3 celule:
            - Verific daca valoarea din celula curenta este intre 1 si 9.
            - Scad 1 pt a obtine indexul si incrementez pozitia corespunzatoare din vector.
            - Daca apare un duplicat, caseta este gresita.
        - Dupa ce procesez 3 celule, adaug 6 la pointer pt a ajunge la inceputul randului urmator
        din caseta (pt ca un rand al matricei are 9 celule).
    4. La final, daca fiecare element este 1 in vectorul de frecventa, caseta este croecta si se
    returneaza 1, iar in caz contrar 2.
    
AM MODIFICAT TASK-2 pt ca scrisesem:
%define DATE_SIZE 4 ; si am inteles ca se considera harcodare

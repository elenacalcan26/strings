# strings

##### Calcan Elena-Claudia
##### 321CA

<br/>

Task 1 - One Time Pad
---------------------

Programul consta in efectuarea operatie XOR intre un mesaj si o cheie
		
Am parcurs mesajul si cheia folosind instructiunea loop. Octetii din mesaj
i-am salvat in registrul al, iar octetii din cheie i-am salvat in registrul bl.
	
Am facut XOR intre al si bl, rezultatul salvandu-se in al. Dupa operatia de
XOR, punem rezulatul in ciphertext.


<br/>

Task 2 - Caesar Cipher
-----------------------

Programul reprezinta o implementare a Cifrului Caesar.
	
Parcurgerea mesajului este facuta cu instructiunea loop. Octetii din mesaj
sunt salvati in registrul al.
	
Verific daca cheia este 0 deoarece mesajul nu se va modifica, punandu-l
direct in ciphertext. Daca cheia este diferita de 0, mesajul se va cripta.
	
Dupa extragerea caracterului, acesta este verificat daca este litera sau 
nu. Caracterul este comparat cu valorile in hexazecimal a literelor. Daca 
carcterul nu este litera, acesta este adaugat in ciphertext fara sa ii se faca
criptarea.
	
Criptarea caracterului este facuta prin adunarea valorii sale in hexazecimal
cu cheia. Dupa adunare se verifica daca valoarea in hexazecimal a noului 
caracter obtinut ramane litera mica sau mare.
	
Deplasarea circulara s-a realizat prin scaderea valorii in hexazecimal a
caracterului cu valoarea in hexazecimal a lui 'z', pentru litere mici, 'Z', 
pentru litere mari, urmat sa fie adunat cu valoarea in hexazecimal a lui 'a' - 1
sau 'A' - 1. La final punand caracterul criptat in ciphertext.


<br/>

Task 3 - Vigenere Cipher
------------------------

Programul reprezinta o implementare a Cifrului Vigenere. 
	
La inceputul programului am numarat aparitiile noncarcterelor deorece acestea
nu se cripteaza.
	
Parcurgerea mesajului s-a facut prin jump-uri, cat timp ecx este mai mare 
decat 0. Mai intai caracterul de pe pozitia ecx este verificat daca este 
caracter sau nu.
	
Daca este litera, aflu cu ce litera din cheie este asociata. Pentru a afla
acest lucru mai intai am scazut pozitia pe care ma aflu in mesaj cu numarul de 
noncaractere. Facem aceasta scadere pana cand obtinem un numar mai mic decat
lungimea cheii.
	
Dupa extragerea cheii, am aflat pozitia sa din alfabet, scazand valoarea sa
din hexazecimal cu valoarea lui 'A' in hexazecimal.

Criptarea carcterului s-a facut prin adunarea sa cu pozitia din alfabet a
caracterului asociat din cheie. Ca la task 2 am verificat daca noul caracter 
obtinut a ramas litera mare sau mica si am deplasat circular, la final punand
caracterul criptat in ciphertext.

Daca nu este litera, se face jump la eticheta 'IS_NOT_CHARCTER'. Acolo
noncaracterul este pus direct in ciphertext, iar numarul de noncaractere este
redus.


<br/>


Task 4 - StrStr
---------------

Programul reprezinta o implementare a functiei strstr.

La inceput am considerat ca nu exista subsirul in sir, dandu-i lui edi 
lungimea sirului + 1.
	
Compar valoarea lui edi cu ecx si fac jump spre label-ul 'LOOP_HAYSTACK' 
pentru a cauta subirul in sir. 

In timpul parcurgerii compar caracterele din sir cu ultimul caracter al
subsirului. Daca cele doua caractere sunt identice, compar urmatoarele caractere
din subsir cu urmatoarele caractere din sir pana cand gasesc 2 caractere diferite
sau pana la terminarea subsirului (edx == 0). Daca am gasit un subsir in sir se 
face jump spre label-ul 'OCCURENCE' si ii dam lui edi valoarea primei pozitii a
subsirului din sir. 


<br/>

Task 5 - Binary to Hexadecimal
------------------------------

Programul converteste o secventa de biti in reprezentarea sa in heazecimal.

La inceputul programului pun '\n' de sir in edx. Pozitia din edx pe
care pun '\n' si reprezentarea in hex a bitilor este data de relatia:
(ecx + 3) / 4.

Secventa de biti este parcursa din 4 in 4, folosind jump-uri. Astfel, sunt
extrasi 4 octeti din secventa.

Ficare bit din secventa reprezinta o putere a lui 2, bit-ul cel mai din
dreapta fiind 2^0, iar bit-ul cel mai din stanga 2^3.	
	
Secventa de 4 biti este salvata in registrul eax, iar accesarea bitilor din
secventa este facut prin shiftare la dreapta a lui eax, bit-ul pe care vreau sa
il evaluez fiind in al. Daca avem bit de 1, atunci adaug puterea lui 2
la 'pozitia' pe care se afla bit-ul respectiv. Dupa ce am calculat suma bitilor,
verific valoarea sa in hex. Daca este mai mare decat 0x9, atunci am o litera si
o transform in litera mare. Altfel, aduc suma la reprezentarea sa in hexazecimal.

Daca la finalul parcurgerii ramane o sceventa care nu este de 4 biti, aceasta
este completata cu zerouri, urmand sa i se calculeze valoarea sa in hex.

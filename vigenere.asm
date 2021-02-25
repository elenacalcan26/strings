%include "io.mac"

section .text
    global vigenere
    extern printf

vigenere:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    ;; DO NOT MODIFY

    ;; TODO: Implement the Vigenere cipher


    xor     eax, eax
GET_NUMBER_OF_NONCHARACTERS:
    
    ; numar apritiile de caractere care nu sunt litere
    cmp     byte [esi + ecx - 1], 0x41
    jb      NONCHARACTER
    cmp     byte [esi + ecx - 1], 0x5A
    jbe     CHARACTER
    cmp     byte [esi + ecx - 1], 0x61
    jb      NONCHARACTER
    cmp     byte [esi + ecx - 1], 0x7A
    jbe     CHARACTER
    jg      NONCHARACTER

NONCHARACTER:
    add     eax, 1

CHARACTER:
    loop    GET_NUMBER_OF_NONCHARACTERS
    mov     ecx, [ebp + 16]
    push    eax                             ; salvez numarul in stiva

LOOP_PLAINTEXT:
    sub     ecx, 1
    
    ; verifc daca e litera sau nu
    cmp     byte [esi + ecx], 0x41
    jb      IS_NOT_LETTER
    cmp     byte [esi + ecx], 0x5A
    jbe     IS_LETTER
    cmp     byte [esi + ecx], 0x61
    jb      IS_NOT_LETTER
    cmp     byte [esi + ecx], 0x7A
    jbe     IS_LETTER
    jg      IS_NOT_LETTER

IS_LETTER: 
    
    ; aflu caracterul din key cu care este asociat caracterul din plaintext 
    xor     eax, eax
    pop     eax                 ; extrag numarul de noncaractere
    mov     ebx, ecx            ; pun in ebx numarul pozitiei pe care ma aflu in plaintext
    sub     ebx, eax            ; scad numarul poztitiei cu numarul de noncaractere
    xchg    eax, ebx            ; interschimb registrii
    push    ebx                 ; salvez in stiva numarul de noncaractere 
    mov     ebx, [ebp + 24]     ; pun in ebx lungimea lui key
    cmp     eax, ebx            ; verific daca indexul din plaintext este mai mic decat lungimea lui key
    jge     DECREASE
    jb      EXTRACT_KEY

DECREASE:
    sub     eax, ebx    ; scadem pana cand ajungem la o valoarea mai mica decat lungimea lui key
    cmp     eax, ebx
    jge     DECREASE  

EXTRACT_KEY:
    push    word [edi + eax]        ; extrag caracterul din key si il pun in stiva
    xor     eax, eax
    pop     ax                      ; pun caracterul din key in ax
    sub     al, 0x41                ; aflu pozitia din alfabet 
    mov     bl, byte [esi + ecx]    ; extrag caracterul din plain text
    add     bl, al                  ; criptez

    ; verific daca caracterul obtinut a ramas litera mica sau mare
    cmp     bl, 0x7A
    jg      GREATER_THAN_z
    cmp     bl, 0x61
    jge     PUT
    jb      CHECK_GREATER_THAN_Z

GREATER_THAN_z: 
    
    ; aduc caracterul in intervalul [a - z]
    xor     al, al
    mov     al, bl
    sub     al, 0x7A
    mov     bl, 0x60
    add     bl, al

    ; verific daca elementul este inca iesit din interval
    cmp     bl, 0x7A
    ja      GREATER_THAN_z
    jbe     PUT

CHECK_GREATER_THAN_Z: 

    ; verific daca este in intervalul [A - Z]
    cmp     bl, 0x5A
    jg      GREATER_THAN_Z
    jbe     PUT 

GREATER_THAN_Z:
    
    ; aduc caracterul in intervalul [A - Z]
    xor     al, al
    mov     al, bl
    sub     al, 0x5A
    mov     bl, 0x40
    add     bl, al

    ; verific daca elementul este inca iesit din interval
    cmp     al, 0x5A
    ja      GREATER_THAN_Z
    jbe     PUT
    
PUT:
    mov     byte [edx + ecx], bl ; pun caracterul criptat in ciphertext
    mov     ebx, [ebp + 24]
    cmp     ecx, 0
    jg      LOOP_PLAINTEXT
    jz      RETURN


IS_NOT_LETTER:
    mov     al, byte [esi + ecx]    ; extrag noncaracterul din plaintext 
    mov     byte [edx + ecx], al    ; pun non-caracterul in ciphertext
    pop     eax                     ; iau numarul de noncaracter din stiva
    cmp     eax, 0
    jz      GO_LOOP
    sub     eax, 1                  ; micsorez cu 1 numarul de non-caractere

GO_LOOP:
    push    eax    ; salvez numarul de noncaractere in stiva
    cmp     ecx, 0
    jg      LOOP_PLAINTEXT

RETURN:
   pop      eax
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
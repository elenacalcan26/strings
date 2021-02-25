%include "io.mac"

section .text
    global caesar
    extern printf

caesar:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the caesar cipher

ITERATE_PLAINTEXT:    
    mov     al, byte [esi + ecx - 1]    ; extrag elementul din plaintext
    cmp     edi, 0                      ; verific daca cheia e 0
    je      PUT                         ; daca cheia e 0, pun direct caracterul in ciphertext    
    xor     ebx, ebx
    mov     ebx, edi
    
    ; verific daca octetul este sau nu litera
    cmp     al, 0x41    
    jb      PUT          
    cmp     al, 0x5A    
    jbe     ENCRYPTS
    cmp     al, 0x61
    jb      PUT
    cmp     al, 0x7A
    jbe     ENCRYPTS
    jg      PUT

ENCRYPTS:            
    add     al, bl  ; criptez

    ; verific daca caracterul a ramas litera mica sau mare
    cmp     al, 0x7A    
    jg      GREATER_THAN_z
    cmp     al, 0x61
    jge     PUT
    jb      CHECK_GREATER_THAN_Z

GREATER_THAN_z: 
    ; aduc caracterul in intervalul [a - z]
    xor      bl, bl
    mov      bl, al
    sub      bl, 0x7A
    mov      al, 0x60
    add      al, bl

    ; verific daca elementul inca este iesit din interval
    cmp      al, 0x7A
    ja       GREATER_THAN_z
    jbe      PUT

CHECK_GREATER_THAN_Z: 
    ; verific daca este mai mare decat 'Z'
    cmp     al, 0x5A
    jg      GREATER_THAN_Z
    jbe     PUT 

GREATER_THAN_Z:
    ; aduc caracterul in intervalul [A - Z]
    xor     bl, bl
    mov     bl, al
    sub     bl, 0x5A
    mov     al, 0x40
    add     al, bl

PUT:                                
    mov byte [edx + ecx - 1] , al   ; pune caracterul in edx
    loop    ITERATE_PLAINTEXT

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
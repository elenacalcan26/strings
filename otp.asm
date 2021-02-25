%include "io.mac"

section .text
    global otp
    extern printf

otp:
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length

ITERATE_PLAINTEXT:
    mov     al, byte [esi + ecx - 1]    ; extrag elementul din plaintext
    mov     bl, byte [edi + ecx - 1]    ; extrag elementul din key
    xor     al, bl
    mov     byte [edx + ecx - 1], al    ; pun rezultatul operatiei de xor in ciphertext
    loop    ITERATE_PLAINTEXT

    popa
    leave
    ret

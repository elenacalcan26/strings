%include "io.mac"

section .text
    global my_strstr
    extern printf

my_strstr:
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack
    mov     ebx, [ebp + 16]     ; needle
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len

    mov     dword [edi], ecx    ; salvez valoarea
    add     dword [edi], 1      ; consider la inceput ca nu am gasit subsirul in sir
    cmp     dword [edi], ecx    
    jg      LOOP_HAYSTACK       ; jump catre parcurgerea sirului pentru a cauta subsirul

OCCURENCE:
    
    ; am gasit subsirul in sir
	mov    dword [edi], ecx    ; ia valoarea pozitiei pe care am gasit subsirul
	cmp    ecx, 0
	jge    LOOP_HAYSTACK
    xor    eax, eax

LOOP_HAYSTACK:
	sub    ecx, 1
	cmp    ecx, 0
	jl     RETURN  ; am terminat de parcurs sirul

GET_CHAR:
	mov    edx, [ebp + 24]
	mov    ah, byte [ebx + edx - 1]    ; iau caracterul de pe ultima pozitie din subsir
	mov    al, byte [esi + ecx]        ; iau caracterul de pe pozitia ecx
	cmp    al, ah                      
	jnz    LOOP_HAYSTACK               ; fac jump daca cele doua caractere sunt diferite

CHECK_STR:
    sub    edx, 1
	mov    al, byte [ebx + edx]        ; iau caracterul de pe pozitia edx
	mov    ah, byte [esi + ecx]        ; iau caracterul de pe pozitia ecx
	cmp    ah, al
	jne    LOOP_HAYSTACK               ; fac jump daca gasesc doua caractere diferite
	cmp    edx, 0
	je     OCCURENCE                   ; fac jump daca am gasit un subsir in sir
	sub    ecx, 1
	cmp    edx, 0
	jg     CHECK_STR                   ; continui sa compar

RETURN:

    popa
    leave
    ret

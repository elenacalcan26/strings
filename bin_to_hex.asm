%include "io.mac"

section .text
    global bin_to_hex
    extern printf

bin_to_hex:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; hexa_value
    mov     esi, [ebp + 12]     ; bin_sequence
    mov     ecx, [ebp + 16]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement bin to hex

    ; aflu pozitia din edx pe care o sa pun '\n'
    add     ecx, 3
    mov     bl, 2

DIVIDE:
    
    ; impart la 4
    shr     ecx, 1
    sub     bl, 1
    cmp     bl, 0
    jg      DIVIDE
    
    mov     byte [edx + ecx], 0x0A  ; pun '\n' 
    mov     ecx, [ebp + 16]

EXTRACT:    
    mov     eax, dword [esi + ecx - 4]   ; extrag secventa de 4 biti

LOOP_BIN:
    xor     ebx, ebx
    mov     bh, 16

GET_HEX:
    shr     bh, 1       ; impart la 2       
    cmp     al, 0x30    ; verific daca e bit de 0 sau 1
    je      NEXT_BIT
    add     bl, bh      ; adun puterile lui 2, daca bit-ul respectiv e 1.

NEXT_BIT:
    shr     eax, 8      ; iau urmatorul bit din secventa
    cmp     bh, 1
    jg      GET_HEX

CHECK:
    cmp     bl, 0x9
    jle     CONVERT     ; face jump daca suma este mai mica sau egala decat 9
    
    ; tranform liteara mica in litera mare
    add     bl, 0x41 	
    sub     bl, 0xa
    cmp     bl, 0x46
    jle     PUT

CONVERT:
	add    bl, 0x30    ; convertesc suma la valoarea sa in hexazecimal

PUT:
    
    ; obtin pozitia pe care o sa pun numarul in hex
    push    ecx         ; salvez indexul in stiva
    add     ecx, 3
    mov     bh, 2

GET_IDX:
    
    ; impart la 4
    shr     ecx, 1
    sub     bh, 1   
    cmp     bh, 0
    jg      GET_IDX
    
    mov     byte [edx + ecx - 1], bl    ; pun numarul in hex in edx
    pop     ecx
    sub     ecx, 4
    cmp     ecx, 4
    jge     EXTRACT
    cmp     ecx, 0
    jle     RETURN

	; ramane o secventa care nu e de 4 biti
    mov eax, dword [esi + 0]
    xor ebx, ebx
    mov ebx, 4
    sub ebx, ecx

SHIFT:
	; shiftez la stanga de 4 - index-ul de unde incepe secventa ramasa
    shl eax, 8
	sub ebx, 1
	cmp ebx, 0
	jg SHIFT
	xor ebx, ebx
	mov bh, 16

HEX:
	shr bh, 1      ; impart la 2 
	cmp al, 0x31   ; verific daca e bit de 1
	jne NEXT
	add bl, bh     ; adun puterile lui 2
NEXT:
	shr eax, 8     ; trec la urmatorul bit
	cmp bh, 1
	jg HEX
	je CHECK       ; fac jump pentru a verifica numarul in hex

RETURN:

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
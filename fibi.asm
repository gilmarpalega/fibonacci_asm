section .data
    message     db "Resultado: ", 0   ; String para impressão
    message_len equ $ - message       ; tamanho da string
    newline     db 10                 ; Caractere de nova linha

section .bss
    result   resb 15                  ; Reserva 15 bytes para a string do número

section .text
    global _start                     ; Ponto de entrada do programa

_start:
    ; Verifica o número de argumentos passados para o programa
    mov eax, [esp]                   ; Carrega o número de argumentos em eax
    cmp eax, 2                       ; Compara se temos pelo menos 2 argumentos (nome do programa + 1 argumento)
    jl exit                          ; Se menos de 2, encerra o programa
                                     ; TODO: mostrar mensagem de erro

    ; Converte o argumento para inteiro
    mov edi, [esp + 8]               ; Carrega o endereço do primeiro argumento em edi
    call str2int                     ; Chama a função para converter string para inteiro. retorna eax = inteiro
    mov ebx, eax                     ; Salva o resultado da conversão em ebx

    ; Calcula o Fibonacci do número
    call fibonacci_iter

    ; Converte o resultado para string
    mov edi, result                  ; Aponta edi para o buffer de string
    call int2str                     ; Converte o número em eax para string
    push eax                         ; Salva o comprimento da string

    ; TODO: Criar uma função print ao invés de fazer inline
    ; Imprime "Resultado: "
    mov eax, 4                       ; Código da syscall write
    mov ebx, 1                       ; Descritor de arquivo para stdout
    mov ecx, message                 ; Ponteiro para a mensagem
    mov edx, message_len             ; Comprimento da mensagem
    int 0x80                         ; Chama a interrupção para escrever

    ; Imprime o resultado
    pop edx                          ; Recupera o comprimento da string do número
    mov eax, 4                       ; Código da syscall write
    mov ebx, 1                       ; Descritor de arquivo para stdout
    mov ecx, result                  ; Ponteiro para o número convertido em string
    int 0x80                         ; Chama a interrupção para escrever

    ; Imprime a nova linha
    mov eax, 4                       ; Código da syscall write
    mov ebx, 1                       ; Descritor de arquivo para stdout
    mov ecx, newline                 ; Ponteiro para o caractere de nova linha
    mov edx, 1                       ; Comprimento da nova linha
    int 0x80                         ; Chama a interrupção para escrever

exit:
    mov eax, 1                       ; Código da syscall exit
    xor ebx, ebx                     ; Retorna 0
    int 0x80                         ; Chama a interrupção para encerrar

str2int:
    xor eax, eax                     ; Zera eax, usado para armazenar o número
    xor ecx, ecx                     ; Zera ecx, usado para armazenar dígitos individuais
.loop:
    movzx ecx, byte [edi]            ; Carrega o byte atual (dígito) em ecx
    test ecx, ecx                    ; Testa se chegou ao fim da string
    je .done                         ; Se sim, termina
    sub ecx, '0'                     ; Converte o dígito ASCII para número
    imul eax, eax, 10                ; Multiplica o número atual por 10
    add eax, ecx                     ; Adiciona o novo dígito ao número
    inc edi                          ; Move para o próximo dígito
    jmp .loop                        ; Repete para o próximo dígito
.done:
    ret                              ; Retorna com o número em eax

int2str:
    mov byte [edi + 14], 0           ; Coloca o byte nulo no final da nossa string buffer
    lea edi, [edi + 14]              ; Move EDI para o final do buffer

.reverse_loop:
    xor edx, edx                     ; Limpa EDX
    mov ecx, 10                      ; Dividir por 10 para obter o último dígito
    div ecx                          ; EAX ÷ ECX -> EAX = quociente, EDX = resto
    dec edi                          ; Move EDI para a esquerda
    add dl, '0'                      ; Converte o dígito numérico para seu equivalente ASCII
    mov [edi], dl                    ; Armazena o dígito ASCII no buffer

    test eax, eax                    ; Verifica se ainda temos dígitos para processar
    jnz .reverse_loop                ; Se sim, continue a processar

    lea eax, [edi + 14]              ; Calcule o comprimento da string
    sub eax, edi                     ; pela diferença entre o início e o final do buffer
    ret

fibonacci_iter:
    cmp ebx, 0
    je .fib_zero
    cmp ebx, 1
    je .fib_one

    mov eax, 0     ; Fibonacci(0)
    mov ecx, 1     ; Fibonacci(1)

    dec ebx
.loop:
    add eax, ecx   ; Próximo número
    xchg eax, ecx  
    dec ebx
    test ebx, ebx
    jnz .loop

    mov eax, ecx
    ret

.fib_zero:
    mov eax, 0
    ret

.fib_one:
    mov eax, 1
    ret

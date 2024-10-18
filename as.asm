.MODEL SMALL               ; Define el modelo de memoria como peque?o
.STACK 100h                ; Reserva 256 bytes para la pila
.DATA                      ; Inicio del segmento de datos
    mensajePrimero db 10, 13, 7, "Ingresa el primer numero (2 digitos): $"
    mensajeSegundo db 10, 13, 7, "Ingresa el segundo numero (2 digitos): $"
    mensajeMayor db 10, 13, 7, "El numero mayor es: $"
    mensajeMenor db 10, 13, 7, "El numero menor es: $"
    numero1 db 0           ; Variable para almacenar el primer n?mero
    numero2 db 0           ; Variable para almacenar el segundo n?mero

.CODE                      ; Inicio del segmento de c?digo
main proc                  ; Inicio del procedimiento principal
    mov ax, @data          ; Cargar la direcci?n del segmento de datos en AX
    mov ds, ax             ; Mover el valor de AX a DS para acceder a las variables

    ; Leer el primer n?mero de 2 d?gitos
    mov ah, 09h            ; Llamada a la funci?n para imprimir cadena
    lea dx, mensajePrimero ; Cargar la direcci?n del mensaje
    int 21h                ; Interrupci?n 21h para imprimir
    call readNumber        ; Llamar al procedimiento para leer el n?mero
    mov numero1, al        ; Guardar el n?mero en numero1

    ; Leer el segundo n?mero de 2 d?gitos
    mov ah, 09h            ; Llamada a la funci?n para imprimir cadena
    lea dx, mensajeSegundo ; Cargar la direcci?n del mensaje
    int 21h                ; Interrupci?n 21h para imprimir
    call readNumber        ; Llamar al procedimiento para leer el n?mero
    mov numero2, al        ; Guardar el n?mero en numero2

    ; Comparar los n?meros
    mov al, numero1        ; Cargar el primer n?mero en AL
    mov bl, numero2        ; Cargar el segundo n?mero en BL
    cmp al, bl             ; Comparar AL con BL
    jg es_mayor            ; Si AL > BL, saltar a es_mayor
    jl es_menor            ; Si AL < BL, saltar a es_menor

    ; Si son iguales, puedes manejarlo aqu? (opcional)
    jmp fin

es_mayor:
    ; Mostrar el n?mero mayor
    mov ah, 09h            ; Llamada a la funci?n para imprimir cadena
    lea dx, mensajeMayor   ; Cargar la direcci?n del mensaje
    int 21h                ; Interrupci?n 21h para imprimir
    mov al, numero1        ; Cargar el n?mero mayor en AL
    call printNumber        ; Llamar a la funci?n para imprimir el n?mero
    jmp fin                ; Saltar al final del programa

es_menor:
    ; Mostrar el n?mero menor
    mov ah, 09h            ; Llamada a la funci?n para imprimir cadena
    lea dx, mensajeMenor   ; Cargar la direcci?n del mensaje
    int 21h                ; Interrupci?n 21h para imprimir
    mov al, numero2        ; Cargar el n?mero menor en AL
    call printNumber        ; Llamar a la funci?n para imprimir el n?mero

fin:
    mov ax, 4c00h          ; Finalizar el programa
    int 21h                ; Interrupci?n 21h para terminar el programa

; Leer un n?mero de 2 d?gitos
readNumber proc
    xor ax, ax             ; Limpiar AX para almacenar el n?mero

    ; Leer el primer d?gito
    mov ah, 01h            ; Llamar a la funci?n para leer un car?cter
    int 21h                ; Leer un car?cter
    sub al, 30h            ; Convertir de ASCII a entero
    mov bl, al             ; Guardar el primer d?gito en BL

    ; Leer el segundo d?gito
    mov ah, 01h            ; Llamar a la funci?n para leer un car?cter
    int 21h                ; Leer un car?cter
    sub al, 30h            ; Convertir de ASCII a entero
    ; Convertir a n?mero
    mov bh, al             ; Guardar el segundo d?gito en BH

    ; Construir el n?mero completo en AL
    mov al, bl             ; Mover el primer d?gito a AL
    mov cl, 10             ; Multiplicar por 10
    mul cl                 ; AL = BL * 10
    add al, bh             ; AL = AL + segundo d?gito
    ret
readNumber endp

; Imprimir un n?mero en formato decimal
printNumber proc
    mov bx, 10
    xor cx, cx
    xor dx, dx

printLoop:
    xor dx, dx
    div bx                  ; Divide AX entre 10, el cociente queda en AL y el residuo en DL
    add dl, '0'            ; Convertir a car?cter ASCII
    push dx                 ; Guardar el d?gito en la pila
    inc cx                  ; Contar los d?gitos
    test ax, ax             ; Comprobar si AX es cero
    jnz printLoop

printDigits:
    pop dx                  ; Sacar el d?gito de la pila
    mov ah, 02h
    int 21h                 ; Imprimir el d?gito
    loop printDigits
    ret
printNumber endp

main endp                  ; Fin del procedimiento principal
end main                   ; Fin del programa

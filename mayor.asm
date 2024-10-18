.model small
.stack 100h
.data
    mensajeNumero1 db "Ingresa el primer numero (2 digitos): $"
    mensajeNumero2 db 10, 13, "Ingresa el segundo numero (2 digitos): $"
    mensajeMayor db 10, 13, "El numero mayor es: $"
    numero1 db 0
    numero2 db 0
.code
main proc
    ; Inicializar el segmento de datos
    mov ax, @data
    mov ds, ax

    ; Solicitar el primer n?mero (2 d?gitos)
    mov ah, 09h
    lea dx, mensajeNumero1
    int 21h
    call readNumber
    mov numero1, al  ; Guardar el n?mero en formato de un byte

    ; Solicitar el segundo n?mero (2 d?gitos)
    mov ah, 09h
    lea dx, mensajeNumero2
    int 21h
    call readNumber
    mov numero2, al  ; Guardar el n?mero en formato de un byte

    ; Comparar los n?meros
    mov al, numero1
    cmp al, numero2
    jg primeroMayor
    jl segundoMayor
    ; En caso de que sean iguales
    jmp fin

primeroMayor:
    ; Mostrar el n?mero mayor (numero1)
    mov ah, 09h
    lea dx, mensajeMayor
    int 21h
    mov al, numero1
    call printNumber
    jmp fin

segundoMayor:
    ; Mostrar el n?mero mayor (numero2)
    mov ah, 09h
    lea dx, mensajeMayor
    int 21h
    mov al, numero2
    call printNumber

fin:
    ; Terminar el programa
    mov ax, 4C00h
    int 21h

; Leer un n?mero de 2 d?gitos
readNumber proc
    xor ax, ax  ; Limpiar AX para almacenar el n?mero
    mov cx, 2   ; N?mero de d?gitos a leer

    ; Leer el primer d?gito
    mov ah, 01h
    int 21h         ; Leer un car?cter
    sub al, 30h     ; Convertir de ASCII a entero
    mov ah, al      ; Mover el primer d?gito a AH

    ; Leer el segundo d?gito
    mov ah, 01h
    int 21h         ; Leer un car?cter
    sub al, 30h     ; Convertir de ASCII a entero
    ; Convertir a n?mero (AH contiene el primer d?gito, AL el segundo)
    mov bl, ah      ; Guardar el primer d?gito en BL
    mov bh, al      ; Guardar el segundo d?gito en BH

    ; Construir el n?mero completo en AL
    mov al, bl      ; Mover el primer d?gito a AL
    mov cx, 10      ; Multiplicar por 10
    mul cx          ; AL = BL * 10
    add al, bh      ; AL = AL + segundo d?gito
    ret
readNumber endp

printNumber proc
    ; Imprimir el n?mero en formato decimal
    mov bx, 10
    xor cx, cx
    xor dx, dx

printLoop:
    xor dx, dx
    div bx          ; Divide AX entre 10, el cociente queda en AL y el residuo en DL
    add dl, '0'     ; Convertir a car?cter ASCII
    push dx         ; Guardar el d?gito en la pila
    inc cx          ; Contar los d?gitos
    test ax, ax     ; Comprobar si AX es cero
    jnz printLoop

printDigits:
    pop dx          ; Sacar el d?gito de la pila
    mov ah, 02h
    int 21h         ; Imprimir el d?gito
    loop printDigits
    ret
printNumber endp
main endp
end main

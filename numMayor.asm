.model small
.stack 100h
.data
    mensajeNumero1 db "Ingresa el primer numero (2 digitos): $"
    mensajeNumero2 db 10, 13, "Ingresa el segundo numero (2 digitos): $"
    mensajeResultado1 db 10, 13, "El numero mayor es: PRIMERO$"
    mensajeResultado2 db 10, 13, "El numero mayor es: SEGUNDO$"
    numero1 dw 0
    numero2 dw 0
    temp db 0
.code
main proc
    ; Inicializar el segmento de datos
    mov ax, @data
    mov ds, ax

    ; Solicitar el primer n?mero (2 d?gitos)
    mov ah, 09h
    lea dx, mensajeNumero1
    int 21h
    mov ah, 01h
    int 21h
    sub al, 30h       ; Convertir de ASCII a entero
    mov bl, al
    mov ah, 01h
    int 21h
    sub al, 30h       ; Convertir de ASCII a entero
    mov bh, al
    mov al, bl
    mov ah, 0
    mov cl, 10
    mul cl
    add ax, bx
    mov numero1, ax

    ; Solicitar el segundo n?mero (2 d?gitos)
    mov ah, 09h
    lea dx, mensajeNumero2
    int 21h
    mov ah, 01h
    int 21h
    sub al, 30h       ; Convertir de ASCII a entero
    mov bl, al
    mov ah, 01h
    int 21h
    sub al, 30h       ; Convertir de ASCII a entero
    mov bh, al
    mov al, bl
    mov ah, 0
    mov cl, 10
    mul cl
    add ax, bx
    mov numero2, ax

    ; Comparar los n?meros
    mov ax, numero1
    cmp ax, numero2
    jg primeroMayor
    jl segundoMayor

primeroMayor:
    ; Mostrar el mensaje "PRIMERO"
    mov ah, 09h
    lea dx, mensajeResultado1
    int 21h
    jmp fin

segundoMayor:
    ; Mostrar el mensaje "SEGUNDO"
    mov ah, 09h
    lea dx, mensajeResultado2
    int 21h

fin:
    ; Terminar el programa
    mov ax, 4C00h
    int 21h

main endp
end main

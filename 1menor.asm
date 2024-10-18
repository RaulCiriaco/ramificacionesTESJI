.model small
.stack 100h
.data
    mensajeNumero1 db "Ingresa el primer numero (1 digito): $"
    mensajeNumero2 db 10, 13, "Ingresa el segundo numero (1 digito): $"
    mensajeResultado1 db 10, 13, "El numero menor es: PRIMERO$"
    mensajeResultado2 db 10, 13, "El numero menor es: SEGUNDO$"
    numero1 db 0
    numero2 db 0
.code
main proc
    ; Inicializar el segmento de datos
    mov ax, @data
    mov ds, ax

    ; Solicitar el primer n?mero (1 d?gito)
    mov ah, 09h
    lea dx, mensajeNumero1
    int 21h
    mov ah, 01h
    int 21h
    sub al, 30h       ; Convertir de ASCII a entero
    mov numero1, al

    ; Solicitar el segundo n?mero (1 d?gito)
    mov ah, 09h
    lea dx, mensajeNumero2
    int 21h
    mov ah, 01h
    int 21h
    sub al, 30h       ; Convertir de ASCII a entero
    mov numero2, al

    ; Comparar los n?meros
    mov al, numero1
    cmp al, numero2
    jl primeroMenor
    jg segundoMenor

primeroMenor:
    ; Mostrar el mensaje "PRIMERO"
    mov ah, 09h
    lea dx, mensajeResultado1
    int 21h
    jmp fin

segundoMenor:
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

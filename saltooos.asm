.model small
.stack 100h
.data
    mensajeNumero1 db "Ingresa el primer numero: $"
    mensajeNumero2 db 10, 13, "Ingresa el segundo numero: $"
    mensajeMayor db 10, 13, "El numero mayor es: $"
    numero1 db 0
    numero2 db 0
.code
main proc
    ; Inicializar el segmento de datos
    mov ax, @data
    mov ds, ax
    
    ; Solicitar el primer n?mero
    mov ah, 09h
    lea dx, mensajeNumero1
    int 21h
    mov ah, 01h
    int 21h
    sub al, 30h       ; Convertir de ASCII a entero
    mov numero1, al
    
    ; Solicitar el segundo n?mero
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
    jg primeroMayor    ; Si numero1 > numero2, salta a primeroMayor
    jl segundoMayor    ; Si numero2 > numero1, salta a segundoMayor
    
primeroMayor:
    ; Mostrar el n?mero mayor (numero1)
    mov ah, 09h
    lea dx, mensajeMayor
    int 21h
    mov al, numero1
    call printNumber
    jmp fin            ; Saltar a la terminaci?n del programa
    
segundoMayor:
    ; Mostrar el n?mero mayor (numero2)
    mov ah, 09h
    lea dx, mensajeMayor
    int 21h
    mov al, numero2
    call printNumber
    jmp fin            ; Saltar a la terminaci?n del programa
    
fin:
    ; Terminar el programa
    mov ax, 4C00h
    int 21h

printNumber proc
    add al, 30h       ; Convertir de entero a ASCII
    mov ah, 02h
    int 21h           ; Imprimir el n?mero
    ret
printNumber endp
main endp
end main

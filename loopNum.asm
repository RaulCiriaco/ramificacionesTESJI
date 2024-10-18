.model small
.stack 100h

.data
    mensaje db 10, 13, "Conteo descendente: $"
    nuevaLinea db 10, 13, "$"

.code
main proc
    ; Inicializar el segmento de datos
    mov ax, @data
    mov ds, ax

    ; Mostrar el mensaje inicial
    mov ah, 09h
    lea dx, mensaje
    int 21h

    ; Configurar el contador
    mov cx, 10      ; CX contiene el n?mero de iteraciones (10 para contar de 9 a 0)
    mov al, 9       ; AL contiene el n?mero inicial (9)

inicioConteo:
    ; Convertir el valor num?rico en AL a su car?cter ASCII
    add al, 30h     ; Convierte el n?mero en AL a su correspondiente c?digo ASCII

    ; Mostrar el n?mero actual (almacenado en AL)
    mov dl, al      ; Mover el valor de AL a DL para imprimir
    mov ah, 02h     ; Servicio para mostrar un car?cter
    int 21h

    ; Mostrar una nueva l?nea despu?s del n?mero
    mov ah, 09h
    lea dx, nuevaLinea
    int 21h

    ; Restaurar el valor num?rico restando 30h para decrementar correctamente
    sub al, 30h

    ; Decrementar el valor en AL para el siguiente n?mero
    dec al

    ; Ciclo: Decrementa CX y repite si no es 0
    loop inicioConteo

    ; Terminar el programa
    mov ax, 4C00h
    int 21h

main endp
end main


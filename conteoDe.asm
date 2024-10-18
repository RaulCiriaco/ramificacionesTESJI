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
    mov cx, 99      ; CX contiene el n?mero de iteraciones (99 para contar de 99 a 1)
    mov bl, 99      ; BL contiene el n?mero inicial (99)

inicioConteoDescendente:
    ; Convertir el n?mero en BL a su correspondiente ASCII
    xor ah, ah      ; Limpiar AH para usarlo para las decenas
    mov bh, 10      ; Dividir por 10
    xor dx, dx      ; Limpiar DX

    div bh          ; Dividir el n?mero en BL entre 10
    add al, 30h     ; Obtener el car?cter ASCII de la decena
    mov dl, al      ; Mover a DL para imprimir
    mov ah, 02h     ; Servicio para mostrar un car?cter
    int 21h

    ; Imprimir la unidad
    mov al, bl      ; Obtener el resto (unidad)
    add al, 30h     ; Obtener el car?cter ASCII de la unidad
    mov dl, al      ; Mover a DL para imprimir
    int 21h

    ; Mostrar una nueva l?nea despu?s del n?mero
    mov ah, 09h
    lea dx, nuevaLinea
    int 21h

    ; Decrementar el valor en BL para el siguiente n?mero
    dec bl          ; Decrementar BL para el siguiente n?mero
    jnz inicioConteoDescendente ; Repetir hasta que BL sea 0

    ; Terminar el programa
    mov ax, 4C00h
    int 21h

main endp
end main



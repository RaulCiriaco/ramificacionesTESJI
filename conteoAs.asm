.model small
.stack 100h

.data
    mensaje db 10, 13, "Conteo ascendente: $"
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
    mov cx, 99       ; Contar de 1 a 99
    mov al, 1        ; Valor inicial (1)

inicioConteo:
    call PrintNumber  ; Imprimir el n?mero en AL

    ; Mostrar una nueva l?nea despu?s del n?mero
    mov ah, 09h
    lea dx, nuevaLinea
    int 21h

    ; Incrementar AL
    inc al

    ; Ciclo: Decrementa CX y repite si no es 0
    loop inicioConteo

    ; Terminar el programa
    mov ax, 4C00h
    int 21h

PrintNumber proc
    ; AL tiene el n?mero a imprimir (1-99)
    xor dx, dx      ; Limpiar DX

    ; Dividir AL por 10 para obtener los d?gitos
    mov bx, 10
    div bx          ; AX = AL / 10, DX = AL % 10

    ; Imprimir el d?gito de las decenas
    add al, 30h     ; Convertir a ASCII
    mov ah, 02h     ; Servicio para mostrar un car?cter
    int 21h

    ; Imprimir el d?gito de las unidades
    add dl, 30h     ; Convertir a ASCII
    mov ah, 02h
    int 21h

    ret
PrintNumber endp

main endp
end main

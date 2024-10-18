.model small
.stack 100h
.data
.code
.startup
    mov cx, 1        ; inicializo contador en 1 (para mostrar 1-99)

repite:
    mov ax, cx       ; muevo el valor del contador a ax
    call PrintNumber  ; llamo a la subrutina para imprimir el n?mero

    inc cx           ; incremento el contador en uno
    cmp cx, 100      ; compara si en el contador hay un 100
    jne repite       ; si no es igual a 100, regresa a repetir

salir:
    mov ax, 4C00h    ; termina el programa
    int 21h          ; llamada a DOS para salir

; Subrutina para imprimir un n?mero en AX
PrintNumber proc
    push ax          ; guardar el valor de ax
    push dx          ; guardar dx

    ; Separa las cifras del n?mero
    xor dx, dx       ; limpiar dx para asegurar que solo tiene el d?gito
    mov bx, 10       ; divisor para obtener cifras

separar:
    xor dx, dx       ; limpiar dx
    div bx            ; dividir ax por 10, el cociente queda en ax y el residuo en dx
    push dx           ; guardar el residuo (d?gito)
    test ax, ax      ; verificar si ax es cero
    jnz separar       ; repetir hasta que ax sea cero

    ; Imprimir los d?gitos en orden
imprimir:
    pop dx            ; obtener el ?ltimo d?gito
    add dl, '0'       ; convertir a car?cter ASCII
    mov ah, 02h       ; funci?n para imprimir car?cter
    int 21h           ; imprimir
    test sp, sp       ; verificar si hay m?s d?gitos en la pila
    jnz imprimir      ; imprimir el siguiente d?gito

    pop dx            ; recuperar dx
    pop ax            ; recuperar ax
    ret
PrintNumber endp

end

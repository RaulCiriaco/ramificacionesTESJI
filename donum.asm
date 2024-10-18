.MODEL SMALL               ; Define el modelo de memoria como peque?o
.STACK 100h                ; Reserva 256 bytes para la pila

.DATA                      ; Inicio del segmento de datos
    num1 db 0              ; Variable para almacenar el primer n?mero
    num2 db 0              ; Variable para almacenar el segundo n?mero
    resultado db 0         ; Variable para almacenar el resultado de la suma
    mensaje db 10, 13, "Primer n?mero (dos d?gitos): $"; Mensaje para solicitar el primer n?mero
    mensaje2 db 10, 13, "Segundo n?mero (dos d?gitos): $"; Mensaje para solicitar el segundo n?mero
    mensaje3 db 10, 13, "La suma es: $"; Mensaje para mostrar la suma
    nueva_linea db 10, 13, "$"; Nueva l?nea para mejorar la visualizaci?n

.CODE                      ; Inicio del segmento de c?digo
main proc                  ; Inicio del procedimiento principal
    mov ax, @data          ; Cargar la direcci?n del segmento de datos en AX
    mov ds, ax             ; Mover el valor de AX a DS para acceder a las variables

    ; Solicitar el primer n?mero de dos d?gitos
    mov ah, 09h            ; Funci?n 09H para imprimir cadenas
    lea dx, mensaje        ; Cargar la direcci?n del mensaje en DX
    int 21h                ; Llamar a la interrupci?n para mostrar el mensaje

    ; Leer el primer d?gito del primer n?mero
    mov ah, 01h            ; Funci?n 01H para leer un car?cter del teclado
    int 21h                ; Interrupci?n para obtener el car?cter
    sub al, 30h            ; Convertir car?cter ASCII a n?mero (0-9)
    mov bl, al             ; Guardar el primer d?gito en BL

    ; Leer el segundo d?gito del primer n?mero
    mov ah, 01h            ; Funci?n 01H para leer el siguiente car?cter
    int 21h                ; Interrupci?n para obtener el car?cter
    sub al, 30h            ; Convertir car?cter ASCII a n?mero
    mov bh, al             ; Guardar el segundo d?gito en BH



main endp                  ; Fin del procedimiento principal
end main                   ; Fin del programa

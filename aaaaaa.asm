.MODEL SMALL               ; Define el modelo de memoria como peque?o
.STACK 100h                ; Reserva 256 bytes para la pila
.DATA                      ; Inicio del segmento de datos
    x db ?                 ; Variable para almacenar el primer n?mero
    y db ?                 ; Variable para almacenar el segundo n?mero
    mensaje_pedir1 db 10, 13, "Ingrese el primer numero (0-9): $"
    mensaje_pedir2 db 10, 13, "Ingrese el segundo numero (0-9): $"
    mensaje_menor db 10, 13, "Numero Menor: $"
    mensaje_mayor db 10, 13, "Numero Mayor: $"

.CODE                      ; Inicio del segmento de c?digo
main proc                  ; Inicio del procedimiento principal
    mov ax, @data          ; Cargar la direcci?n del segmento de datos en AX
    mov ds, ax             ; Mover el valor de AX a DS para acceder a las variables

    ; Solicitar el primer n?mero
    mov ah, 09h            ; Llamada a la funci?n para imprimir cadena
    lea dx, mensaje_pedir1 ; Cargar la direcci?n del mensaje
    int 21h                ; Interrupci?n 21h para imprimir

    ; Leer el primer n?mero
    mov ah, 01h            ; Llamada a la funci?n para leer un car?cter del teclado
    int 21h                ; Interrupci?n 21h para leer
    sub al, '0'            ; Convertir de ASCII a n?mero
    mov x, al              ; Almacenar el valor en la variable x

    ; Solicitar el segundo n?mero
    mov ah, 09h            ; Llamada a la funci?n para imprimir cadena
    lea dx, mensaje_pedir2 ; Cargar la direcci?n del mensaje
    int 21h                ; Interrupci?n 21h para imprimir

    ; Leer el segundo n?mero
    mov ah, 01h            ; Llamada a la funci?n para leer un car?cter del teclado
    int 21h                ; Interrupci?n 21h para leer
    sub al, '0'            ; Convertir de ASCII a n?mero
    mov y, al              ; Almacenar el valor en la variable y

    ; Comparar los dos n?meros
    mov al, x              ; Cargar el valor de x en AL
    mov bl, y              ; Cargar el valor de y en BL

    cmp al, bl             ; Comparar AL con BL
    jg es_mayor            ; Si AL > BL, saltar a es_mayor

es_menor:
    mov ah, 09h            ; Llamada a la funci?n para imprimir cadena
    lea dx, mensaje_menor  ; Cargar la direcci?n del mensaje_menor
    int 21h                ; Interrupci?n 21h para imprimir
    jmp fin                ; Saltar al final del programa

es_mayor:
    mov ah, 09h            ; Llamada a la funci?n para imprimir cadena
    lea dx, mensaje_mayor  ; Cargar la direcci?n del mensaje_mayor
    int 21h                ; Interrupci?n 21h para imprimir

fin:
    mov ax, 4c00h          ; Finalizar el programa
    int 21h                ; Interrupci?n 21h para terminar el programa

main endp                  ; Fin del procedimiento principal
end main                   ; Fin del programa

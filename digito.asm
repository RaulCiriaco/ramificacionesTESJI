.model small               ; Define el modelo de memoria peque?o (segmentos de c?digo y datos de 64KB)
.stack 100h                ; Reserva 256 bytes de pila
.data
    num1 db 0              ; Reserva una variable de un byte para el primer n?mero
    num2 db 0              ; Reserva una variable de un byte para el segundo n?mero
    resultado db 0         ; Reserva una variable de un byte para el resultado
    mensaje1 db "Ingresa el primer numero (0-9): $"  ; Mensaje que solicita el primer n?mero
    mensaje2 db 10, 13, "Ingresa el segundo numero (0-9): $" ; Mensaje para solicitar el segundo n?mero (10, 13 es un salto de l?nea)
    mensaje3 db 10, 13, "La suma es: $"  ; Mensaje que muestra antes de desplegar el resultado
    nueva_linea db 10, 13, "$" ; Caracteres para una nueva l?nea

.code
main proc
    mov ax, @data          ; Cargar el segmento de datos en AX
    mov ds, ax             ; Establecer el segmento de datos en DS

    ; Solicitar el primer n?mero
    mov ah, 09h            ; Funci?n de interrupci?n 09h: Mostrar cadena de caracteres
    lea dx, mensaje1       ; Cargar la direcci?n del mensaje1 en DX
    int 21h                ; Interrupci?n DOS para mostrar el mensaje

    ; Leer el primer n?mero de un d?gito
    mov ah, 01h            ; Funci?n de interrupci?n 01h: Leer un car?cter del teclado
    int 21h                ; Interrupci?n para leer el car?cter ingresado
    sub al, 30h            ; Convertir el car?cter ASCII a su valor num?rico (restar 30h)
    mov num1, al           ; Almacenar el n?mero ingresado en la variable num1

    ; Solicitar el segundo n?mero
    mov ah, 09h            ; Funci?n de interrupci?n 09h: Mostrar cadena de caracteres
    lea dx, mensaje2       ; Cargar la direcci?n del mensaje2 en DX
    int 21h                ; Interrupci?n DOS para mostrar el mensaje

    ; Leer el segundo n?mero de un d?gito
    mov ah, 01h            ; Funci?n de interrupci?n 01h: Leer un car?cter del teclado
    int 21h                ; Interrupci?n para leer el car?cter ingresado
    sub al, 30h            ; Convertir el car?cter ASCII a su valor num?rico (restar 30h)
    mov num2, al           ; Almacenar el n?mero ingresado en la variable num2

    ; Sumar los dos n?meros
    mov al, num1           ; Mover el primer n?mero (num1) a AL
    add al, num2           ; Sumar el segundo n?mero (num2) a AL
    cmp al, 9              ; Comparar la suma con 9
    ja error               ; Si la suma es mayor que 9, saltar a la etiqueta 'error'
    mov resultado, al      ; Guardar el resultado de la suma en la variable resultado

    ; Mostrar el mensaje de la suma
    mov ah, 09h            ; Funci?n de interrupci?n 09h: Mostrar cadena de caracteres
    lea dx, mensaje3       ; Cargar la direcci?n del mensaje3 en DX
    int 21h                ; Interrupci?n DOS para mostrar el mensaje

    ; Mostrar el resultado
    mov al, resultado      ; Cargar el valor del resultado en AL
    add al, 30h            ; Convertir el n?mero a su car?cter ASCII (sumar 30h)
    mov dl, al             ; Mover el car?cter ASCII a DL (registro para mostrar caracteres)
    mov ah, 02h            ; Funci?n de interrupci?n 02h: Mostrar un car?cter
    int 21h                ; Interrupci?n para mostrar el car?cter en DL

    ; Nueva l?nea
    mov ah, 09h            ; Funci?n de interrupci?n 09h: Mostrar cadena de caracteres
    lea dx, nueva_linea    ; Cargar la direcci?n de 'nueva_linea' en DX
    int 21h                ; Interrupci?n DOS para mostrar el salto de l?nea

    ; Terminar el programa
    mov ax, 4C00h          ; Funci?n de interrupci?n 4Ch: Terminar el programa
    int 21h                ; Interrupci?n para finalizar el programa y regresar al DOS

error:
    ; Mostrar mensaje de error si la suma es mayor que 9
    mov ah, 09h            ; Funci?n de interrupci?n 09h: Mostrar cadena de caracteres
    lea dx, nueva_linea    ; Cargar la direcci?n de nueva_linea en DX
    int 21h                ; Interrupci?n para mostrar el mensaje de error
    mov ah, 4Ch            ; Terminar el programa con c?digo de retorno
    int 21h                ; Interrupci?n para finalizar el programa

main endp                  ; Fin del procedimiento main
end main                   ; Fin del programa

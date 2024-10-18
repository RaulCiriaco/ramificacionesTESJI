.model small               ; Define el modelo de memoria peque?o (segmentos de c?digo y datos de 64KB)
.stack 100h                ; Reserva 256 bytes de pila
.data
    num1 db 0              ; Reserva una variable de un byte para el primer n?mero
    num2 db 0              ; Reserva una variable de un byte para el segundo n?mero
    resultado db 0         ; Reserva una variable de un byte para el resultado
    
    mensaje10 db 10,13, "Ingrese el nombre de la primer persona: $"
    
    mensaje1  10, 13, "Ingresa su edad : $"  ; Mensaje que solicita el primer n?mero
    mensaje3 db 10, 13, "Es mayor: $"  ; Mensaje que muestra antes de desplegar el resultado
    nueva_linea db 10, 13, "$" ; Caracteres para una nueva l?nea

.code
main proc
    mov ax, @data          ; Cargar el segmento de datos en AX
    mov ds, ax             ; Establecer el segmento de datos en DS

        ; Solicitar el primer n?mero de dos d?gitos
    mov ah, 09h            ; Funci?n 09H para imprimir cadenas
    lea dx, mensaje1       ; Cargar la direcci?n del mensaje en DX
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
    mov bh, al             ; Guardar el segundo d?gito en 
    
    
    
        ; Solicitar el primer n?mero
    mov ah, 09h            ; Funci?n de interrupci?n 09h: Mostrar cadena de caracteres
    lea dx, mensaje1       ; Cargar la direcci?n del mensaje1 en DX
    int 21h                ; Interrupci?n DOS para mos
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

    ; Calcular num1 = (primer_digito * 10) + segundo_digito
    mov al, bl             ; Mover el primer d?gito a AL
    mov ah, 0              ; Limpiar AH para que AX tenga solo el primer d?gito
    mov cl, 10             ; Cargar 10 en CL para multiplicar
    mul cl                 ; Multiplicar el primer d?gito por 10
    add al, bh             ; Sumar el segundo d?gito
    mov num1, al           ; Guardar el n?mero final en num1

    ; Solicitar el segundo n?mero de dos d?gitos
    mov ah, 09h            ; Funci?n 09H para imprimir cadenas
    lea dx, mensaje2       ; Cargar la direcci?n del mensaje2 en DX
    int 21h                ; Llamar a la interrupci?n para mostrar el mensaje

    ; Leer el primer d?gito del segundo n?mero
    mov ah, 01h            ; Funci?n 01H para leer un car?cter
    int 21h                ; Interrupci?n para obtener el car?cter
    sub al, 30h            ; Convertir car?cter ASCII a n?mero
    mov bl, al             ; Guardar el primer d?gito en BL

    ; Leer el segundo d?gito del segundo n?mero
    mov ah, 01h            ; Funci?n 01H para leer el siguiente car?cter
    int 21h                ; Interrupci?n para obtener el car?cter
    sub al, 30h            ; Convertir car?cter ASCII a n?mero
    mov bh, al             ; Guardar el segundo d?gito en BH

    ; Calcular num2 = (primer_digito * 10) + segundo_digito
    mov al, bl             ; Mover el primer d?gito a AL
    mov ah, 0              ; Limpiar AH
    mul cl                 ; Multiplicar por 10
    add al, bh             ; Sumar el segundo d?gito
    mov num2, al           ; Guardar el n?mero final en num2

    ; Sumar num1 y num2
    mov al, num1           ; Cargar num1 en AL
    add al, num2           ; Sumar num2 a AL
    mov resultado, al      ; Guardar la suma en resultado

    ; Mostrar el mensaje de la suma
    mov ah, 09h            ; Funci?n 09H para imprimir cadenas
    lea dx, mensaje3       ; Cargar la direcci?n del mensaje de resultado en DX
    int 21h                ; Mostrar el mensaje en pantalla

    ; Preparar para mostrar el resultado
    mov al, resultado       ; Cargar resultado en AL
    xor ah, ah             ; Limpiar AH para que AX tenga solo el resultado
    cmp al, 0              ; Verificar si el resultado es cero
    je mostrar_cero         ; Si es cero, ir a mostrar_cero

    ; Convertir a caracteres ASCII
    mov bx, 10             ; Divisor
    xor cx, cx             ; Limpiar CX para contar los d?gitos

convertir:
    xor dx, dx             ; Limpiar DX antes de dividir
    div bx                  ; Dividir AX entre 10
    push dx                 ; Guardar el residuo (d?gito)
    inc cx                  ; Incrementar el contador de d?gitos
    test ax, ax             ; Verificar si AX es cero
    jnz convertir           ; Repetir hasta que AX sea cero

    ; Mostrar los d?gitos en orden
mostrar_digitos:
    pop dx                  ; Obtener el d?gito
    add dl, 30h             ; Convertir a ASCII
    mov ah, 02h             ; Funci?n 02H para mostrar un car?cter
    int 21h                 ; Mostrar d?gito
    loop mostrar_digitos    ; Repetir para todos los d?gitos

    jmp fin                 ; Ir a la secci?n de finalizaci?n

mostrar_cero:
    ; Mostrar "0"
    mov dl, '0'             ; Cargar el car?cter '0'
    mov ah, 02h             ; Funci?n 02H para mostrar un car?cter
    int 21h                 ; Mostrar el car?cter '0'

fin:
    ; Nueva l?nea
    mov ah, 09h             ; Funci?n 09H para imprimir cadenas
    lea dx, nueva_linea     ; Cargar la direcci?n de nueva l?nea en DX
    int 21h                 ; Mostrar nueva l?nea

    ; Terminar el programa
    mov ax, 4C00h           ; Funci?n 4CH para salir
    int 21h                 ; Llamar a la interrupci?n para salir

main endp                  ; Fin del procedimiento principal
end main                   ; Fin del programa
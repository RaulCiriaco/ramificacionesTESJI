.model small
.stack
.data

u db 0
d db 0
n db 0

mensaje db 10, 13, 7, "Ingrese un numero: ", "$"
mensaje db 10, 13, 7, "Numero Ingresado:  ", "$"
.code
    main proc
mov ax, SEG @data ; Se asigna la localizaci?n de segmento
    mov ds, ax        ; Se colocan los datos contenidos en ax en el segmento
    
    ; Mostrar mensaje solicitando n?mero
    mov ah, 09h       ; Funci?n para mostrar cadena
    lea dx, mensaje   ; Leer mensaje
    int 21h           ; Interrupci?n de DOS para mostrar el mensaje
    
    ; Leer primer d?gito del n?mero
    mov ah, 01h       ; Funci?n para leer car?cter
    int 21h           ; Interrupci?n de DOS para obtener entrada de usuario
    sub al, 30h       ; Convertir car?cter ASCII a valor num?rico
    mov d, al         ; Guardar en la variable d
    
    ; Leer segundo d?gito del n?mero
    mov ah, 01h       ; Funci?n para leer car?cter
    int 21h           ; Interrupci?n de DOS
    sub al, 30h       ; Convertir car?cter ASCII a valor num?rico
    mov u, al         ; Guardar en la variable u
    
    ; Convertir el n?mero de dos d?gitos a su valor num?rico
    mov al, d         ; Cargar el primer d?gito
    mov bl, 10        ; Multiplicar por 10
    mul bl            ; Resultado en AX
    add al, u         ; Sumar el segundo d?gito
    mov n, al         ; Guardar el resultado en n
    
    ; Mostrar mensaje con el n?mero ingresado
    mov ah, 09h       ; Funci?n para mostrar cadena
    lea dx, mensaje2  ; Leer mensaje2
    int 21h           ; Interrupci?n de DOS para mostrar el mensaje
    
    ; Convertir el n?mero de un d?gito para imprimirlo
    mov al, n         ; Cargar el valor de n
    mov ah, 0         ; Limpiar AH
    AAM               ; Ajustar el n?mero en BH y BL
    
    ; Mostrar el primer d?gito (decenas)
    mov ah, 02h       ; Funci?n para imprimir car?cter
    mov dl, bh        ; Mover decenas a DL
    add dl, 30h       ; Convertir a ASCII
    int 21h           ; Interrupci?n de DOS para imprimir el car?cter
    
    ; Mostrar el segundo d?gito (unidades)
    mov ah, 02h       ; Funci?n para imprimir car?cter
    mov dl, bl        ; Mover unidades a DL
    add dl, 30h       ; Convertir a ASCII
    int 21h           ; Interrupci?n de DOS para imprimir el car?cter
    main endp
    end main
    
    
.model small
.stack
.data
 num1 db 0
 num2 db 0
 resultado_mul dw 0        ; Variable para almacenar el resultado de la multiplicaci?n (doble palabra para el producto)
 resultado_div db 0        ; Variable para almacenar el resultado de la divisi?n
 mensaje db 10, 13, "Primer numero (dos digitos): $"
 mensaje2 db 10, 13, "Segundo numero (dos digitos): $"
 mensaje_mul db 10, 13, "La multiplicacion es: $"
 mensaje_div db 10, 13, "La division es: $"
 error_div db 10, 13, "Error: Division por cero.$"  ; Mensaje de error para divisi?n entre cero
 nueva_linea db 10, 13, "$"
.code
main proc
 mov ax, @data
 mov ds, ax
 ; Solicitar primer n?mero de dos d?gitos
 mov ah, 09h
 lea dx, mensaje
 int 21h
 ; Leer el primer d?gito del primer n?mero
 mov ah, 01h
 int 21h
 sub al, 30h ; Convertir car?cter a n?mero
 mov bl, al ; Guardar el primer d?gito en bl
 ; Leer el segundo d?gito del primer n?mero
 mov ah, 01h
 int 21h
 sub al, 30h ; Convertir car?cter a n?mero
 mov bh, al ; Guardar el segundo d?gito en bh
 ; Calcular num1 = (primer_digito * 10) + segundo_digito
 mov al, bl
 mov ah, 0
 mov cl, 10
 mul cl ; Multiplicar por 10
 add al, bh ; Sumar el segundo d?gito
 mov num1, al ; Guardar el n?mero final en num1
 ; Solicitar segundo n?mero de dos d?gitos
 mov ah, 09h
 lea dx, mensaje2
 int 21h
 ; Leer el primer d?gito del segundo n?mero
 mov ah, 01h
 int 21h
 sub al, 30h ; Convertir car?cter a n?mero
 mov bl, al ; Guardar el primer d?gito en bl
 ; Leer el segundo d?gito del segundo n?mero
 mov ah, 01h
 int 21h
 sub al, 30h ; Convertir car?cter a n?mero
 mov bh, al ; Guardar el segundo d?gito en bh
 ; Calcular num2 = (primer_digito * 10) + segundo_digito
 mov al, bl
 mov ah, 0
 mul cl ; Multiplicar por 10
 add al, bh ; Sumar el segundo d?gito
 mov num2, al ; Guardar el n?mero final en num2

 ; Multiplicaci?n: num1 * num2
 mov al, num1
 mov ah, 0
 mul num2 ; Multiplicar num1 * num2
 mov resultado_mul, ax ; Guardar el resultado de la multiplicaci?n en resultado_mul
 ; Mostrar el mensaje de la multiplicaci?n
 mov ah, 09h
 lea dx, mensaje_mul
 int 21h
 ; Preparar para mostrar el resultado de la multiplicaci?n
 mov ax, resultado_mul ; Cargar resultado_mul en AX
 cmp ax, 0 ; Verificar si el resultado es cero
 je mostrar_cero
 ; Convertir a caracteres ASCII
 mov bx, 10 ; Divisor
 xor cx, cx ; Limpiar CX para contar los d?gitos
convertir_mul:
 xor dx, dx ; Limpiar DX antes de dividir
 div bx ; Dividir AX entre 10
 push dx ; Guardar el residuo (d?gito)
 inc cx ; Incrementar el contador de d?gitos
 test ax, ax ; Verificar si AX es cero
 jnz convertir_mul ; Repetir hasta que AX sea cero
 ; Mostrar los d?gitos en orden
mostrar_digitos_mul:
 pop dx ; Obtener el d?gito
 add dl, 30h ; Convertir a ASCII
 mov ah, 02h
 int 21h ; Mostrar d?gito
 loop mostrar_digitos_mul ; Repetir para todos los d?gitos

 ; Divisi?n: num1 / num2
 mov al, num1
 cmp num2, 0 ; Verificar si num2 es cero para evitar divisi?n por cero
 je error_division
 mov ah, 0
 div num2 ; Dividir num1 entre num2
 mov resultado_div, al ; Guardar el cociente en resultado_div
 ; Mostrar el mensaje de la divisi?n
 mov ah, 09h
 lea dx, mensaje_div
 int 21h
 ; Preparar para mostrar el resultado de la divisi?n
 mov al, resultado_div ; Cargar resultado_div en AL
 cmp al, 0 ; Verificar si el resultado es cero
 je mostrar_cero
 ; Convertir a caracteres ASCII
 mov bx, 10 ; Divisor
 xor cx, cx ; Limpiar CX para contar los d?gitos
convertir_div:
 xor dx, dx ; Limpiar DX antes de dividir
 div bx ; Dividir AX entre 10
 push dx ; Guardar el residuo (d?gito)
 inc cx ; Incrementar el contador de d?gitos
 test ax, ax ; Verificar si AX es cero
 jnz convertir_div ; Repetir hasta que AX sea cero
 ; Mostrar los d?gitos en orden
mostrar_digitos_div:
 pop dx ; Obtener el d?gito
 add dl, 30h ; Convertir a ASCII
 mov ah, 02h
 int 21h ; Mostrar d?gito
 loop mostrar_digitos_div ; Repetir para todos los d?gitos
 jmp fin

error_division:
 ; Mostrar mensaje de error
 mov ah, 09h
 lea dx, error_div
 int 21h
 jmp fin

mostrar_cero:
 ; Mostrar "0"
 mov dl, '0'
 mov ah, 02h
 int 21h

fin:
 ; Nueva l?nea
 mov ah, 09h
 lea dx, nueva_linea
 int 21h
 ; Terminar el programa
 mov ax, 4C00h
 int 21h
main endp
end main

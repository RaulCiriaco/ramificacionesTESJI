.model small
.stack 100h
.data
    mensajeNombre1 db "Ingresa el nombre de la primera persona: $"
    mensajeEdad1 db 10, 13, "Ingresa la edad de la primera persona: $"
    mensajeNombre2 db 10, 13, "Ingresa el nombre de la segunda persona: $"
    mensajeEdad2 db 10, 13, "Ingresa la edad de la segunda persona: $"
    mensajeMayor db 10, 13, "La persona mayor es: $"
    nombre1 db 30 dup('$')
    nombre2 db 30 dup('$')
    edad1 db 0
    edad2 db 0

.code
main proc
    ; Inicializar el segmento de datos
    mov ax, @data
    mov ds, ax

    ; Solicitar el nombre de la primera persona
    mov ah, 09h
    lea dx, mensajeNombre1
    int 21h
    mov ah, 0Ah
    lea dx, nombre1
    int 21h

    ; Solicitar la edad de la primera persona (2 d?gitos)
    mov ah, 09h
    lea dx, mensajeEdad1
    int 21h

    ; Leer el primer d?gito de la edad
    mov ah, 01h
    int 21h
    sub al, 30h
    mov bl, al ; Guardar el primer d?gito en BL

    ; Leer el segundo d?gito de la edad
    mov ah, 01h
    int 21h
    sub al, 30h
    mov bh, al ; Guardar el segundo d?gito en BH

    ; Calcular edad1 = (primer_digito * 10) + segundo_digito
    mov al, bl
    mov ah, 0
    mov cl, 10
    mul cl
    add al, bh
    mov edad1, al

    ; Solicitar el nombre de la segunda persona
    mov ah, 09h
    lea dx, mensajeNombre2
    int 21h
    mov ah, 0Ah
    lea dx, nombre2
    int 21h

    ; Solicitar la edad de la segunda persona (2 d?gitos)
    mov ah, 09h
    lea dx, mensajeEdad2
    int 21h

    ; Leer el primer d?gito de la edad
    mov ah, 01h
    int 21h
    sub al, 30h
    mov bl, al

    ; Leer el segundo d?gito de la edad
    mov ah, 01h
    int 21h
    sub al, 30h
    mov bh, al

    ; Calcular edad2 = (primer_digito * 10) + segundo_digito
    mov al, bl
    mov ah, 0
    mul cl
    add al, bh
    mov edad2, al

    ; Comparar las edades
    mov al, edad1
    cmp al, edad2
    jg primeraMayor
    jl segundaMayor

primeraMayor:
    ; Mostrar el nombre de la primera persona como mayor
    mov ah, 09h
    lea dx, mensajeMayor
    int 21h
    lea dx, nombre1+1 ; +1 para saltar la longitud del string
    mov ah, 09h
    int 21h
    jmp fin

segundaMayor:
    ; Mostrar el nombre de la segunda persona como mayor
    mov ah, 09h
    lea dx, mensajeMayor
    int 21h
    lea dx, nombre2+1 ; +1 para saltar la longitud del string
    mov ah, 09h
    int 21h

fin:
    ; Terminar el programa
    mov ax, 4C00h
    int 21h

main endp
end main

.model small
.stack 64
.data
cadena db "Las vocales tienen seis letras$"
num equ $-cadena ; Calcula la longitud de la cadena
tiene db 10, 13, "tiene un total de vocales: $"
total db 0

.code
principal proc
    mov ax, @data
    mov ds, ax

    mov si, 0
    mov dx, 0
    mov cx, num

etiqueta:
    mov al, cadena[si]
    cmp al, 'a'
    je vocal
    cmp al, 'e'
    je vocal
    cmp al, 'i'
    je vocal
    cmp al, 'o'
    je vocal
    cmp al, 'u'
    je vocal

regresa:
    inc si
    loop etiqueta

    mov total, dl
    mov ah, 09h
    lea dx, cadena
    int 21h
    
    mov ah, 09h
    lea dx, tiene
    int 21h
    
    mov ax, 0
    mov al, total
    aaa
    add ax, 3030h
    mov bx, ax
    
    mov ah, 02h
    mov dl, bh
    int 21h
    
    mov ah, 02h
    mov dl, bl
    int 21h
    jmp salir
    
vocal:
    inc dl
    jmp regresa

salir:
    mov ax, 4C00h ; Terminar el programa
    int 21h

principal endp
end principal

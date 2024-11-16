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
    mov ss, 0
    mov dx, 0
    
    mov dl, 0
    mov dh, 0
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
consonante:
    mov al, cadena[ss]
    ; Si no es vocal, verificar si es una consonante
    cmp al, 'b'
    je consonante
    cmp al, 'c'
    je consonante
    cmp al, 'd'
    je consonante
    cmp al, 'f'
    je consonante
    cmp al, 'g'
    je consonante
    cmp al, 'h'
    je consonante
    cmp al, 'j'
    je consonante
    cmp al, 'k'
    je consonante
    cmp al, 'l'
    je consonante
    cmp al, 'm'
    je consonante
    cmp al, 'n'
    je consonante
    cmp al, 'p'
    je consonante
    cmp al, 'q'
    je consonante
    cmp al, 'r'
    je consonante
    cmp al, 's'
    je consonante
    cmp al, 't'
    je consonante
    cmp al, 'v'
    je consonante
    cmp al, 'w'
    je consonante
    cmp al, 'x'
    je consonante
    cmp al, 'y'
    je consonante
    cmp al, 'z'
    je consonante
    
regresa:
    inc ss
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
consonante:
    inc dh
    jmp regresa
salir:
    mov ax, 4C00h ; Terminar el programa
    int 21h

principal endp
end principal
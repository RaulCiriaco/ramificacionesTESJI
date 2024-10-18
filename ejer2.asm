CR equ 13; /retorno de carro
LF equ 0Ah; /Inicio de linea

Datos Segment 
    Mensaje db CR, LF,'Hola Mundo (con funcion o procedimiento )' ,CR,LF,'$'  
Datos Ends
Pila Segment Stack

db 64 DUP('PILA')
Pila Ends
Codigo Segment
    holam proc far
    
    Assume CS:Codigo, DS:Datos, SS:Pila
    mov ax, Datos
    mov ds, ax
    lea dx, Mensaje
    call Escribe
    mov ax, 4c00h
    int 21h
    holam endp
    
    Escribe proc
    mov ah, 9
    int 21h
    ret
    Escribe endp    
Codigo Ends
end holam
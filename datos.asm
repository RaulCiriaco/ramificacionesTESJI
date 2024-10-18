CR EQU 13
LF EQU 10
CP EQU 32  ; Espacio en blanco

DATOS SEGMENT
    LINEA1 DB CP,LF, 'Raul Ciriaco Castillo', CR, LF, '$'
    LINEA2 DB CP,LF, 'Tecnologico de Estudios Superiores de Jilotepec', CR, LF, '$'
    LINEA3 DB CP,LF, 'Ing. Sistemas Computacionales', CR, LF, '$'
    LINEA4 DB CP,LF, 'Raulito :)', CR, LF, '$'
DATOS ENDS

PILA SEGMENT STACK
    DB 64 DUP(?)  ; Reservar 64 bytes para la pila
PILA ENDS

CODIGO SEGMENT
    ASSUME CS:CODIGO, DS:DATOS, SS:PILA
    
    LN PROC FAR
        MOV AX, DATOS
        MOV DS, AX
        
        LEA DX, LINEA1
        CALL ESCRIBE
        
        LEA DX, LINEA2
        CALL ESCRIBE
        
        LEA DX, LINEA3
        CALL ESCRIBE
        
        LEA DX, LINEA4
        CALL ESCRIBE
        
        MOV AX, 4C00H  ; Instrucci?n correcta para salir
        INT 21H
    LN ENDP

    ESCRIBE PROC
        MOV AH, 9   ; Funci?n 09H para imprimir cadenas en DOS
        INT 21H
        RET
    ESCRIBE ENDP
CODIGO ENDS

END LN
    
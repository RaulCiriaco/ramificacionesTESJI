title "EyPC 2020-II Grupo 2 Proyecto 2 - Base"
;@author: Andres Urbano Guillermo Gerardo
    .model small
    .386
    .stack 64
;Macros
;clear - Limpia pantalla
clear macro
    mov ax,0003h    ;ah = 00h, selecciona modo video
                    ;al = 03h. Modo texto, 16 colores
    int 10h     ;llama interrupcion 10h con opcion 00h. 
                ;Establece modo de video limpiando pantalla
endm
;posiciona_cursor - Cambia la posici?n del cursor a la especificada con 'renglon' y 'columna' 
posiciona_cursor macro renglon,columna
    mov dh,renglon  ;dh = renglon
    mov dl,columna  ;dl = columna
    mov bx,0
    mov ax,0200h    ;preparar ax para interrupcion, opcion 02h
    int 10h         ;interrupcion 10h y opcion 02h. Cambia posicion del cursor
endm 
;inicializa_ds - Inicializa el valor del registro DS
inicializa_ds   macro
    mov ax,@data
    mov ds,ax
endm
;muestra_cursor_mouse - Establece la visibilidad del cursor del mouser
muestra_cursor_mouse    macro
    mov ax,1        ;opcion 0001h
    int 33h         ;int 33h para manejo del mouse. Opcion AX=0001h
                    ;Habilita la visibilidad del cursor del mouse en el programa
endm
;oculta_cursor_teclado - Oculta la visibilidad del cursor del teclado
oculta_cursor_teclado   macro
    mov ah,01h      ;Opcion 01h
    mov cx,2607h    ;Parametro necesario para ocultar cursor
    int 10h         ;int 10, opcion 01h. Cambia la visibilidad del cursor del teclado
endm
;imprime_caracter_color - Imprime un caracter de cierto color en pantalla especificado por 'caracter' y 'color'. Los colores disponibles est?n en la lista a continuacion;
; Colores:
; 00h: Negro
; 01h: Azul
; 02h: Verde
; 03h: Cyan
; 04h: Rojo
; 05h: Magenta
; 06h: Cafe
; 07h: Gris Claro
; 08h: Gris Oscuro
; 09h: Azul Claro
; 0Ah: Verde Claro
; 0Bh: Cyan Claro
; 0Ch: Rojo Claro
; 0Dh: Magenta Claro
; 0Eh: Amarillo
; 0Fh: Blanco
; utiliza int 10h opcion 09h
imprime_caracter_color macro caracter,color
    mov ah,09h              ;preparar AH para interrupcion, opcion 09h
    mov al,caracter         ;DL = caracter a imprimir
    mov bh,0                ;BH = numero de pagina
    mov bl,color            ;BL = color del caracter
    mov cx,1                ;CX = numero de veces que se imprime el caracter
                            ;CX es un argumento necesario para opcion 09h de int 10h
    int 10h                 ;int 10h, AH=09h, imprime el caracter en AL con el color BL
endm
;lee_mouse - Revisa el estado del mouse
;Devuelve:
;;BX - estado de los botones
;;;Si BX = 0000h, ningun boton presionado
;;;Si BX = 0001h, boton izquierdo presionado
;;;Si BX = 0002h, boton derecho presionado
;;;Si BX = 0003h, boton izquierdo y derecho presionados
;;CX - columna en la que se encuentra el mouse en resolucion 640x200 (columnas x renglones)
;;DX - renglon en el que se encuentra el mouse en resolucion 640x200 (columnas x renglones)
lee_mouse   macro
    mov ax,0003h
    int 33h
endm
;comprueba_mouse - Revisa si el driver del mouse existe
comprueba_mouse     macro
    mov ax,0        ;opcion 0
    int 33h         ;llama interrupcion 33h para manejo del mouse, devuelve un valor en AX
                    ;Si AX = 0000h, no existe el driver. Si AX = FFFFh, existe driver
endm
    .data
;Constantes de colores de modo de video
cNegro          equ     00h
cAzul           equ     01h
cVerde          equ     02h
cCyan           equ     03h
cRojo           equ     04h
cMagenta        equ     05h
cCafe           equ     06h
cGrisClaro      equ     07h
cGrisOscuro     equ     08h
cAzulClaro      equ     09h
cVerdeClaro     equ     0Ah
cCyanClaro      equ     0Bh
cRojoClaro      equ     0Ch
cMagentaClaro   equ     0Dh
cAmarillo       equ     0Eh
cBlanco         equ     0Fh

digitos     equ     4

num1        db      digitos dup(0)      ;primer numero, en cada localidad guarda 1 digito, puede ser hasta 4 digitos
num2        db      digitos dup(0)      ;segundo numero, en cada localidad guarda 1 digito, puede ser hasta 4 digitos
num1h       dw      0
num2h       dw      0
poten   dw  0001d   ;Para la conversion del numero
resultado   dw      0,0             ;resultado es un arreglo de 2 datos tipo word
                                    ;el primer dato [resultado] puede guardar el contenido del resultado para la suma, resta, cociente de division o residuo de division
                                    ;el segundo dato [resultado+2], en conjunto con [resultado] pueden almacenar la multiplicacion de dos numeros de 16 bits
conta1      dw      0
conta2      dw      0
operador    db      0
num_boton   db      0
num_impr    db      0

aux dw  ?
msgresta    db  "La resta de ambos numeros es :$"
msgresta2   db  "La resta de ambos numeros es: un numero negativo$"

;Auxiliares para calculo de digitos de un numero decimal de hasta 5 digitos
diezmil     dw      10000d
mil         dw      1000d
cien        dw      100d
diez        dw      10d
;Auxiliar para calculo de coordenadas del mouse
ocho        db      8
;Cuando el driver del mouse no esta disponible
no_mouse        db  'No se encuentra driver de mouse. Presione [enter] para salir$'

;MARCO PRINCIPAL DE LA INTERFAZ GRAFICA
;Caracteres del marco superior
;columnas       000,    001     002     003     004     005     006     007     008     009     010     011     012     013     014     015     016     017     018     019     020     021     022     023     024     025     026     027     028     029     030     031     032     033     034     035     036     037     038     039     040     041     042     043     044     045     046     047     048     049     050     051     052     053     054     055     056     057     058     059     060     061     062     063     064     065     066     067     068     069     070     071     072     073     074     075     076     077     078     079
marco_sup   db  201,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    'C',    'A',    'L',    'C',    'U',    'L',    'A',    'D',    'O',    'R',    'A',    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    '[',    'X',    ']',    187
;Caracter del marco lateral
marco_lat   db  186
;Caracteres del marco inferior
marco_inf   db  200,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    188

;MARCO DE LA CALCULADORA
;Caracteres del marco superior
;                   000,    001     002     003     004     005     006     007     008     009     010     011     012     013     014     015     016     017     018     019     020     021     022     023     024     025     026     027     028     029     030     031     032     033     034     035     036     037     038     039
marco_sup_cal   db  201,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    187
;Caracter del marco lateral
marco_lat_cal   db  186
;Caracter del marco de cruce superior
marco_csup_cal  db  203
;Caracter del marco de cruce inferior
marco_cinf_cal  db  202
;Caracter del marco de cruce izquierdo
marco_cizq_cal  db  204
;Caracter del marco de cruce derecho
marco_cder_cal  db  185
;Caracteres del marco inferior
marco_inf_cal   db  200,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    205,    188
;Caracter del marco horizontal interno
marco_hint_cal  db  205
;Caracter del marco vertical interno
marco_vint_cal  db  186

;MARCO DE BOTON
;Caracteres del marco superior
;                   000,    001     002     003     004
marco_sup_bot   db  218,    196,    196,    196,    191
;Caracter del marco lateral
marco_lat_bot   db  179
;Caracteres del marco inferior
marco_inf_bot   db  192,    196,    196,    196,    217

;Variables tipo byte auxiliares cuando se manejan renglones y columnas dentro de la pantalla
ren_aux         db      0
col_aux         db      0

;Variables que sirven de parametros para el procedimiento IMPRIME_BOTON
caracter_boton  db      0
renglon_boton   db      0
columna_boton   db      0
color_boton     db      0

    .code
inicio:
    inicializa_ds
    comprueba_mouse     ;macro para revisar driver de mouse
    xor ax,0FFFFh       ;compara el valor de AX con FFFFh, si el resultado es zero, entonces existe el driver de mouse
    jz imprime_ui       ;Si existe el driver del mouse, entonces salta a 'imprime_ui'
    ;Si no existe el driver del mouse entonces se ejecutan las siguientes instrucciones
    lea dx,[no_mouse]
    mov ax,0900h    ;opcion 9 para interrupcion 21h
    int 21h         ;interrupcion 21h. Imprime cadena.
    jmp teclado     ;salta a 'teclado'
imprime_ui:
    clear                   ;limpia pantalla
    oculta_cursor_teclado   ;oculta cursor del mouse
    call MARCO_UI           ;procedimiento que dibuja marco de la interfaz
    call CALCULADORA_UI     ;procedimiento que dibuja la calculadora dentro de la interfaz
    muestra_cursor_mouse    ;hace visible el cursor del mouse

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Revisar que el boton izquierdo del mouse no este presionado
;Si el boton no esta suelto no continua
mouse_no_clic:
    lee_mouse
    test bx,0001h
    jnz mouse_no_clic

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Lee el mouse y avanza hasta que se haga clic en el boton izquierdo
mouse:
    lee_mouse
    test bx,0001h       ;Para revisar si el boton izquierdo del mouse fue presionado
    jz mouse            ;Si el boton izquierdo no fue presionado, vuelve a leer el estado del mouse
    
    ;Leer la posicion del mouse y hacer la conversion a resolucion
    ;80x25 (columnas x renglones) en modo texto
    mov ax,dx           ;Copia DX en AX. DX es un valor entre 0 y 199 (renglon)
    div [ocho]          ;Division de 8 bits
                        ;divide el valor del renglon en resolucion 640x200 en donde se encuentra el mouse
                        ;para obtener el valor correspondiente en resolucion 80x25
    xor ah,ah           ;Descartar el residuo de la division anterior
    mov dx,ax           ;Copia AX en DX. AX es un valor entre 0 y 24 (renglon)
    

    mov ax,cx           ;Copia CX en AX. CX es un valor entre 0 y 639 (columna)
    div [ocho]          ;Division de 8 bits
                        ;divide el valor de la columna en resolucion 640x200 en donde se encuentra el mouse
                        ;para obtener el valor correspondiente en resolucion 80x25
    xor ah,ah           ;Descartar el residuo de la division anterior
    mov cx,ax           ;Copia AX en CX. AX es un valor entre 0 y 79 (columna)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Aqui va la l?gica de la posicion del mouse;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;Si el mouse fue presionado en el renglon 0
    ;se va a revisar si fue dentro del boton [X]
    cmp dx,0
    je botonX
    ;Si el mouse fue presionado antes del renglon 9
    ;no hay nada que revisar
    cmp dx,9
    jb mouse_no_clic
    ;Si el mouse fue presionado despues del renglon 20
    ;no hay nada que revisar
    cmp dx,20
    jg mouse_no_clic
    ;Si el mouse fue presionado antes de la columna 24
    ;no hay nada que revisar
    cmp cx,24
    jb mouse_no_clic
    ;Si el mouse fue presionado despues de la columna 57
    ;no hay nada que revisar
    cmp cx,57
    jg mouse_no_clic

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;Si el mouse fue presionado antes o dentro de la columna 28
    ;revisar si fue dentro de un boton
    ;Botones entre columnas 24 y 28: '7', '4', '1', 'C'
    cmp cx,28
    jbe botones_7_4_1_C

    ;Si el mouse fue presionado en la columna 29
    ;en esa columna no hay boton
    cmp cx,29
    je mouse_no_clic

    ;Si el mouse fue presionado antes o dentro de la columna 34
    ;revisar si fue dentro de un boton
    ;Botones entre columnas 30 y 34: '8', '5', '2', '0'
    cmp cx,34
    jbe botones_8_5_2_0

    ;Si el mouse fue presionado en la columna 35
    ;en esa columna no hay boton
    cmp cx,35
    je mouse_no_clic


    cmp cx, 40
    jbe botones_9_6_3_z

    cmp cx, 45
    jbe mouse_no_clic

    cmp cx, 50
    jbe botones_sum_mul_mod

    cmp cx, 52
    jbe mouse_no_clic

    cmp cx, 57
    jbe botones_sub_div_equ


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Esta seccion esta dedicada solo a detectar que pones se esta presionando y mandar a las funiones
;correspondiente
jmp_mouse_no_clic:
    jmp mouse_no_clic

botones_7_4_1_C:
    ;Revisar si el renglon en donde fue presionado el mouse
    ;corresponde con boton '7'
    cmp dx,11
    jbe boton7

    ;Revisar si el renglon en donde fue presionado el mouse
    ;corresponde con boton '4'
    cmp dx,14
    jbe boton4

    ;Revisar si el renglon en donde fue presionado el mouse
    ;corresponde con boton '1'
    cmp dx,17
    jbe boton1

    ;Revisar si el renglon en donde fue presionado el mouse
    ;corresponde con boton 'C'
    cmp dx,20
    jbe botonC

    ;Si no es ninguno de los anteriores
    jmp mouse_no_clic

botones_8_5_2_0:
    ;Revisar si el renglon en donde fue presionado el mouse
    ;corresponde con boton '8'
    cmp dx,11
    jbe boton8
    ;Revisar si el renglon en donde fue presionado el mouse
    ;corresponde con boton '5'
    cmp dx,14
    jbe boton5
    ;Revisar si el renglon en donde fue presionado el mouse
    ;corresponde con boton '2'
    cmp dx,17
    jbe boton2
    ;Revisar si el renglon en donde fue presionado el mouse
    ;corresponde con boton '0'
    cmp dx,20
    jbe boton0
    ;Si no es ninguno de os anteriores
    jmp mouse_no_clic

botones_9_6_3_z:
    ;Revisar si el renglon en donde fue presionado el mouse
    ;corresponde con boton 
    cmp dx,11
    jbe boton9
    ;Revisar si el renglon en donde fue presionado el mouse
    ;corresponde con boton 
    cmp dx,14
    jbe boton6
    ;Revisar si el renglon en donde fue presionado el mouse
    ;corresponde con boton 
    cmp dx,17
    jbe boton3
    ;Revisar si el renglon en donde fue presionado el mouse
    ;corresponde con boton 
    cmp dx,20
    jbe botonDEL
    ;Si no es ninguno de os anteriores
    jmp mouse_no_clic

botones_sum_mul_mod:
    cmp dx,11
    jbe botonSuma

    cmp dx, 12
    je mouse_no_clic

    cmp dx, 15
    jbe botonMult

    cmp dx, 16
    je mouse_no_clic

    cmp dx, 19
    jbe botonDivR

    ;Si no es ninguno de os anteriores
    jmp mouse_no_clic


botones_sub_div_equ:

    cmp dx,11
    jbe botonResta

    cmp dx, 12
    je mouse_no_clic

    cmp dx, 15
    jbe botonDivC

    cmp dx, 16
    je mouse_no_clic

    cmp dx, 19
    jbe botonIgual


    ;Si no es ninguno de los anteriores
    jmp mouse_no_clic
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Dependiendo la posicion del mouse
;se salta a la seccion correspondiente
botonX:
    jmp botonX_1
botonC:
    jmp botonC_1
boton0:
    jmp boton0_2
boton1:
    jmp boton1_1
boton2:
    jmp boton2_2
boton3:
    jmp boton3_2
boton4:
    jmp boton4_2
boton5:
    jmp boton5_2
boton6:
    jmp boton6_2
boton7:
    jmp boton7_2
boton8:
    jmp boton8_2
boton9:
    jmp boton9_2

botonDEL:
    jmp botonDEL_2
botonSuma:
    jmp botonSuma_2
botonResta:
    jmp botonResta_2
botonMult:
    jmp botonMult_2
botonDivC:
    jmp botonDivC_2
botonDivR:
    jmp botonDivR_2
botonIgual:
    jmp botonIgual_2

    ;Ninguna de las anteriores
    jmp mouse_no_clic

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Logica para revisar si el mouse fue presionado en [X]
;[X] se encuentra en renglon 0 y entre columnas 76 y 79
botonX_1:
    cmp cx,76
    jge botonX_2
    jmp mouse_no_clic
botonX_2:
    cmp cx,79
    jbe botonX_3
    jmp mouse_no_clic
botonX_3:
    ;Se cumplieron todas las condiciones
    jmp salir

;Logica para revisar si el mouse fue presionado en '1'
;boton '1' se encuentra entre renglones 15 y 17,
;y entre columnas 24 y 28
boton1_1:
    cmp dx,15       
    jge boton1_2
    jmp mouse_no_clic
boton1_2:
    cmp dx,17
    jbe boton1_3
    jmp mouse_no_clic
boton1_3:
    ;Se cumplieron todas las condiciones
    mov num_boton,1
    jmp jmp_lee_num1        ;Salto a 'jmp_lee_num1' para procesar el numero




boton0_2:
    mov num_boton,0
    jmp jmp_lee_num1        ;Salto a 'jmp_lee_num1' para procesar el numero
boton2_2:
    mov num_boton,2
    jmp jmp_lee_num1        ;Salto a 'jmp_lee_num1' para procesar el numero
boton3_2:
    mov num_boton,3
    jmp jmp_lee_num1        ;Salto a 'jmp_lee_num1' para procesar el numero
boton4_2:
    mov num_boton,4
    jmp jmp_lee_num1        ;Salto a 'jmp_lee_num1' para procesar el numero
boton5_2:
    mov num_boton,5
    jmp jmp_lee_num1        ;Salto a 'jmp_lee_num1' para procesar el numero
boton6_2:
    mov num_boton,6
    jmp jmp_lee_num1        ;Salto a 'jmp_lee_num1' para procesar el numero
boton7_2:
    mov num_boton,7
    jmp jmp_lee_num1        ;Salto a 'jmp_lee_num1' para procesar el numero
boton8_2:
    mov num_boton,8
    jmp jmp_lee_num1        ;Salto a 'jmp_lee_num1' para procesar el numero
boton9_2:
    mov num_boton,9
    jmp jmp_lee_num1        ;Salto a 'jmp_lee_num1' para procesar el numero



botonDEL_2:
    ;Todavia no le he dado una funcionalidad por eso puse ese jmp
    ;Hacemos un decremento con conta1
    ;Pero antes guardamos su valor para despues imprimir el caracter vacio
    mov ax, conta1

    cmp [operador],0    ;compara el valor del operador que puede ser 0, '+', '-', '*', '/', '%'
    jne del_num2        ;Si el comparador es diferente de 0, es num2

    ;Comparamos si es unico numero esl que quiere eliminar de num1
    cmp [conta1],1d
    jle resetnum1


    ;Ahora limpiamos la parte izquierda qeu ya no cuenta como un numero
    ;Imprime el caracter vacio
    mov [ren_aux],3     ;variable ren_aux para hacer operaciones en pantalla 
                        ;ren_aux se mantiene fijo a lo largo del siguiente loop
    mov [col_aux],58d       ;variable col_aux para hacer operaciones en pantalla 

    sub [col_aux],al        ;Para calcular la columna en donde comienza a imprimir en pantalla de acuerdo a CX
    posiciona_cursor [ren_aux],[col_aux]    ;Posiciona el cursor en pantalla usando ren_aux y col_aux
    mov cl,00h              ;Pasa valor ASCII signo del operando en ANSII
    imprime_caracter_color cl,cAzulClaro    ;Imprime caracter en CL, color blanco
    
    ;Imprimmos el nuevo valor
    sub [conta1], 1d
    ;Se imprime el numero del arreglo num1 de acuerdo a conta1
    xor di,di           ;limpia DI para utilizarlo
    mov cx,[conta1]     ;prepara CX para loop de acuerdo al numero de digitos introducidos
    mov [ren_aux],3     ;variable ren_aux para hacer operaciones en pantalla 
                        ;ren_aux se mantiene fijo a lo largo del siguiente loop
    jmp imprime_num1

resetnum1:
    mov [conta1], 0d ;Reinicia a contador a cero
    ;Le ponemos vacio
    mov [col_aux],57d       ;variable col_aux para hacer operaciones en pantalla 
    mov [ren_aux],3     ;variable ren_aux para hacer operaciones en pantalla 
    posiciona_cursor [ren_aux],[col_aux]    ;Posiciona el cursor en pantalla usando ren_aux y col_aux
    mov cl,00h              ;Pasa valor ASCII signo del operando en ANSII
    imprime_caracter_color cl,cAzulClaro    ;Imprime caracter en CL, color blanco
    jmp mouse_no_clic

del_num2:
    ;Comparamos si es unico numero es el que quiere eliminar de num2
    cmp [conta2],1d
    jle resetnum2

    mov ax, [conta2]

    ;Ahora limpiamos la parte izquierda qeu ya no cuenta como un numero
    ;Imprime el caracter vacio
    mov [ren_aux],5 ;variable ren_aux para hacer operaciones en pantalla 
                        ;ren_aux se mantiene fijo a lo largo del siguiente loop
    mov [col_aux],58d       ;variable col_aux para hacer operaciones en pantalla 

    sub [col_aux],al        ;Para calcular la columna en donde comienza a imprimir en pantalla de acuerdo a CX
    posiciona_cursor [ren_aux],[col_aux]    ;Posiciona el cursor en pantalla usando ren_aux y col_aux
    mov cl,00h              ;Pasa valor ASCII signo del operando en ANSII
    imprime_caracter_color cl,cAzulClaro    ;Imprime caracter en CL, color blanco
    
    ;Imprimmos el nuevo valor
    sub [conta2], 1d
    ;Se imprime el numero del arreglo num1 de acuerdo a conta1
    xor di,di           ;limpia DI para utilizarlo
    mov cx,[conta2]     ;prepara CX para loop de acuerdo al numero de digitos introducidos
    mov [ren_aux],5 ;variable ren_aux para hacer operaciones en pantalla 
                        ;ren_aux se mantiene fijo a lo largo del siguiente loop
    jmp imprime_num2


resetnum2:
    ;Si entra aqui sabemos que ya solo un numero pueda dar la alternativa de que borre el primer numero
    ;si quiere
    mov [conta2], 0d ;Reinicia a contador a cero
    ;Le ponemos vacio
    mov [col_aux],57d       ;variable col_aux para hacer operaciones en pantalla 
    mov [ren_aux],5     ;variable ren_aux para hacer operaciones en pantalla 
    posiciona_cursor [ren_aux],[col_aux]    ;Posiciona el cursor en pantalla usando ren_aux y col_aux
    mov cl,00h              ;Pasa valor ASCII signo del operando en ANSII
    imprime_caracter_color cl,cAzulClaro    ;Imprime caracter en CL, color blanco
    
    ;Borramos el operador y lo inicializamos a cero
    mov [operador], 0d
    ;Le ponemos vacio
    mov [col_aux],57d       ;variable col_aux para hacer operaciones en pantalla 
    mov [ren_aux],4     ;variable ren_aux para hacer operaciones en pantalla 
    posiciona_cursor [ren_aux],[col_aux]    ;Posiciona el cursor en pantalla usando ren_aux y col_aux
    mov cl,00h              ;Pasa valor ASCII signo del operando en ANSII
    imprime_caracter_color cl,cAzulClaro    ;Imprime caracter en CL, color blanco

    jmp mouse_no_clic


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

botonSuma_2:
    mov [operador], 1d ; 1 = significara operacion suma
    mov [col_aux],57d       ;variable col_aux para hacer operaciones en pantalla 
    mov [ren_aux],4     ;variable ren_aux para hacer operaciones en pantalla 
    posiciona_cursor [ren_aux],[col_aux]    ;Posiciona el cursor en pantalla usando ren_aux y col_aux
    mov cl,2Bh              ;Pasa valor ASCII signo del operando en ANSII
    imprime_caracter_color cl,cAzulClaro    ;Imprime caracter en CL, color blanco
    jmp mouse_no_clic

botonResta_2:

    mov [operador], 2d ;  = significara operacion resta
    mov [col_aux],57d       ;variable col_aux para hacer operaciones en pantalla 
    mov [ren_aux],4     ;variable ren_aux para hacer operaciones en pantalla 
    posiciona_cursor [ren_aux],[col_aux]    ;Posiciona el cursor en pantalla usando ren_aux y col_aux
    mov cl,2Dh              ;Pasa valor ASCII signo del operando en ANSII
    imprime_caracter_color cl,cAzulClaro    ;Imprime caracter en CL, color blanco
    jmp mouse_no_clic

botonMult_2:
    mov [operador], 3d ; = significara operacion MULT
    mov [col_aux],57d       ;variable col_aux para hacer operaciones en pantalla 
    mov [ren_aux],4     ;variable ren_aux para hacer operaciones en pantalla 
    posiciona_cursor [ren_aux],[col_aux]    ;Posiciona el cursor en pantalla usando ren_aux y col_aux
    mov cl,2Ah              ;Pasa valor ASCII signo del operando en ANSII
    imprime_caracter_color cl,cAzulClaro    ;Imprime caracter en CL, color blanco
    jmp mouse_no_clic

botonDivC_2:
    mov [operador], 4d ;  = significara operacion div Cociente
    mov [col_aux],57d       ;variable col_aux para hacer operaciones en pantalla 
    mov [ren_aux],4     ;variable ren_aux para hacer operaciones en pantalla 
    posiciona_cursor [ren_aux],[col_aux]    ;Posiciona el cursor en pantalla usando ren_aux y col_aux
    mov cl,2Fh              ;Pasa valor ASCII signo del operando en ANSII
    imprime_caracter_color cl,cAzulClaro    ;Imprime caracter en CL, color blanco
    jmp mouse_no_clic

botonDivR_2:
    mov [operador], 5d ;  = significara operacion division residu
    mov [col_aux],57d       ;variable col_aux para hacer operaciones en pantalla 
    mov [ren_aux],4     ;variable ren_aux para hacer operaciones en pantalla 
    posiciona_cursor [ren_aux],[col_aux]    ;Posiciona el cursor en pantalla usando ren_aux y col_aux
    mov cl,25h              ;Pasa valor ASCII signo del operando en ANSII
    imprime_caracter_color cl,cAzulClaro    ;Imprime caracter en CL, color blanco
    jmp mouse_no_clic

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,,

botonIgual_2:
    ;Limpiar el numero si quiere volver a intentarlo hacer
    ;Le ponemos vacio
    mov cx, 9d
    xor ax, ax
    mov al, 58d
limp:
    push cx
    push ax
    mov [col_aux],al        ;variable col_aux para hacer operaciones en pantalla 
    mov [ren_aux],6     ;variable ren_aux para hacer operaciones en pantalla 
    posiciona_cursor [ren_aux],[col_aux]    ;Posiciona el cursor en pantalla usando ren_aux y col_aux
    mov cl,00h              ;Pasa valor ASCII signo del operando en ANSII
    imprime_caracter_color cl,cAzulClaro    ;Imprime caracter en CL, color blanco
    pop ax
    sub al, 1d
    pop cx
    loop limp


    ;Dibujamos el igual
    mov [col_aux],48d       ;variable col_aux para hacer operaciones en pantalla 
    mov [ren_aux],6     ;variable ren_aux para hacer operaciones en pantalla 
    posiciona_cursor [ren_aux],[col_aux]    ;Posiciona el cursor en pantalla usando ren_aux y col_aux
    mov cl,3Dh              ;Pasa valor ASCII signo del operando en ANSII
    imprime_caracter_color cl,cAmarillo ;Imprime caracter en CL, color blanco

    ;Todavia no le he dado una funcionalidad por eso puse ese jmp
    ;Se supone que cuando presione igual tendremos los dos numeros en memoria, es decir
    ;num1 = xxxx
    ;num2 = yyyy
    ;Tareas por hacer para funcionalidad
    ;1.-Convertir esos numeros ASCII en numeros reales que pueda entender el computer
    ;2.-Despues faltaria  es hacer las operaciones correspodientes suma,resta,mul,div,mod

    ;Reajustamos los valores por defecto por si se quiere volver hacerlo
    mov num1h, 0
    mov num2h, 0
    mov poten, 0001d ;Reiniciamos valores

    ;Convertir el primer numero (num1)
    mov cx, conta1
    mov di, cx
    dec di ; Por el ultimo del arreglo es tres en el caso que sea 4 digitos, e.g:
    ;[7 | 3 | 5 | 2]
    ; 0   1   2   3 
    ;; Convertimos nuestro digitos ascii en numeros
ajustar:
    mov ax, poten
    mov bh,00d
    mov bl, [num1+di] ; num1*potenc 
    mul bx
    add num1h, ax      ; num1h = num1h + num1*potenc

    mov ax,10d
    mul poten
    mov poten, ax   ;Aumentamos unidades 1, 10, 100, 1000 en cada ciclo
    dec di          ; Ir recorriendo el numero 3, 2 , 1, 0
    loop ajustar

    mov ax, num1h   ;Verificamos el numero
    xor ax, ax

    ;Convertir el segundo numero (num2)
    mov poten, 0001d
    mov cx, conta2

    mov di, cx
    dec di
    
    ;; Convertimos nuestro digitos ascii en numeros
ajustar2:
    mov ax, poten
    mov bh,00d
    mov bl, [num2+di]
    mul bx
    add num2h, ax

    mov ax,10d
    mul poten
    mov poten, ax
    dec di
    loop ajustar2

    mov ax, num2h
    xor ax, ax

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,,
    ;Test para conocer los valores que que sean registrados num1h y num2h correctamente
    
    ;mov bx, num1h  
    ;mov [col_aux],40d      ;variable col_aux para hacer operaciones en pantalla 
    ;mov [ren_aux],4    ;variable ren_aux para hacer operaciones en pantalla 
    ;call IMPRIME_BX


    ;mov bx, num2h 
    ;mov [col_aux],40d      ;variable col_aux para hacer operaciones en pantalla 
    ;mov [ren_aux],5    ;variable ren_aux para hacer operaciones en pantalla 
    ;call IMPRIME_BX

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,

    ;2.-Despues faltaria  es hacer las operaciones correspodientes suma,resta,mul,div,mod
    ;Ajustamos la posicion para el resultado para cualquier operacion en el momento de la impresion
    mov [col_aux],53d       ;variable col_aux para hacer operaciones en pantalla 
    mov [ren_aux],6     ;variable ren_aux para hacer operaciones en pantalla 

    ;Hacemos comparaciones para saber que operacion es la correspodiente
    cmp [operador], 1d
    je suma
    cmp [operador], 2d
    je resta
    cmp [operador], 3d
    je multipli
    cmp [operador], 4d
    je division
    cmp [operador], 5d
    je modulo



    jmp mouse_no_clic ; nunca entra este caso pero por si las moscas
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



suma:
    mov bx, num1h
    add bx, num2h
    ;posiciona_cursor [ren_aux],[col_aux]   ;Posiciona el cursor en pantalla usando ren_aux y col_aux
    call IMPRIME_BX
    jmp mouse_no_clic 

resta:
    mov bx, num1h
    sub bx, num2h
    js negativo
    jmp positivo

negativo:
    ;Se debe utilizar el complemento a dos para conocer el valor e imprimir el signo
    ;1.-Imprimir el signo
    push bx ;Guardamos el valor, por si se modifica en el momento de imprimir el signo
    mov [col_aux],53d       ;variable col_aux para hacer operaciones en pantalla 
    mov [ren_aux],6     ;variable ren_aux para hacer operaciones en pantalla 
    posiciona_cursor [ren_aux],[col_aux]    ;Posiciona el cursor en pantalla usando ren_aux y col_aux
    mov cl,2Dh              ;Pasa valor ASCII signo 
    imprime_caracter_color cl,cBlanco   ;Imprime caracter en CL, color blanco
    
    ;2Complemento a dos 
    pop bx ;obtenemos el valor guardado de la pila
    neg bx
    ;Ajustamos la posicion para el resultado para cualquier operacion en el momento de la impresion
    mov [col_aux],54d       ;variable col_aux para hacer operaciones en pantalla 
    mov [ren_aux],6     ;variable ren_aux para hacer operaciones en pantalla 

    call IMPRIME_BX
    jmp mouse_no_clic

positivo:
    call IMPRIME_BX
    jmp mouse_no_clic

multipli:

    mov ax, num1h
    mul num2h

    div diezmil

    mov bx, ax
    mov aux, dx
    
    ;Ajustamos la posicion para el resultado para cualquier operacion en el momento de la impresion
    mov [col_aux],50d       ;variable col_aux para hacer operaciones en pantalla 
    mov [ren_aux],6     ;variable ren_aux para hacer operaciones en pantalla 

    call IMPRIME_BX

    ;Ajustamos la posicion para el resultado para cualquier operacion en el momento de la impresion
    mov [col_aux],54d       ;variable col_aux para hacer operaciones en pantalla 
    mov [ren_aux],6     ;variable ren_aux para hacer operaciones en pantalla 

    mov bx, aux     
    call IMPRIME_BX

    jmp mouse_no_clic

division:
    
    ;Comparamos si es cero
    cmp num2h,0000d
    je cero
    
Nocero: 
    ;; Limpiamos dx para dejar preparado al cociente
    xor dx,dx
    mov ax,num1h        ;Que es dividiendo 00000:EA40h

    mov bx, num2h       ;Es el divisor

    div num2h

    mov bx, ax
    mov aux, dx   ;Guardamos nuestro residuo

    call IMPRIME_BX

    ;COCIENTE
    ;mov bx, aux
    ;call IMPRIME_BX
    ;jmp salicero
    jmp mouse_no_clic

cero:
    
    ;Vamo imprimir NaN
    mov [col_aux],57d       ;variable col_aux para hacer operaciones en pantalla 
    mov [ren_aux],6     ;variable ren_aux para hacer operaciones en pantalla 
    posiciona_cursor [ren_aux],[col_aux]    ;Posiciona el cursor en pantalla usando ren_aux y col_aux
    mov cl,4Eh              ;Pasa valor ASCII signo del operando en ANSII
    imprime_caracter_color cl,cRojoClaro    ;Imprime caracter en CL, color blanco

    mov [col_aux],56d       ;variable col_aux para hacer operaciones en pantalla 
    mov [ren_aux],6     ;variable ren_aux para hacer operaciones en pantalla 
    posiciona_cursor [ren_aux],[col_aux]    ;Posiciona el cursor en pantalla usando ren_aux y col_aux
    mov cl,61h              ;Pasa valor ASCII signo del operando en ANSII
    imprime_caracter_color cl,cRojoClaro    ;Imprime caracter en CL, color blanco
    
    mov [col_aux],55d       ;variable col_aux para hacer operaciones en pantalla 
    mov [ren_aux],6     ;variable ren_aux para hacer operaciones en pantalla 
    posiciona_cursor [ren_aux],[col_aux]    ;Posiciona el cursor en pantalla usando ren_aux y col_aux
    mov cl,4Eh              ;Pasa valor ASCII signo del operando en ANSII
    imprime_caracter_color cl,cRojoClaro    ;Imprime caracter en CL, color blanco
    
    jmp mouse_no_clic

modulo:
    
    ;Comparamos si es cero
    cmp num2h,0000d
    je cero
    
    ;; Limpiamos dx para dejar preparado al cociente
    xor dx,dx
    mov ax,num1h        ;Que es dividiendo 00000:EA40h

    mov bx, num2h       ;Es el divisor

    div num2h

    mov bx, ax
    mov aux, dx   ;Guardamos nuestro residuo

    ;call IMPRIME_BX

    ;COCIENTE
    mov bx, aux
    call IMPRIME_BX


    jmp mouse_no_clic

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Salto auxiliar para hacer un salto m?s largo
jmp_lee_num1:
    jmp lee_num1

;Logica para revisar si el mouse fue presionado en C
;boton C se encuentra entre renglones 18 y 20,
;y entre columnas 24 y 28
botonC_1:
    ;Agregar la logica para verificar el boton 
    ;y limpiar la pantalla de la calculadora
    call LIMPIA_PANTALLA_CALC
    jmp mouse_no_clic

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

lee_num1:
    cmp [operador],0    ;compara el valor del operador que puede ser 0, '+', '-', '*', '/', '%'
    jne lee_num2        ;Si el comparador es diferente de 0, entonces lee el segundo numero
    cmp [conta1],4      ;compara si el contador para num1 llego al maximo
    jae no_lee_num      ;si conta1 es mayor o igual a 4, entonces se ha alcanzado el numero de digitos
                        ;y no hace nada
    
    ;En pocas palabras en arreglo num1 se va recorriendo para colocar el numero ingresado
    ;num1 = [ , , , , ] ;e.g. [num1+di] = num1[di]
    mov al,num_boton    ;valor del boton presionado en AL
    mov di,[conta1]     ;copia el valor de conta1 en registro indice DI
    mov [num1+di],al    ;num1 es un arreglo de tipo byte
                        ;se utiliza di para acceder el elemento di-esimo del arreglo num1
                        ;se guarda el valor del boton presionado en el arreglo
    inc [conta1]        ;incrementa conta1 por numero correctamente leido
    ;;;;;;;;;;;;;;;;;;;;

    ;Se imprime el numero del arreglo num1 de acuerdo a conta1
    xor di,di           ;limpia DI para utilizarlo
    mov cx,[conta1]     ;prepara CX para loop de acuerdo al numero de digitos introducidos
    mov [ren_aux],3     ;variable ren_aux para hacer operaciones en pantalla 
                        ;ren_aux se mantiene fijo a lo largo del siguiente loop
imprime_num1:
    push cx                 ;guarda el valor de CX en la pila
    mov [col_aux],58d       ;variable col_aux para hacer operaciones en pantalla 
                            ;para recorrer la pantalla al imprimir el numero
    sub [col_aux],cl        ;Para calcular la columna en donde comienza a imprimir en pantalla de acuerdo a CX
    posiciona_cursor [ren_aux],[col_aux]    ;Posiciona el cursor en pantalla usando ren_aux y col_aux
    mov cl,[num1+di]        ;copia el digito en CL
    add cl,30h              ;Pasa valor ASCII
    imprime_caracter_color cl,cBlanco   ;Imprime caracter en CL, color blanco
    inc di                  ;incrementa DI para recorrer el arreglo num1
    pop cx                  ;recupera el valor de CX al inicio del loop
    loop imprime_num1       

    jmp mouse_no_clic

lee_num2:

    cmp [conta2],4      ;compara si el contador para num2 llego al maximo
    jae no_lee_num      ;si conta2 es mayor o igual a 4, entonces se ha alcanzado el numero de digitos
                        ;y no hace nada

    ;En pocas palabras en arreglo num1 se va recorriendo para colocar el numero ingresado
    ;num1 = [ , , , , ] ;e.g. [num1+di] = num1[di]
    mov al,num_boton    ;valor del boton presionado en AL
    mov di,[conta2]     ;copia el valor de conta1 en registro indice DI
    mov [num2+di],al    ;num1 es un arreglo de tipo byte
                        ;se utiliza di para acceder el elemento di-esimo del arreglo num1
                        ;se guarda el valor del boton presionado en el arreglo
    inc [conta2]        ;incrementa conta1 por numero correctamente leido
    ;;;;;;;;;;;;;;;;;;;;

    ;Se imprime el numero del arreglo num1 de acuerdo a conta2
    xor di,di           ;limpia DI para utilizarlo
    mov cx,[conta2]     ;prepara CX para loop de acuerdo al numero de digitos introducidos
    mov [ren_aux],5     ;variable ren_aux para hacer operaciones en pantalla 
                        ;ren_aux se mantiene fijo a lo largo del siguiente loop
imprime_num2:
    push cx                 ;guarda el valor de CX en la pila
    mov [col_aux],58d       ;variable col_aux para hacer operaciones en pantalla 
                            ;para recorrer la pantalla al imprimir el numero
    sub [col_aux],cl        ;Para calcular la columna en donde comienza a imprimir en pantalla de acuerdo a CX
    posiciona_cursor [ren_aux],[col_aux]    ;Posiciona el cursor en pantalla usando ren_aux y col_aux
    mov cl,[num2+di]        ;copia el digito en CL
    add cl,30h              ;Pasa valor ASCII
    imprime_caracter_color cl,cBlanco   ;Imprime caracter en CL, color blanco
    inc di                  ;incrementa DI para recorrer el arreglo num1
    pop cx                  ;recupera el valor de CX al inicio del loop
    loop imprime_num2       

    jmp mouse_no_clic




no_lee_num:
    jmp mouse_no_clic


;Si no se encontr? el driver del mouse, muestra un mensaje y debe salir tecleando [enter]
teclado:
    mov ah,08h
    int 21h
    cmp al,0Dh      ;compara la entrada de teclado si fue [enter]
    jnz teclado     ;Sale del ciclo hasta que presiona la tecla [enter]

salir:
    clear
    mov ax,4C00h
    int 21h



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;procedimiento MARCO_UI
    ;no requiere parametros de entrada
    ;Dibuja el marco de la interfaz de usuario del programa 
    MARCO_UI proc
        xor di,di
        mov cx,80d
        mov [col_aux],0
    marcos_horizontales:
        push cx
        ;Imprime marco superior
        posiciona_cursor 0,[col_aux]
        cmp [marco_sup+di],'X'
        je cerrar
    superior:
        imprime_caracter_color [marco_sup+di],cBlanco
        jmp inferior
    cerrar:
        imprime_caracter_color [marco_sup+di],cRojoClaro
    inferior:
        ;Imprime marco inferior
        posiciona_cursor 24,[col_aux]
        imprime_caracter_color [marco_inf+di],cBlanco
        inc [col_aux]
        inc di
        pop cx
        loop marcos_horizontales
        
        ;Imprime marcos laterales
        xor di,di
        mov cx,23       ;cx = 23d = 17h. Prepara registro CX para loop. 
                        ;para imprimir los marcos laterales en pantalla, entre el segundo y el pen?ltimo renglones
        mov [ren_aux],0
    marcos_verticales:
        push cx
        inc [ren_aux]
        posiciona_cursor [ren_aux],0
        imprime_caracter_color [marco_lat],cBlanco
        posiciona_cursor [ren_aux],79
        imprime_caracter_color [marco_lat],cBlanco
        pop cx
        loop marcos_verticales
        ret             ;Regreso de llamada a procedimiento
    endp                ;Indica fin de procedimiento UI para el ensamblador

    ;procedimiento CALCULADORA_UI
    ;no requiere parametros de entrada
    ;Dibuja el marco de la calculador en la interfaz de usuario del programa 
    CALCULADORA_UI proc
        xor di,di
        mov cx,40d
        mov [col_aux],20
    marcos_hor_cal:
        push cx
        ;Imprime marco superior
        posiciona_cursor 2,[col_aux]
        imprime_caracter_color [marco_sup_cal+di],cCyanClaro
        ;Imprime marco inferior
        posiciona_cursor 22,[col_aux]
        imprime_caracter_color [marco_inf_cal+di],cCyanClaro
        inc [col_aux]
        inc di
        pop cx
        loop marcos_hor_cal
        
        ;Imprime marcos laterales
        xor di,di
        mov cx,19d      ;cx = 23d = 17h. Prepara registro CX para loop. 
                        ;para imprimir los marcos laterales en pantalla, entre el segundo y el pen?ltimo renglones
        mov [ren_aux],2
    marcos_ver_cal:
        push cx
        inc [ren_aux]
        posiciona_cursor [ren_aux],20
        imprime_caracter_color [marco_lat_cal],cCyanClaro
        posiciona_cursor [ren_aux],59
        imprime_caracter_color [marco_lat_cal],cCyanClaro
        pop cx
        loop marcos_ver_cal

        ;Imprime marco horizontal interno
        mov cx,38d
        mov [col_aux],21
    marco_hor_interno_cal:
        push cx
        posiciona_cursor 7,[col_aux]
        imprime_caracter_color [marco_hint_cal],cCyanClaro
        inc [col_aux]
        pop cx
        loop marco_hor_interno_cal

        ;Imprime marco vertical interno
        mov cx,14d
        mov [ren_aux],8
    marco_ver_interno_cal:
        push cx
        posiciona_cursor [ren_aux],44
        imprime_caracter_color [marco_vint_cal],cCyanClaro
        inc [ren_aux]
        pop cx
        loop marco_ver_interno_cal

        ;Imprime intersecciones
    marco_intersecciones:
        ;interseccion izquierda
        posiciona_cursor 7,20
        imprime_caracter_color [marco_cizq_cal],cCyanClaro
        ;interseccion derecha
        posiciona_cursor 7,59
        imprime_caracter_color [marco_cder_cal],cCyanClaro
        ;interseccion superior
        posiciona_cursor 7,44
        imprime_caracter_color [marco_csup_cal],cCyanClaro
        ;interseccion inferior
        posiciona_cursor 22,44
        imprime_caracter_color [marco_cinf_cal],cCyanClaro

    ;Imprimir botones
        ;Imprime Boton 0
        mov [columna_boton],30
        mov [renglon_boton],18
        mov [color_boton],cGrisClaro
        mov [caracter_boton],'0'
        call IMPRIME_BOTON

        ;Imprime Boton 1
        mov [columna_boton],24
        mov [renglon_boton],15
        mov [color_boton],cGrisClaro
        mov [caracter_boton],'1'
        call IMPRIME_BOTON

        ;Imprime Boton 2
        mov [columna_boton],30
        mov [renglon_boton],15
        mov [color_boton],cGrisClaro
        mov [caracter_boton],'2'
        call IMPRIME_BOTON

        ;Imprime Boton 3
        mov [columna_boton],36
        mov [renglon_boton],15
        mov [color_boton],cGrisClaro
        mov [caracter_boton],'3'
        call IMPRIME_BOTON

        ;Imprime Boton 4
        mov [columna_boton],24
        mov [renglon_boton],12
        mov [color_boton],cGrisClaro
        mov [caracter_boton],'4'
        call IMPRIME_BOTON

        ;Imprime Boton 5
        mov [columna_boton],30
        mov [renglon_boton],12
        mov [color_boton],cGrisClaro
        mov [caracter_boton],'5'
        call IMPRIME_BOTON

        ;Imprime Boton 6
        mov [columna_boton],36
        mov [renglon_boton],12
        mov [color_boton],cGrisClaro
        mov [caracter_boton],'6'
        call IMPRIME_BOTON

        ;Imprime Boton 7
        mov [columna_boton],24
        mov [renglon_boton],9
        mov [color_boton],cGrisClaro
        mov [caracter_boton],'7'
        call IMPRIME_BOTON

        ;Imprime Boton 8
        mov [columna_boton],30
        mov [renglon_boton],9
        mov [color_boton],cGrisClaro
        mov [caracter_boton],'8'
        call IMPRIME_BOTON

        ;Imprime Boton 9
        mov [columna_boton],36
        mov [renglon_boton],9
        mov [color_boton],cGrisClaro
        mov [caracter_boton],'9'
        call IMPRIME_BOTON

        ;Imprime Boton <<
        mov [columna_boton],36
        mov [renglon_boton],18
        mov [color_boton],cVerde
        mov [caracter_boton],174
        call IMPRIME_BOTON

        ;Imprime Boton C
        mov [columna_boton],24
        mov [renglon_boton],18
        mov [color_boton],cVerdeClaro
        mov [caracter_boton],'C'
        call IMPRIME_BOTON

        ;Imprime Boton +
        mov [columna_boton],46
        mov [renglon_boton],9
        mov [color_boton],cAmarillo
        mov [caracter_boton],'+'
        call IMPRIME_BOTON

        ;Imprime Boton -
        mov [columna_boton],53
        mov [renglon_boton],9
        mov [color_boton],cAmarillo
        mov [caracter_boton],'-'
        call IMPRIME_BOTON

        ;Imprime Boton *
        mov [columna_boton],46
        mov [renglon_boton],13
        mov [color_boton],cAmarillo
        mov [caracter_boton],'*'
        call IMPRIME_BOTON

        ;Imprime Boton /
        mov [columna_boton],53
        mov [renglon_boton],13
        mov [color_boton],cAmarillo
        mov [caracter_boton],'/'
        call IMPRIME_BOTON

        ;Imprime Boton %
        mov [columna_boton],46
        mov [renglon_boton],17
        mov [color_boton],cAmarillo
        mov [caracter_boton],'%'
        call IMPRIME_BOTON

        ;Imprime Boton =
        mov [columna_boton],53
        mov [renglon_boton],17
        mov [color_boton],cRojoClaro
        mov [caracter_boton],'='
        call IMPRIME_BOTON

        ;Imprime un '0' inicial en la calculadora
        posiciona_cursor 3,57d
        imprime_caracter_color '0',cBlanco
        ret             ;Regreso de llamada a procedimiento
    endp                ;Indica fin de procedimiento UI para el ensamblador

    ;procedimiento IMPRIME_BOTON
    ;Dibuja un boton que abarca 3 renglones y 5 columnas
    ;con un caracter centrado dentro del boton
    ;en la posicion que se especifique (esquina superior izquierda)
    ;y de un color especificado
    ;Utiliza paso de parametros por variables globales
    ;Las variables utilizadas son:
    ;caracter_boton: debe contener el caracter que va a mostrar el boton
    ;renglon_boton: contiene la posicion del renglon en donde inicia el boton
    ;columna_boton: contiene la posicion de la columna en donde inicia el boton
    ;color_boton: contiene el color del boton
    IMPRIME_BOTON proc
        xor di,di
        mov cx,5d
        mov al,[columna_boton]
        mov [col_aux],al
    marcos_hor_boton:
        push cx
        ;Imprime marco superior
        posiciona_cursor [renglon_boton],[col_aux]
        imprime_caracter_color [marco_sup_bot+di],[color_boton]
        ;Imprime marco inferior
        add [renglon_boton],2
        posiciona_cursor [renglon_boton],[col_aux]
        sub [renglon_boton],2
        imprime_caracter_color [marco_inf_bot+di],[color_boton]
        inc [col_aux]
        inc di
        pop cx
        loop marcos_hor_boton
        
        ;Imprime marcos laterales
        xor di,di
        mov cx,14       ;cx = 23d = 17h. Prepara registro CX para loop. 
                        ;para imprimir los marcos laterales en pantalla, entre el segundo y el pen?ltimo renglones  
        mov al,[renglon_boton]
        mov [ren_aux],al
    marcos_ver_boton:
        inc [ren_aux]
        posiciona_cursor [ren_aux],[columna_boton]
        imprime_caracter_color [marco_lat_bot],[color_boton]
        add [columna_boton],4
        posiciona_cursor [ren_aux],[columna_boton]
        sub [columna_boton],4
        imprime_caracter_color [marco_lat_bot],[color_boton]
    car_boton:
        add [renglon_boton],1
        add [columna_boton],2
        posiciona_cursor [renglon_boton],[columna_boton]
        imprime_caracter_color [caracter_boton],[color_boton]
        sub [renglon_boton],1
        sub [columna_boton],2
        ret             ;Regreso de llamada a procedimiento
    endp                ;Indica fin de procedimiento UI para el ensamblador

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;FIN_DE_LA_INTERFAZ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;procedimiento IMPRIME_BX
    ;Imprime un numero entero decimal guardado en BX
    ;Se pasa un numero a traves del registro BX que se va a imprimir con 4 o 5 digitos
    ;Si BX es menor a 10000, imprime 4 digitos, si no imprime 5 digitos
    ;Antes de llamar el procedimiento, se requiere definir la posicion en pantalla
    ;a partir de la cual comienza la impresion del numero con ayuda de las variables [ren_aux] y [col_aux]
    ;[ren_aux] para el renglon (entre 0 y 24)
    ;[col_aux] para la columna (entre 0 y 79)
    IMPRIME_BX  proc 
    ;Antes de comenzar, se guarda un respaldo de los registros
    ; CX, DX, AX en la pila
    ;Al terminar el procedimiento, se recuperan estos valores
        push cx
        push dx
        push ax
    ;Calcula digito de decenas de millar
        mov cx,bx
        cmp bx,10000d
        jb imprime_4_digs
        mov ax,bx               ;pasa el valor de BX a AX para division de 16 bits
        xor dx,dx               ;limpia registro DX, para extender AX a 32 bits
        div [diezmil]           ;Division de 16 bits => AX=cociente, DX=residuo
                                ;El cociente contendr? el valor del d?gito que puede ser entre 0 y 9. 
                                ;Por lo tanto, AX=000Xh => AH=00h y AL=0Xh, donde X es un d?gito entre 0 y 9
                                ;Asumimos que el digito ya esta en AL
                                ;El residuo se utilizara para los siguientes digitos
        mov cx,dx               ;Guardamos el residuo anterior en un registro disponible para almacenarlo temporalmente
                                ;debido a que modificaremos DX antes de usar ese residuo
        ;Imprime el digito decenas de millar 
        add al,30h              ;Pasa el digito en AL a su valor ASCII
        mov [num_impr],al       ;Pasa el digito a una variable de memoria ya que AL se modifica en las siguientes macros
        push cx
        posiciona_cursor [ren_aux],[col_aux]
        imprime_caracter_color [num_impr],cBlanco       
        pop cx
        inc [col_aux]           ;Recorre a la siguiente columna para imprimir el siguiente digito

    imprime_4_digs:
    ;Calcula digito de unidades de millar
        mov ax,cx               ;Recuperamos el residuo de la division anterior y preparamos AX para hacer division
        xor dx,dx               ;limpia registro DX, para extender AX a 32 bits
        div [mil]               ;Division de 16 bits => AX=cociente, DX=residuo
                                ;El cociente contendr? el valor del d?gito que puede ser entre 0 y 9. 
                                ;Por lo tanto, AX=000Xh => AH=00h y AL=0Xh, donde X es un d?gito entre 0 y 9
                                ;Asumimos que el digito ya esta en AL
                                ;El residuo se utilizara para los siguientes digitos
        mov cx,dx               ;Guardamos el residuo anterior en un registro disponible para almacenarlo temporalmente
                                ;debido a que modificaremos DX antes de usar ese residuo
        ;Imprime el digito unidades de millar
        add al,30h              ;Pasa el digito en AL a su valor ASCII
        mov [num_impr],al       ;Pasa el digito a una variable de memoria ya que AL se modifica en las siguientes macros
        push cx
        posiciona_cursor [ren_aux],[col_aux]
        imprime_caracter_color [num_impr],cBlanco       
        pop cx
        inc [col_aux]           ;Recorre a la siguiente columna para imprimir el siguiente digito

    ;Calcula digito de centenas
        mov ax,cx               ;Recuperamos el residuo de la division anterior y preparamos AX para hacer division
        xor dx,dx               ;limpia registro DX, para extender AX a 32 bits
        div [cien]              ;Division de 16 bits => AX=cociente, DX=residuo
                                ;El cociente contendr? el valor del d?gito que puede ser entre 0 y 9. 
                                ;Por lo tanto, AX=000Xh => AH=00h y AL=0Xh, donde X es un d?gito entre 0 y 9
                                ;Asumimos que el digito ya esta en AL
                                ;El residuo se utilizara para los siguientes digitos
        mov cx,dx               ;Guardamos el residuo anterior en un registro disponible para almacenarlo temporalmente
                                ;debido a que modificaremos DX antes de usar ese residuo
        ;Imprime el digito unidades de millar
        add al,30h              ;Pasa el digito en AL a su valor ASCII
        mov [num_impr],al       ;Pasa el digito a una variable de memoria ya que AL se modifica en las siguientes macros
        push cx
        posiciona_cursor [ren_aux],[col_aux]
        imprime_caracter_color [num_impr],cBlanco       
        pop cx
        inc [col_aux]           ;Recorre a la siguiente columna para imprimir el siguiente digito

    ;Calcula digito de decenas
        mov ax,cx               ;Recuperamos el residuo de la division anterior y preparamos AX para hacer division
        xor dx,dx               ;limpia registro DX, para extender AX a 32 bits
        div [diez]              ;Division de 16 bits => AX=cociente, DX=residuo
                                ;El cociente contendr? el valor del d?gito que puede ser entre 0 y 9. 
                                ;Por lo tanto, AX=000Xh => AH=00h y AL=0Xh, donde X es un d?gito entre 0 y 9
                                ;Asumimos que el digito ya esta en AL
                                ;El residuo se utilizara para los siguientes digitos
        mov cx,dx               ;Guardamos el residuo anterior en un registro disponible para almacenarlo temporalmente
                                ;debido a que modificaremos DX antes de usar ese residuo
        ;Imprime el digito unidades de millar
        add al,30h              ;Pasa el digito en AL a su valor ASCII
        mov [num_impr],al       ;Pasa el digito a una variable de memoria ya que AL se modifica en las siguientes macros
        push cx
        posiciona_cursor [ren_aux],[col_aux]
        imprime_caracter_color [num_impr],cBlanco       
        pop cx
        inc [col_aux]

    ;Calcula digito de unidades
        mov ax,cx               ;Recuperamos el residuo de la division anterior
                                ;Para este caso, el residuo debe ser un n?mero entre 0 y 9
                                ;al hacer AX = CX, el residuo debe estar entre 0000h y 0009h
                                ;=> AX = 000Xh -> AH=00h y AL=0Xh
        ;Imprime el digito unidades de millar
        add al,30h              ;Pasa el digito en AL a su valor ASCII
        mov [num_impr],al       ;Pasa el digito a una variable de memoria ya que AL se modifica en las siguientes macros
        posiciona_cursor [ren_aux],[col_aux]
        imprime_caracter_color [num_impr],cBlanco

    ;Se recuperan los valores de los registros CX, AX, y DX almacenados en la pila
        pop ax
        pop dx
        pop cx
        ret                     ;intruccion ret para regresar de llamada a procedimiento
    endp

    ;procedimiento LIMPIA_PANTALLA_CALC
    ;no requiere parametros de entrada
    ;"Borra" el contenido de lo que se encuentra en la pantalla de la calculadora
    LIMPIA_PANTALLA_CALC proc
        mov cx,4d
    limpia_num1_y_num2:
        push cx
        mov [col_aux],58d
        sub [col_aux],cl
        posiciona_cursor 3,[col_aux]
        imprime_caracter_color ' ',cNegro
        posiciona_cursor 5,[col_aux]
        imprime_caracter_color ' ',cNegro
        pop cx
        loop limpia_num1_y_num2

    limpia_operador:
        posiciona_cursor 4,57d
        imprime_caracter_color ' ',cNegro

        mov cx,10d
    limpia_resultado:
        push cx
        mov [col_aux],58d
        sub [col_aux],cl
        posiciona_cursor 6,[col_aux]
        imprime_caracter_color ' ',cNegro
        pop cx
        loop limpia_resultado

        posiciona_cursor 3,57d
        imprime_caracter_color '0',cBlanco

        ;Reinicia valores de variables utilizadas
        mov [conta1],0
        mov [conta2],0
        mov [operador],0
        mov [num_boton],0
        mov [num1h],0
        mov [num2h],0

        ret             ;Regreso de llamada a procedimiento
    endp                ;Indica fin de procedimiento UI para el ensamblador

end inicio
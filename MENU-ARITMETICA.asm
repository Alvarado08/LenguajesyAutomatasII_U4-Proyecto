include 'emu8086.inc'

;---------------------------

org 100h ; indicamos en que area de memoria se va a iniciar el programa regularmente se inicia en 100h
.model medium
.stack 100
.data
                 
    Textooperacion db "*** MENU ***",13,10
                   db "1.SUMA",13,10
                   db "2.RESTA",13,10 
                   db "3.MULTIPLICACION",13,10
                   db "4.DIVISION",13,10
                   db " - ESC para salir - ",13,10
                   db "Ingrese una de las opciones --> $",13,10
    
    textosuma db 13,10,13,10,"*** Suma ***",13,10
              db " - ESC para regresar$",13,10

              
    textomulti db 13,10,13,10,"*** Multiplicacion ***",13,10
               db " - ESC para regresar $",13,10,13,10  
               
    textoresta db 13,10,13,10,"*** Resta ***",13,10
               db " - ESC para regresar $",13,10,13,10 
               
    textodivi db 13,10,13,10,"*** Division ***",13,10
               db " - ESC para regresar $",13,10,13,10
    
    ;variables de datos
    datosuma db 100 dup(?)
    datoresta db 100 dup(?)
    datomulti db 100 dup(?)
    datodivi db 100 dup(?)
    dato db 100 dup(?)
                 
.code     
;Menu: ;------------------------------------------------------------------------------------
 ;esta es una etiqueta se llama menu que sera donde mostraremos las opciones al usuario
     mov ah,0
     mov al,3h ;modo texto
     int 10h ; interrupcion de video

     mov ax,0600h ;limpiar pantalla
     mov bh,0fh ;0 color de fondo negro, f color de letra blanco
     mov cx,0000h
     mov dx,184Fh
     int 10h
     mov ah,02h
     mov bh,00
     mov dh,00
     mov dl,00
     int 10h
     
;***************************************************************************

op1:;----------------------------------------------------------------------
    
    mov ah,09
    lea dx,Textooperacion;impresion de cadena y se detiene cuando detecta el --> $
    int 21h
    
    ;mov ah,01h
    ;int 21h
    
    mov ah,08;pausa y captura de datos
    int 21h
    
    cmp al,49 ; ascii 49 = numero 1 compara lo que tiene el registro ah con el ascii 49 en el reg al
    je suma ; salto condicional jump equals opcion 1 saltar si es igual a la opcion 1
     
    cmp al,50
    je resta 
    
    cmp al,51
    je multi 
    
    cmp al,52
    je divi
    
    cmp al,27; ascii de ESC
    je Salir
    
 ;************************************************************************      

op2:

suma:
    
    mov ah,09
    lea dx,textosuma;impresion de cadena y se detiene cuando detecta el --> $
    int 21h
    
    ;------------------------
Sumas proc ;EL USO CONTRARIO AL MACRO --> PROCEDIMIENTO
    printn " "
    print "Numero 1: "
    call scan_num
    mov datosuma[0],cl;en la posicion 0 de la variable se almacena el primer valor
    printn " "
    print "Numero 2: "
    call scan_num
    mov datosuma[1],cl;en la posicion 1 de la variable se almacena el primer valor
    printn " "
    xor ax,ax ;suma logica exclusiva
    add al,datosuma[0]
    add al,datosuma[1]
    printn " "
    print "La suma es: "
    call print_num  
Sumas endp 

;datos llamados
define_print_string
define_print_num
define_print_num_uns
define_scan_num
      
    mov ah,08;pausa y captura de datos
    int 21h

    ;------------------------
    
    cmp al,27; ascii de ESC
    je op1
     
multi:;----------------------------------------------------

    
    mov ah,09
    lea dx,textomulti;impresion de cadena y se detiene cuando detecta el --> $
    int 21h 
    
Multis proc ;EL USO CONTRARIO AL MACRO --> PROCEDIMIENTO
    printn " "
    print "Numero 1: "
    call scan_num
    mov datomulti[0],cl;en la posicion 0 de la variable se almacena el primer valor
    printn " "
    print "Numero 2: "
    call scan_num
    mov datomulti[1],cl;en la posicion 1 de la variable se almacena el primer valor
    printn " "
    xor ax,ax ;suma logica exclusiva
    add al,datomulti[0]
    mul datomulti[1]
    printn " "
    print "La multiplicacion es: "
    call print_num  
Multis endp
 
    mov ah,08;pausa y captura de datos
    int 21h

    ;------------------------
    
    cmp al,27; ascii de ESC
    je op1
    
resta:
  mov ah,09
  lea dx,textoresta;impresion de cadena y se detiene cuando detecta el --> $
  int 21h
  
Restas proc ;EL USO CONTRARIO AL MACRO --> PROCEDIMIENTO
    printn " "
    print "Numero 1: "
    call scan_num
    mov datoresta[0],cl;en la posicion 0 de la variable se almacena el primer valor
    printn " "
    print "Numero 2: "
    call scan_num
    mov datoresta[1],cl;en la posicion 1 de la variable se almacena el primer valor
    printn " "
    xor ax,ax ;suma logica exclusiva
    add al,datoresta[0]
    sub al,datoresta[1]
    printn " "
    print "La resta es: "
    call print_num  
Restas endp
 
    mov ah,08;pausa y captura de datos
    int 21h

    ;------------------------
    
    cmp al,27; ascii de ESC
    je op1
    
divi:
  mov ah,09
  lea dx,textodivi;impresion de cadena y se detiene cuando detecta el --> $
  int 21h
  
Divis proc ;EL USO CONTRARIO AL MACRO --> PROCEDIMIENTO
    printn " "
    print "Numero 1: "
    call scan_num
    mov datodivi[0],cl;en la posicion 0 de la variable se almacena el primer valor
    printn " "
    print "Numero 2: "
    call scan_num
    mov datodivi[1],cl;en la posicion 1 de la variable se almacena el primer valor
    printn " "
    xor ax,ax ;suma logica exclusiva
    add al,datodivi[0]
    div datodivi[1]
    printn " "
    print "La division es: "
    call print_num  
Divis endp
   
    mov ah,08;pausa y captura de datos
    int 21h

    ;------------------------
    
    cmp al,27; ascii de ESC
    je op1      
   
Salir:;---------------------------------------------------------
    mov ah,04ch
    int 21h
    end

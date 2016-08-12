;------------------------------------------------------------------------------------------------$
; prueba realizar una linea 12:06
;------------------------------------------------------------
%macro limpiar_pantalla 2 	;recibe 2 parametros
	mov rax,1	;sys_write
	mov rdi,1	;std_out
	mov rsi,%1	;primer parametro: caracteres especiales para limpiar la pantalla
	mov rdx,%2	;segundo parametro: Tamano 
	syscall
%endmacro;---------------------------------------------------------------

%macro imprimir 2 	;recibe 2 parametros
	mov rax,1	;sys_write
	mov rdi,1	;std_out
	mov rsi,%1	;primer parametro: caracteres especiales para limpiar la pantalla
	mov rdx,%2	;segundo parametro: Tamano 
	syscall
%endmacro;---------------------------------------------------------------

%macro leer 2 	;recibe 2 parametros
	mov rax,0	;sys_read
	mov rdi,0	;std_in
	mov rsi,%1	;primer parametro: donde guardar el dato
	mov rdx,%2	;segundo parametro: Tamano 
	syscall
%endmacro;---------------------------------------------------------------




section .data ; 

	limpiar    db 0x1b, "[2J", 0x1b, "[H"; caracteres para limpiar la pantalla
	limpiar_tam equ $ - limpiar

        cons_jugador: db 0x1b, "[1J", 0x1b, "[1;3f", 0x1b, "[1m", 0x1b, "[40;32m", ' Jugador:', 0x1b, "[40;30m",' ',  0x1b, "[40;37m"
        cons_jugador_size: equ $-cons_jugador

	cons_vidas: db 0x1b, "[1;60f",  0x1b, "[1m", 0x1b, "[40;32m",  'Vidas:', 0x1b, "[40;30m",' ', 0x1b, "[40;37m",0xa
	cons_vidas_size:equ $-cons_vidas

	cons_corazon1: db 0x1b, "[1;68f", '♥'
	cons_corazon2: db 0x1b, "[1;70f", '♥'
	cons_corazon3: db 0x1b, "[1;72f", '♥',0xa
	cons_corazon_size: equ $- cons_corazon1

        cons_carv: db  0x1b, "[1m", '  *                                                                                                            *' ,0xa ; caracter a dibujar para los bordes verticales
	cons_carv_size: equ $-cons_carv

        cons_carh: db 0x1b, "[1m", '* '; caracter horizontal
        cons_carh_size: equ $-cons_carh

	cons_superior: db 0x1b, "[2;1f", '  '; esquina superior izquierda
	cons_superior_size: equ $-cons_superior

	cons_inferior: db 0x1b, "[43;1f", '  '	;esquina inferior izquierda
	cons_inferior_size: equ $-cons_inferior

	cons_izquierda: db 0x1b, "[3;1f",''
	cons_izquierda_size: equ $-cons_izquierda

		;cada rectangulo es de un ancho de 10 guiones; espacios de 3
	b11: db  0x1b, "[5;15f",0x1b, "[42;32m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
	b_size: equ $-b11
	b12: db 0x1b, "[5;30f", 0x1b, "[45;35m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
	b13: db 0x1b, "[5;45f", 0x1b, "[46;36m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
      	b14: db 0x1b, "[5;60f", 0x1b, "[44;34m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
        b15: db 0x1b, "[5;75f", 0x1b, "[41;31m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
        b16: db 0x1b, "[5;90f", 0x1b, "[43;33m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m",0xa
;---------------------------------------------------------------------------------------------------------
	b21: db 0x1b, "[7;15f", 0x1b, "[41;31m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
        b22: db 0x1b, "[7;30f", 0x1b, "[42;32m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
        b23: db 0x1b, "[7;45f", 0x1b, "[43;33m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
        b24: db 0x1b, "[7;60f", 0x1b, "[46;36m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
        b25: db 0x1b, "[7;75f", 0x1b, "[45;35m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
        b26: db 0x1b, "[7;90f", 0x1b, "[44;34m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m",0xa
;---------------------------------------------------------------------------------------------------------
	b31: db 0x1b, "[9;15f", 0x1b, "[45;35m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
        b32: db 0x1b, "[9;30f", 0x1b, "[46;36m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
        b33: db 0x1b, "[9;45f", 0x1b, "[44;34m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
        b34: db 0x1b, "[9;60f", 0x1b, "[43;33m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
        b35: db 0x1b, "[9;75f", 0x1b, "[42;32m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
        b36: db 0x1b, "[9;90f", 0x1b, "[41;31m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m",0xa

;----------------------------------------------------------------------------------------------------------

	cons_iniciar: db 0x1b, "[20;40f",'  *                          Presione X para iniciar                                *',0xa 	
	cons_iniciar_size: equ $-cons_iniciar
    
	cons_perder_vida: db 0x1b, "[20;40f",'  *                    Intento fallido - Pierde una vida                 *' ,0xa	
	cons_perder_vida_size: equ $-cons_perder_vida

	cons_perder: db 0x1b, "[20;40f",'  *                                      GAME OVER!                                        *',0xa 	
	cons_perder_size: equ $-cons_perder

       cons_salir:db  0x1b, "[0J", '',0x1b, "[40;37m",0xa
        cons_salir_size: equ $-cons_salir
;------------------------------------------------------------------------------------------------------------

;##############################Codigo de la plataforma###########

		cons_curini: db 27,"[00;57H"											;retorna el cursor a la primera fila
		cons_sz_curini: equ 8

		cons_pospl:	db 27,"[40;04H"												;ubica el cursor en la fila donde se ubica la plataforma
		cons_sz_pospl:	equ 8

        cons_erasep: db '                                                      ' ;espacios para borrar la plataforma
        cons_sz_erasep: equ $-cons_erasep

        cons_salida: db 27,"[2J",27,"[00;00H"									
        cons_sz_salida: equ 12

        cons_espacio: db 27,"[1C" ;espacio a la izquierda de la plataforma 
        cons_sz_espacio: equ $-cons_espacio
        
        cons_plataforma: db 27,"[1;37m",'<=======>'
        cons_sz_plataforma: equ $-cons_plataforma      ; Longitud del banner
        
        mov_plataforma: db 30
        tecla:  db''   
        
        termios: times 36 db 0                   ;Estructura de 36bytes que contiene el modo de operacion de la consola
        stdin: equ 0                             ;Standard Input (se usa stdin en lugar de escribir manualmente los valores)
        ICANON: equ 1<<1                         ;ICANON: Valor de control para encender/apagar el modo canonico
        ECHO: equ 1<<3                           ;ECHO: Valor de control para encender/apagar el modo de eco
        VTIME: equ 4
        VMIN: equ 5
        CC_C: equ 18
;--------------------Declaracion de funciones y utilidades ---------------------------------------------

;####################################################
;canonical_off
;Esta es una funcion que sirve para apagar el modo canonico en Linux
;Cuando el modo canonico se apaga, Linux NO espera un ENTER para
;procesar lo que se captura desde el teclado, sino que se hace de forma
;directa e inmediata
;
;Para apagar el modo canonico, simplemente use: call canonical_off
;###################################################
canonical_off:

        ;Se llama a la funcion que lee el estado actual del TERMIOS en STDIN
        ;TERMIOS son los parametros de configuracion que usa Linux para STDIN
        call read_stdin_termios

        ;Se escribe el nuevo valor de ICANON en EAX, para apagar el modo canonico
        push rax
        mov eax, ICANON
        not eax
        and [termios+12], eax
        mov byte[termios+CC_C+VMIN], 0                  ;se establece el numero de caracteres minimo en cero
        mov byte [termios+CC_C+VTIME],1                 ; se establece el tiempo de espera en 3ds
        pop rax

        ;Se escribe la nueva configuracion de TERMIOS
        call write_stdin_termios
        ret
        ;Final de la funcion
;###################################################


;####################################################
;echo_off
;Esta es una funcion que sirve para apagar el modo echo en Linux
;Cuando el modo echo se apaga, Linux NO muestra en la pantalla la tecla que
;se acaba de presionar.
;
;Para apagar el modo echo, simplemente use: call echo_off
;###################################################
echo_off:

        ;Se llama a la funcion que lee el estado actual del TERMIOS en STDIN
        ;TERMIOS son los parametros de configuracion que usa Linux para STDIN
        call read_stdin_termios

        ;Se escribe el nuevo valor de ECHO en EAX para apagar el echo
        push rax
        mov eax, ECHO
        not eax
        and [termios+12], eax
        pop rax

        ;Se escribe la nueva configuracion de TERMIOS
        call write_stdin_termios
        ret
        ;Final de la funcion
;###################################################


;####################################################
;canonical_on
;Esta es una funcion que sirve para encender el modo canonico en Linux
;Cuando el modo canonico se enciende, Linux espera un ENTER para
;procesar lo que se captura desde el teclado
;
;Para encender el modo canonico, simplemente use: call canonical_on
;###################################################
canonical_on:

        ;Se llama a la funcion que lee el estado actual del TERMIOS en STDIN
        ;TERMIOS son los parametros de configuracion que usa Linux para STDIN
        call read_stdin_termios

        ;Se escribe el nuevo valor de modo Canonico
        or dword [termios+12], ICANON
        mov byte[termios+CC_C+VMIN], 1
        mov byte[termios+CC_C+VTIME], 0
        ;Se escribe la nueva configuracion de TERMIOS
        call write_stdin_termios
        ret
        ;Final de la funcion
;###################################################


;####################################################
;echo_on
;Esta es una funcion que sirve para encender el echo en Linux
;Cuando el echo se enciende, Linux muestra en la pantalla (stdout) cada tecla
;que se recibe del teclado (stdin)
;
;Para encender el modo echo, simplemente use: call echo_on
;###################################################
echo_on:

        ;Se llama a la funcion que lee el estado actual del TERMIOS en STDIN
        ;TERMIOS son los parametros de configuracion que usa Linux para STDIN
        call read_stdin_termios

        ;Se escribe el nuevo valor de modo echo
        or dword [termios+12], ECHO

        ;Se escribe la nueva configuracion de TERMIOS
        call write_stdin_termios
        ret
        ;Final de la funcion
;###################################################


;####################################################
;read_stdin_termios
;Esta es una funcion que sirve para leer la configuracion actual del stdin o 
;teclado directamente de Linux
;Esta configuracion se conoce como TERMIOS (Terminal Input/Output Settings)
;Los valores del stdin se cargan con EAX=36h y llamada a la interrupcion 80h
;
;Para utilizarlo, simplemente se usa: call read_stdin_termios
;###################################################
read_stdin_termios:
        push rax
        push rbx
        push rcx
        push rdx

        mov eax, 36h
        mov ebx, stdin
        mov ecx, 5401h
        mov edx, termios
        int 80h

        pop rdx
        pop rcx
        pop rbx
        pop rax
        ret
        ;Final de la funcion
;###################################################


;####################################################
;write_stdin_termios
;Esta es una funcion que sirve para escribir la configuracion actual del stdin o 
;teclado directamente de Linux
;Esta configuracion se conoce como TERMIOS (Terminal Input/Output Settings)
;Los valores del stdin se cargan con EAX=36h y llamada a la interrupcion 80h
;
;Para utilizarlo, simplemente se usa: call write_stdin_termios
;###################################################
write_stdin_termios:
        push rax
        push rbx
        push rcx
        push rdx

        mov eax, 36h
        mov ebx, stdin
        mov ecx, 5402h
        mov edx, termios
        int 80h

        pop rdx
        pop rcx
        pop rbx
        pop rax
        ret
        ;Final de la funcion
;###################################################






section .text
        global _start

_start:
	limpiar_pantalla limpiar,limpiar_tam; funcion macro para limpiar

	;imprime jugador en la primera linea
	imprimir cons_jugador  ,cons_jugador_size           
	
	;imprime vidas en la primera linea
	imprimir cons_vidas   ,cons_vidas_size  
	imprimir cons_corazon1   ,cons_corazon_size
	imprimir cons_corazon2   ,cons_corazon_size
	imprimir cons_corazon3   ,cons_corazon_size
	
; colocar posicion incial superior
	imprimir cons_superior   ,cons_superior_size

; imprimir linea superior de techo
	mov r9,55		; (55x2=110, eso xq uso el caracter y un espacio)

	call canonical_off
    call echo_off
    mov r10,50			; define la cantidad de espacios inicial de la plataforma

superior: cmp r9,0
	je sig
	imprimir cons_carh  ,cons_carh_size
	dec r9
	jmp superior	

; colocar posicion incial vertical 
sig:mov r9,42
	imprimir cons_izquierda ,cons_izquierda_size

; imprimir los caracteres verticales	
posver: 
	cmp r9,0
	je bloques
	imprimir  cons_carv , cons_carv_size
	dec r9
	jmp posver

;Imprime bloques++++++++++++++++++++++++++++++++++
bloques:	
	imprimir  b11 , b_size		; imprime b11
	imprimir  b12 , b_size		; imprime b12
	imprimir  b13 , b_size		; imprime b13
	imprimir  b14 , b_size		; imprime b14
	imprimir  b15 , b_size		; imprime b15
	imprimir  b16 , b_size		; imprime b16
;-------------------------------------
	imprimir  b21 , b_size		; imprime b21
	imprimir  b22 , b_size		; imprime b22
	imprimir  b23 , b_size		; imprime b23
	imprimir  b24 , b_size		; imprime b24
	imprimir  b25 , b_size		; imprime b25
	imprimir  b26 , b_size		; imprime b26
;-------------------------------------
	imprimir  b31 , b_size		; imprime b31
	imprimir  b32 , b_size		; imprime b32
	imprimir  b33 , b_size		; imprime b33
	imprimir  b34 , b_size		; imprime b34
	imprimir  b35 , b_size		; imprime b35
	imprimir  b36 , b_size		; imprime b36
;-++++++++++++++++++++++++++++++++++++++++++++++++++

; colocar cursor posicion incial inf 
;posinf:	
	imprimir  cons_inferior, cons_inferior_size	
	mov r9,55
inferior: 
	cmp r9,0
	je _refresh_plataforma
	imprimir  cons_carh, cons_carh_size
	dec r9
	jmp inferior ; - - -- - - - --  - -- - -- - -- -- - - - - - - -


_refresh_plataforma:
        ;Primer paso: Imprimir la plataforma
        imprimir  cons_pospl, cons_sz_pospl
        imprimir  cons_erasep, cons_sz_erasep
        imprimir  cons_erasep, cons_sz_erasep
        imprimir  cons_pospl, cons_sz_pospl
        push r9
        mov r9,1
_espacios:
        cmp r10,r9
        je _plataforma
        imprimir  cons_espacio, cons_sz_espacio
        inc r9                                                         ;se incrementa r9 en 1
        jmp _espacios                                           ;regresa a _espacios


_plataforma:
        pop r9
        imprimir  cons_plataforma, cons_sz_plataforma
        imprimir  cons_curini, cons_sz_curini 

_read_tecla:
        ;Segundo paso: Capturar una tecla presionada en el teclado
        leer tecla, 1
        ;Tercer paso: comparar la tecla con el movimiento a la izquierda/derecha
        push r8
        push r9
        mov r8,[tecla]                                                 ;rax = tecla capturada
        mov r9,'z'                                ;rbx = constante de movimiento a la izquierda
        cmp r8,r9                                                             ;comparacion
        je _izquierda                                                   ;salto a .izquierda
        mov r9,'c'                                 ;rbx = constante de movimiento a la derecha
        cmp r8,r9                                                            ;comparacion
        je _derecha                                                     ;salto a .derecha
        mov r9,'x'
        cmp r8,r9
        je salir
        mov [tecla],rax
        jne _refresh_plataforma

_izquierda:
        pop r8
        pop r9
        cmp r10,1
        je _read_tecla
        dec r10
        mov [tecla],rax
        jmp _refresh_plataforma

_derecha:
        pop r8
        pop r9
        cmp r10,100
        je _read_tecla
        inc r10
        mov [tecla],rax
        jmp _refresh_plataforma



salir:
	imprimir cons_salir, cons_salir_size
		call canonical_on
        call echo_on

        ;Ultimo paso: Salida del programa
        mov rax,60                    ;se carga la llamada 60d (sys_exi$
        mov rdi,0                     ;en rdi se carga un 0
        syscall                       ;se llama al sistema.

;fin del programa







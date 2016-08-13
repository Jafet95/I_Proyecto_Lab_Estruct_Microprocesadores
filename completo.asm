%macro limpiar_pantalla 2	 	;recibe 2 parametros
	mov rax,1					;sys_write
	mov rdi,1					;std_out
	mov rsi,%1					;primer parametro: caracteres especiales para limpiar la pantalla
	mov rdx,%2					;segundo parametro: Tamano 
	syscall
%endmacro;---------------------------------------------------------------

%macro imprimir 2 				;recibe 2 parametros
	mov rax,1					;sys_write
	mov rdi,1					;std_out
	mov rsi,%1					;primer parametro: caracteres especiales para limpiar la pantalla
	mov rdx,%2					;segundo parametro: Tamano 
	syscall
%endmacro;---------------------------------------------------------------

%macro leer 2 					;recibe 2 parametros
	mov rax,0					;sys_read
	mov rdi,0					;std_in
	mov rsi,%1					;primer parametro: donde guardar el dato
	mov rdx,%2					;segundo parametro: Tamano 
	syscall
%endmacro;---------------------------------------------------------------


section .data ; 

;########################  Datos de la Interfaz  ################################################

	limpiar    db 0x1b, "[2J", 0x1b, "[H", 0x1b ,'[?25l'; caracteres para limpiar la pantalla
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

		;cada rectangulo es de un ancho de 18 y el ultimo es de 17 guiones
	b11: db  0x1b, "[5;4f",0x1b, "[42;32m",    '__________________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
	b_size: equ $-b11
	b12: db 0x1b, "[5;22f", 0x1b, "[45;35m", '__________________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
	b13: db 0x1b, "[5;40f", 0x1b, "[46;36m", '__________________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
	b14: db 0x1b, "[5;58f", 0x1b, "[44;34m", '__________________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
	b15: db 0x1b, "[5;76f", 0x1b, "[41;31m", '__________________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
	b16: db 0x1b, "[5;93f", 0x1b, "[43;33m", '__________________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
	b1_size: equ $-b16

	b21: db 0x1b, "[6;4f", 0x1b, "[41;31m",  '__________________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
	b22: db 0x1b, "[6;22f", 0x1b, "[42;32m",  '__________________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
	b23: db 0x1b, "[6;40f", 0x1b, "[43;33m",  '__________________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
	b24: db 0x1b, "[6;58f", 0x1b, "[46;36m", '__________________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
	b25: db 0x1b, "[6;76f", 0x1b, "[45;35m",  '__________________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
	b26: db 0x1b, "[6;93f", 0x1b, "[44;34m",  '__________________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
	b2_size: equ $-b26

	b31: db 0x1b, "[7;4f", 0x1b, "[45;35m",  '__________________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
	b32: db 0x1b, "[7;22f", 0x1b, "[46;36m",  '__________________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
	b33: db 0x1b, "[7;40f", 0x1b, "[44;34m",     '__________________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
	b34: db 0x1b, "[7;58f", 0x1b, "[43;33m",     '__________________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
	b35: db 0x1b, "[7;76f", 0x1b, "[42;32m",  '__________________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
	b36: db 0x1b, "[7;93f", 0x1b, "[41;31m",     '__________________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
	b3_size: equ $-b36

	cons_iniciar: db 0x1b, "[20;40f",'  *                          Presione X para iniciar                                *',0xa 	
	cons_iniciar_size: equ $-cons_iniciar
	
	cons_perder_vida: db 0x1b, "[20;40f",'  *                    Intento fallido - Pierde una vida                 *' ,0xa	
	cons_perder_vida_size: equ $-cons_perder_vida

	cons_perder: db 0x1b, "[20;40f",'  *                                      GAME OVER!                                        *',0xa 	
	cons_perder_size: equ $-cons_perder

	cons_salir:db  0x1b, "[0J", '',0x1b, "[40;37m",0xa
	cons_salir_size: equ $-cons_salir

;############################   Datos de la bola  ##############################################

	set_cursor: db 27,'[00;00H' 
	set_cursor_tam: equ $-set_cursor

	bola: db 27, '[1m', '⁕'				;Caracter de la bola  ⁕ ✺ ●
	bola_tam: equ $-bola

	espacio: db ' '						;Para borrar la bola
	espacio_tam: equ $-espacio

	espacio_y: db 27, "[1E"				;Para moverse en y
	espacio_y_tam: equ $-espacio_y

	condicion: dq 0					;condicion para cambiar de imprimir a borrar y viceversa

;##############################   Datos de la plataforma  ######################################

	cons_pospl:	db 27,"[40;04H"					;ubica el cursor en la fila donde se ubica la plataforma
	cons_sz_pospl:	equ 8

	cons_erasep: db '                                                      ' ;espacios para borrar la plataforma
	cons_sz_erasep: equ $-cons_erasep

	cons_salida: db 27,"[2J",27,"[00;00H"									
	cons_sz_salida: equ 12

	cons_espacio: db 27,"[1C" ;espacio a la izquierda de la plataforma y para la bola
	cons_sz_espacio: equ $-cons_espacio
		
	cons_plataforma: db 27,"[47;37m",'_________', 27, '[0m'
	cons_sz_plataforma: equ $-cons_plataforma      ; Longitud del banner
		
	cons_mov_plataforma: dq 4
	tecla:  db''   
		
	termios: times 36 db 0                   ;Estructura de 36bytes que contiene el modo de operacion de la consola
	stdin: equ 0                             ;Standard Input (se usa stdin en lugar de escribir manualmente los valores)
	ICANON: equ 1<<1                         ;ICANON: Valor de control para encender/apagar el modo canonico
	ECHO: equ 1<<3                           ;ECHO: Valor de control para encender/apagar el modo de eco
	VTIME: equ 4
	VMIN: equ 5
	CC_C: equ 18

;--------------------Declaracion de funciones y utilidades ---------------------------------------------

;#######################	canonical_off	#############################
;Esta es una funcion que sirve para apagar el modo canonico en Linux
;Cuando el modo canonico se apaga, Linux NO espera un ENTER para
;procesar lo que se captura desde el teclado, sino que se hace de forma
;directa e inmediata
;
;Para apagar el modo canonico, simplemente use: call canonical_off
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
	mov byte [termios+CC_C+VTIME],1                 ; se establece el tiempo de espera en 1ds
	pop rax

		;Se escribe la nueva configuracion de TERMIOS
	call write_stdin_termios
	ret
;#######################	Final de canonical_off 	 ###############################


;#######################	echo_off	#############################
;Esta es una funcion que sirve para apagar el modo echo en Linux
;Cuando el modo echo se apaga, Linux NO muestra en la pantalla la tecla que
;se acaba de presionar.
;
;Para apagar el modo echo, simplemente use: call echo_off
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
;#######################	Final de echo_off 	############################


;#####################	canonical_on	###############################
;Esta es una funcion que sirve para encender el modo canonico en Linux
;Cuando el modo canonico se enciende, Linux espera un ENTER para
;procesar lo que se captura desde el teclado
;
;Para encender el modo canonico, simplemente use: call canonical_on
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
;####################	Final de canonical_on 	###############################


;######################		echo_on		##############################
;Esta es una funcion que sirve para encender el echo en Linux
;Cuando el echo se enciende, Linux muestra en la pantalla (stdout) cada tecla
;que se recibe del teclado (stdin)
;
;Para encender el modo echo, simplemente use: call echo_on
echo_on:

	;Se llama a la funcion que lee el estado actual del TERMIOS en STDIN
		;TERMIOS son los parametros de configuracion que usa Linux para STDIN
	call read_stdin_termios

		;Se escribe el nuevo valor de modo echo
	or dword [termios+12], ECHO

		;Se escribe la nueva configuracion de TERMIOS
	call write_stdin_termios
	ret
;######################		Final de echo_on		#############################


;###################### 	read_stdin_termios 		##############################
;Esta es una funcion que sirve para leer la configuracion actual del stdin o 
;teclado directamente de Linux
;Esta configuracion se conoce como TERMIOS (Terminal Input/Output Settings)
;Los valores del stdin se cargan con EAX=36h y llamada a la interrupcion 80h
;
;Para utilizarlo, simplemente se usa: call read_stdin_termios
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
;####################	Final de read_stdin_termios		###############################


;#######################	write_stdin_termios		#############################
;Esta es una funcion que sirve para escribir la configuracion actual del stdin o 
;teclado directamente de Linux
;Esta configuracion se conoce como TERMIOS (Terminal Input/Output Settings)
;Los valores del stdin se cargan con EAX=36h y llamada a la interrupcion 80h
;
;Para utilizarlo, simplemente se usa: call write_stdin_termios
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
		;
;##################		Final de write_stdin_termios	#################################


section .text
	global _start

_start:
	limpiar_pantalla limpiar,limpiar_tam			;limpia la pantalla

	
	imprimir cons_superior   ,cons_superior_size		;imprimir linea superior de techo

	call canonical_off 		;apaga la funcion canonical	
	call echo_off 			;apaga la funcion echo
	mov r9,55				;(55x2=110, eso xq uso el caracter y un espacio)
	mov r10,50				;define la cantidad de espacios inicial de la plataforma
	mov r13, 57 			;se inicializa r13 usado para posicion en x de la bola
	mov r12, 39				;se inicializa r12 usado para posicion en y de la bola
	mov r8, 0x0				;se inicializa r8 usado para referirse al ciclo de movimiento de la bola

superior: cmp r9,0
	je sig
	imprimir cons_carh  ,cons_carh_size
	dec r9
	jmp superior	

sig:						;colocar posicion incial vertical 
	mov r9,42
	imprimir cons_izquierda ,cons_izquierda_size

posver: 					;imprimir los caracteres verticales	
	cmp r9,0
	je bloques
	imprimir  cons_carv , cons_carv_size
	dec r9
	jmp posver

;+++++++++++++++++++++++++	Imprime bloques		++++++++++++++++++++++++++++++++++
bloques:	
	imprimir  b11 , b_size		; imprime b11
	imprimir  b12 , b_size		; imprime b12
	imprimir  b13 , b_size		; imprime b13
	imprimir  b14 , b_size		; imprime b14
	imprimir  b15 , b_size		; imprime b15
	imprimir  b16 , b1_size	; imprime b16

	imprimir  b21 , b_size		; imprime b21
	imprimir  b22 , b_size		; imprime b22
	imprimir  b23 , b_size		; imprime b23
	imprimir  b24 , b_size		; imprime b24
	imprimir  b25 , b_size		; imprime b25
	imprimir  b26 , b2_size	; imprime b26

	imprimir  b31 , b_size		; imprime b31
	imprimir  b32 , b_size		; imprime b32
	imprimir  b33 , b_size		; imprime b33
	imprimir  b34 , b_size		; imprime b34
	imprimir  b35 , b_size		; imprime b35
	imprimir  b36 , b3_size	; imprime b36
;-+++++++++++++++++++	Fin de impresión de bloques		+++++++++++++++++++++++++++++++

;colocar cursor posicion incial inf 	
	imprimir  cons_inferior, cons_inferior_size	
	mov r9,55
inferior: 
	cmp r9,0
	je _refresh_plataforma
	imprimir  cons_carh, cons_carh_size
	dec r9
	jmp inferior


	imprimir cons_jugador  ,cons_jugador_size  		;imprime jugador en la primera linea
	
;imprime vidas en la primera linea
	imprimir cons_vidas   ,cons_vidas_size  
	imprimir cons_corazon1   ,cons_corazon_size
	imprimir cons_corazon2   ,cons_corazon_size
	imprimir cons_corazon3   ,cons_corazon_size

_refresh_plataforma:						;Refresca la plataforma en caso de que se indicara movimiento
	imprimir  cons_pospl, cons_sz_pospl		;mover cursor a la fila donde se debe colocar la plataforma
	imprimir  cons_erasep, cons_sz_erasep	;borra la plataforma (parte 1)
	imprimir  cons_erasep, cons_sz_erasep	;borra la plataforma (parte 2)
	imprimir  cons_pospl, cons_sz_pospl		;vuelve a poner el cursor en la fila de la plataforma
	push r9
	mov r9,1
_espacios:									;Se desplaza los espacios necesarios para posicionar la plataforma
	cmp r10,r9
	je _plataforma
	imprimir  cons_espacio, cons_sz_espacio				;imprime los espacios para la plataforma
	inc r9                                              ;se incrementa r9 en 1
	jmp _espacios                                       ;regresa a _espacios

_plataforma:								;Imprimir la plataforma
	pop r9
	imprimir  cons_plataforma, cons_sz_plataforma		;imprime la plataforma
	call _cursor_pos
	mov rax, [cons_mov_plataforma]
	cmp rax,4
	je _borrar_bola
_bpoint:
	mov rax, [cons_mov_plataforma]
	cmp rax,1
	je _borrar_bola
	jmp _read_tecla

_posiciones:		;reinicia los valores de las posiciones
	mov r15, 1 		;contador para los espacios en x
	mov r14, 1 		;contador para los espacios en y
_pos_y:
	cmp r14, r12
	je _pos_x
	imprimir espacio_y, espacio_y_tam				;se mueve en un espacio hacia abajo
	inc r14
	jmp _pos_y
_pos_x:
	cmp r15,r13
	je _regreso
	imprimir cons_espacio, cons_sz_espacio			;se mueve un espacio hacia la derecha
	inc r15
	jmp _pos_x
_regreso:
	ret

_borrar_bola:
	mov rax,4
	mov [cons_mov_plataforma],rax
	call _posiciones
	imprimir espacio, espacio_tam 					;ahora se borra la bola
	call _cursor_pos 
	push r15																						
	push r14
	mov r14, 0								;Pongo el cusor de nuevo en el inicio
	mov r15, [condicion]
	cmp r15, r14
	je _imprimir_bola
	jne _ciclos

_imprimir_bola:
	pop r14
	pop r15
	call _posiciones
	imprimir bola, bola_tam						;imprime la bola
	call _cursor_pos 							;Pongo el cusor de nuevo en el inicio
	push r13
	mov r13, 1									;reestablece el contador del tiempo
_delay:											;generador del delay 
 	cmp r13, 10000000							;cantidad de tiempo de espera
 	je _r_tecla
 	inc r13
 	jmp _delay		;continua con el ciclo hasta que se cumpla el tiempo estipulado

_r_tecla:
	pop r13
_read_tecla:								;Lectura de la tecla
	leer tecla, 1		;Capturar una tecla presionada en el teclado
	;Comparar la tecla con el movimiento a la izquierda/derecha
	push r8
	push r9
	mov r8,[tecla]                           	    ;rax = tecla capturada
	mov r9,'z'                               	    ;rbx = constante de movimiento a la izquierda
	cmp r8,r9                                	    ;comparacion
	je _izquierda                            	    ;salto a .izquierda
	mov r9,'c'                                  	;rbx = constante de movimiento a la derecha
	cmp r8,r9                                   	;comparacion
	je _derecha                                 	;salto a .derecha
	mov r9, 'h'
	cmp r8, r9
	je salir
	mov r9,'x'
	cmp r8,r9
	je _cambio_condicion
	mov [tecla],rax
	pop r9
	pop r8
	jmp _borrar_bola							;Refresca

_cambio_condicion:
	pop r9
	pop r8
	mov rax, 1
	mov [condicion], rax
	jmp _borrar_bola

_izquierda:									;movimiento hacia la izquierda de la plataforma
	pop r9
	pop r8
	mov rax, [condicion]
	cmp rax, 0
	je _read_tecla
	cmp r10,1
	je _borrar_bola
	dec r10
	mov [tecla],rax
	push r10
	mov r10, [cons_mov_plataforma]
	dec r10
	mov [cons_mov_plataforma],r10
	pop r10
	jmp _refresh_plataforma					;Refresca
_derecha:									;movimiento hacia la derecha de la plataforma
	pop r9
	pop r8
	mov rax, [condicion]
	cmp rax, 0
	je _read_tecla
	cmp r10,100
	je _borrar_bola
	inc r10
	mov [tecla],rax
	push r10
	mov r10, [cons_mov_plataforma]
	dec r10
	mov [cons_mov_plataforma],r10
	pop r10
	jmp _refresh_plataforma						;Refresca

_ciclos:
	pop r14
	pop r15
	cmp r8, 0x0
	je _ciclo_a
	cmp r8, 0x1
	je _ciclo_b
	cmp r8, 0x2
	je _ciclo_c
	cmp r8, 0x3
	je _ciclo_d

;*******************************	Movimientos en 45º	************************************
;Ciclos de movimiento
_ciclo_a:						;movimiento arriba-derecha
	mov r8, 0x0					;cambio de la constante para poder volver ciclicamente al proceso
	cmp r15, 111				;limite derecho
	je _ciclo_b
	cmp r14, 10					;limite superior
	je _ciclo_d
	call _mov_arriba
	call _mov_derecha
	push r13
	jmp _imprimir_bola
_ciclo_b:						;movimiento arriba-izquierda
	mov r8, 0x1					;cambio de la constante para poder volver ciclicamente al proceso
	cmp r12, 10					;limite superior
	je _ciclo_c
	cmp r13, 4					;limite izquierdo
	je _ciclo_a
	call _mov_arriba
	call _mov_izquierda
	push r13
	jmp _imprimir_bola
_ciclo_c:						;movimiento abajo-izquierda
	mov r8, 0x2					;cambio de la constante para poder volver ciclicamente al proceso
	cmp r13, 4					;limite izquierdo
	je _ciclo_d
	cmp r12, 39					;limite inferior
	je _ciclo_b	
	call _mov_izquierda
	call _mov_abajo
	push r13
	jmp _imprimir_bola
_ciclo_d:						;movimiento abajo-derecha
	mov r8, 0x3					;cambio de la constante para poder volver ciclicamente al proceso
	cmp r13, 111				;limite derecho
	je _ciclo_c
	cmp r12, 39					;limite inferior
	je _ciclo_a
	call _mov_abajo
	call _mov_derecha
	push r13
	jmp _imprimir_bola

;Movimientos bàsicos
_mov_arriba:					;movimiento hacia arriba en 45º
	dec r12
	ret
_mov_derecha:					;movimiento hacia derecha en 45º
	inc r13
	ret
_mov_abajo:						;movimiento hacia abajo en 45º
	inc r12
	ret
_mov_izquierda:					;movimiento hacia izquierda en 45º
	dec r13
	ret
;******************************	Fin Movimientos en 45º	*******************************

_cursor_pos:					;genera que el cursor se coloque al inicio de la pantalla
	imprimir set_cursor, set_cursor_tam
	ret

salir:
	imprimir cons_salir, cons_salir_size	
	call canonical_on  						;vuelve a encender canonical			
	call echo_on 							;vuelve a encender echo
	mov rax,60          				    ;se carga la llamada 60d (sys_exit
	mov rdi,0              				    ;en rdi se carga un 0
	syscall                				    ;se llama al sistema.

;fin del programa
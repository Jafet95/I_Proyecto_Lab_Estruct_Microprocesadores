;#####################################################
;El siguiente código corresponde a la implementación
;del juego clásico arkanoid
;#####################################################

;==============================Declaracion de constantes y datos============================

section .data
	cons_bienvenida: db 0x1b,"[2J",0x1b,"[1m",0x1b,"[30G",'¡Bienvenido al juego Arkanoid!',0xa, 0xa
	cons_size_bienvenida: equ $-cons_bienvenida

	cons_title: db 'I Proyecto de EL-4313-Lab.Estructura de Microprocesadores 2S-2016', 0xa, 0xa
	cons_size_title: equ $-cons_title

	cons_player: db 'Ingrese el nombre del jugador y presione la tecla Enter: '
	cons_size_player: equ $-cons_player

section .bss	
	nombre_jugador: resb 10 ; se crea una variable no inicializada para guardar el nombre del jugador (10 bytes)

;==============================Código============================

section .text
	 global _start

_start:
	call pantalla_inicial

pantalla_inicial:

	;Primer paso: Imprimir el mensaje de la pantalla inicial y captura del nombre del jugador

	;Imprime Bienvenida
	mov rax,1							;rax = "sys_write"
	mov rdi,1							;rdi = 1 (standard output = pantalla)
	mov rsi,cons_bienvenida				;rsi = mensaje a imprimir
	mov rdx,cons_size_bienvenida		;rdx=tamano del string
	syscall

	;Imprime título
	mov rax,1							;rax = "sys_write"
	mov rdi,1							;rdi = 1 (standard output = pantalla)
	mov rsi,cons_title					;rsi = mensaje a imprimir
	mov rdx,cons_size_title				;rdx=tamano del string
	syscall

	;Imprime mensaje de solicitud del nombre del jugador
	mov rax,1							;rax = "sys_write"
	mov rdi,1							;rdi = 1 (standard output = pantalla)
	mov rsi,cons_player					;rsi = mensaje a imprimir
	mov rdx,cons_size_player			;rdx=tamano del string
	syscall

	;Capturar el nombre del jugador (*Límite del tamaño del nombre por definir*)
	mov rax,0							;rax = "sys_read"
	mov rdi,0							;rdi = 0 (standard input = teclado)
	mov rsi,nombre_jugador				;rsi = direccion de memoria donde se almacena la tecla capturada
	mov rdx,10							;rdx=10 (cuantos eventos o teclazos capturar)
	syscall								;Llamar al sistema

	;Salida del programa
	mov rax,60						;se carga la llamada 60d (sys_exit) en rax
	mov rdi,0							;en rdi se carga un 0
	syscall								;se llama al sistema.

	ret


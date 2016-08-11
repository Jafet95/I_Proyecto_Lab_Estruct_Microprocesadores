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

section .data ; 

	limpiar    db 0x1b, "[2J", 0x1b, "[H"; caracteres para limpiar la pantalla
	limpiar_tam equ $ - limpiar

        cons_jugador: db 0x1b, "[1J", 0x1b, "[1;3f", 0x1b, "[1m", 0x1b, "[40;32m", ' Jugador:', 0x1b, "[40;30m",' ',  0x1b, "[40;37m"
        cons_jugador_size: equ $-cons_jugador

	cons_vidas: db 0x1b, "[1;60f",  0x1b, "[1m", 0x1b, "[40;32m",  'Vidas:', 0x1b, "[40;30m",' ', 0x1b, "[40;37m",0xa
	cons_vidas_size:equ $-cons_vidas

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
	b11: db 0x1b, "[5;15f", 0x1b, "[42;32m", '__________', 0x1b, "[40;30m",'   ',0x1b, "[40;37m"
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
section .text
        global _start

_start:
	limpiar_pantalla limpiar,limpiar_tam; funcion macro para limpiar

	;imprime jugador en la primera linea
	imprimir cons_jugador  ,cons_jugador_size           
	
	;imprime vidas en la primera linea
	imprimir cons_vidas   ,cons_vidas_size  
	
; colocar posicion incial sup -- -- - - - -- - - - - -- - - - - - - - - -
	imprimir cons_superior   ,cons_superior_size

; imprimir linea superior de techo
	mov r9,55	; (x2=110, eso xq uso el caracter y un espacio)
superior: cmp r9,0
	je sig
	imprimir cons_carh  ,cons_carh_size
	dec r9
	jmp superior	;-----------


; colocar posicion incial vertical ****************************
sig:mov r9,42
	imprimir cons_izquierda ,cons_izquierda_size
	
posver: 
	cmp r9,0
	je bloques
	imprimir  cons_carv , cons_carv_size
	dec r9
	jmp posver

bloques:;+++++++++++++++++++++++++++++++++++++++++++++++++++++
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
;-++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

; colocar posicion incial inf 
;posinf:	
	imprimir  cons_inferior, cons_inferior_size	
	mov r9,55
inferior: cmp r9,0
	je salir
	imprimir  cons_carh, cons_carh_size
	dec r9
	jmp inferior ; - - -- - - - --  - -- - -- - -- -- - - - - - - -

salir:
	imprimir cons_salir, cons_salir_size

        ;Ultimo paso: Salida del programa
        mov rax,60                    ;se carga la llamada 60d (sys_exi$
        mov rdi,0                     ;en rdi se carga un 0
        syscall                       ;se llama al sistema.

;fin del programa







;------------------------------------------------------------------------------------------------$
; prueba realizar una linea
;------------------------------------------------------------

section .data ; 

        cons_jugador: db 0x1b, "[1J", 0x1b, "[1;3f", 0x1b, "[1m", 0x1b, "[40;32m", ' Jugador:', 0x1b, "[40;30m",' ',  0x1b, "[40;37m"
        cons_jugador_size: equ $-cons_jugador

	cons_vidas: db 0x1b, "[1;60f",  0x1b, "[1m", 0x1b, "[40;32m",  'Vidas:', 0x1b, "[40;30m",' ', 0x1b, "[40;37m",0xa
	cons_vidas_size:equ $-cons_vidas

        cons_carv: db  0x1b, "[1m", '  *' ,0xa ; caracter a dibujar para los bordes verticales
	cons_carv_size: equ $-cons_carv

        cons_carh: db 0x1b, "[1m", '* '; caracter horizontal
        cons_carh_size: equ $-cons_carh

	cons_superior: db 0x1b, "[2;1f", '  '; esquina superior izquierda
	cons_superior_size: equ $-cons_superior

	cons_inferior: db 0x1b, "[43;1f", '  '	;esquina inferior izquierda
	cons_inferior_size: equ $-cons_inferior

	cons_izquierda: db 0x1b, "[3;1f",''
	cons_izquierda_size: equ $-cons_izquierda

	cons_derecha: db '                                                                                                            '
	cons_derecha_size: equ $-cons_derecha

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
	
        cons_salir:db  0x1b, "[0J", '',0x1b, "[40;37m",0xa
        cons_salir_size: equ $-cons_salir

section .text
        global _start


_start:
	;imprime jugador en la primera linea
	mov rax,1                        ;rax = "sys_write"
        mov rdi,1                        ;rdi = 1 (standard output$
        mov rsi,cons_jugador             ;rsi = mensaje a imprimir
        mov rdx,cons_jugador_size        ;rdx=tamano del string
        syscall 
	
	;imprime vidas en la primera linea
	mov rax,1                        ;rax = "sys_write"
        mov rdi,1                        ;rdi = 1 (standard output$
        mov rsi,cons_vidas             ;rsi = mensaje a imprimir
        mov rdx,cons_vidas_size        ;rdx=tamano del string
        syscall 

; colocar posicion incial sup -- -- - - - -- - - - - -- - - - - - - - - -
	mov rax,1
	mov rdi,1
	mov rsi,cons_superior
	mov rdx,cons_superior_size
	syscall
 
	mov r9,55	; (x2=110, eso xq uso el caracter y un espacio)
superior: cmp r9,0
	je sig
	mov rax,1
	mov rdi,1
	mov rsi, cons_carh
	mov rdx, cons_carh_size
	syscall
	dec r9
	jmp superior	;-----------

; colocar posicion incial vertical derecha+++++++++++++++++++++++++++++++
sig:
	mov r9,42 ; 42 xq cuenta la fila del nombre y del marco
posverder: 
	mov rax,1
	mov rdi,1
	mov rsi,cons_derecha
	mov rdx,cons_derecha_size
	syscall

	cmp r9,0
	je sig2
	mov rax,1
	mov rdi,1
	mov rsi, cons_carv
	mov rdx, cons_carv_size
	syscall
	dec r9
	jmp posverder

; colocar posicion incial vertical izquierda****************************
sig2:mov r9,42
	mov rax,1
	mov rdi,1
	mov rsi,cons_izquierda
	mov rdx,cons_izquierda_size
	syscall
posveriz: 
	cmp r9,0
	je bloques
	mov rax,1
	mov rsi, cons_carv
	mov rdx, cons_carv_size
	syscall
	dec r9
	jmp posveriz

bloques:;+++++++++++++++++++++++++++++++++++++++++++++++++++++
mov rax,1; imprime b11
	mov rdi,1
	mov rsi,b11
	mov rdx,b_size
	syscall
	mov rax,1; imprime b12
        mov rdi,1
        mov rsi,b12
        mov rdx,b_size
        syscall
	mov rax,1; imprime b13
        mov rdi,1
        mov rsi,b13
        mov rdx,b_size
        syscall
	mov rax,1; imprime b14
        mov rdi,1
        mov rsi,b14
        mov rdx,b_size
        syscall
        mov rax,1; imprime b15
        mov rdi,1
        mov rsi,b15
        mov rdx,b_size
        syscall
        mov rax,1; imprime b16
        mov rdi,1
        mov rsi,b16
        mov rdx,b_size
        syscall;-------------------------------------

	mov rax,1; imprime b21
        mov rdi,1
        mov rsi,b21
        mov rdx,b_size
        syscall
        mov rax,1; imprime b22
        mov rdi,1
        mov rsi,b22
        mov rdx,b_size
        syscall
        mov rax,1; imprime b23
        mov rdi,1
        mov rsi,b23
        mov rdx,b_size
        syscall
        mov rax,1; imprime b24
        mov rdi,1
        mov rsi,b24
        mov rdx,b_size
        syscall
        mov rax,1; imprime b25
        mov rdi,1
        mov rsi,b25
        mov rdx,b_size
        syscall
        mov rax,1; imprime b26
        mov rdi,1
        mov rsi,b26
        mov rdx,b_size
        syscall;-----------------------------

	mov rax,1; imprime b31
        mov rdi,1
        mov rsi,b31
        mov rdx,b_size
        syscall
        mov rax,1; imprime b32
        mov rdi,1
        mov rsi,b32
        mov rdx,b_size
        syscall
        mov rax,1; imprime b33
        mov rdi,1
        mov rsi,b33
        mov rdx,b_size
        syscall
        mov rax,1; imprime b34
        mov rdi,1
        mov rsi,b34
        mov rdx,b_size
        syscall
        mov rax,1; imprime b35
        mov rdi,1
        mov rsi,b35
        mov rdx,b_size
        syscall
        mov rax,1; imprime b36
        mov rdi,1
        mov rsi,b36
        mov rdx,b_size
        syscall
;-++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
; colocar posicion incial inf - -- - - -- -  - -- - - -- - -- - - -- - - -- - - - -
;posinf:	
	mov rax,1
	mov rdi,1
	mov rsi,cons_inferior
	mov rdx,cons_inferior_size
	syscall
	mov r9,55
inferior: cmp r9,0
	je salir
	mov rax,1
	mov rdi,1
	mov rsi, cons_carh
	mov rdx, cons_carh_size
	syscall
	dec r9
	jmp inferior ; - - -- - - - --  - -- - -- - -- -- - - - - - - -

salir:
        mov rax,1                     ;rax = "sys_write"
        mov rdi,1                     ;rdi = 1 (standard output$
        mov rsi,cons_salir            ;rsi = mensaje a imprimir
        mov rdx,cons_salir_size       ;rdx=tamano del string
        syscall                       ;llamar al sistema
        ;Ultimo paso: Salida del programa
        mov rax,60                    ;se carga la llamada 60d (sys_exi$
        mov rdi,0                     ;en rdi se carga un 0
        syscall                       ;se llama al sistema.

;fin del programa







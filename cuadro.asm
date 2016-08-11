;------------------------------------------------------------------------------------------------$
; prueba realizar una linea
;------------------------------------------------------------

section .data ; (80 guiones)

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

	mov r8,0
	mov r9,55
superior: cmp r9,r8
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
	mov r10,42
posverder: 
	mov rax,1
	mov rdi,1
	mov rsi,cons_derecha
	mov rdx,cons_derecha_size
	syscall

	cmp r10,r8
	je sig2
	mov rax,1
	mov rdi,1
	mov rsi, cons_carv
	mov rdx, cons_carv_size
	syscall
	dec r10
	jmp posverder

; colocar posicion incial vertical izquierda****************************
sig2:mov r10,42
	mov rax,1
	mov rdi,1
	mov rsi,cons_izquierda
	mov rdx,cons_izquierda_size
	syscall
posveriz: 
	cmp r10,r8
	je posinf
	mov rax,1
	mov rsi, cons_carv
	mov rdx, cons_carv_size
	syscall
	dec r10
	jmp posveriz

; colocar posicion incial inf - -- - - -- -  - -- - - -- - -- - - -- - - -- - - - -
posinf:	
	mov rax,1
	mov rdi,1
	mov rsi,cons_inferior
	mov rdx,cons_inferior_size
	syscall
	mov r8,0
	mov r9,55
inferior: cmp r9,r8
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







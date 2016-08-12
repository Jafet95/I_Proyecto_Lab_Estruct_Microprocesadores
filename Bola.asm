section .data
	limpiar: db 27, '[2J', 27, '[00;00H', 27 ,'[?25l'
	limpiar_tam: equ $-limpiar
	
	set_cursor: db 27,'[00;00H' 
	set_cursor_tam: equ $-set_cursor

	bola: db 27, '[1m', 111
	bola_tam: equ $-bola

	espacio: db ' '
	espacio_tam: equ $-espacio
	cons_espacio: db 27, "[1C"
	cons_espacio_tam: equ $-cons_espacio
	espacio_y: db 27, "[1E"
	espacio_y_tam: equ $-espacio_y

	condicion: db 0

section .text
	global _start

_start:
	mov rax, 1
	mov rdi, 1
	mov rsi, limpiar
	mov rdx, limpiar_tam
	syscall
 	mov r13, 55 			; se usa r13 como cte_posicion_x
 	mov r12, 35				; se usa r12 como cte_posicion_y
 	mov r8, 0x0
 	push r13
_posiciones:		;reinicia los valores de las posiciones
	mov r15, 1 		;contador para los espacios en x
	mov r14, 1 		;contador para los espacios en y	
	pop r13
_pos_y:
	cmp r14, r12
	je _pos_x
	;se mueve en un espacio hacia abajo
	mov rax, 1
	mov rdi,1
	mov rsi, espacio_y
	mov rdx, espacio_y_tam
	syscall
_bpoint2:
	inc r14
	jmp _pos_y

_pos_x:
	cmp r15,r13
	je _imprimir_bola
	mov rax, 1
	mov rdi, 1
	mov rsi, cons_espacio
	mov rdx, cons_espacio_tam
	syscall
	inc r15
	jmp _pos_x

_imprimir_bola:
	push r13
	mov rax, [condicion]
	cmp rax,1			;esta condicion es para poder generalizar las rutinas de posicion
	je _borrar_bola
	mov rax, 1
	mov [condicion], rax
	mov rax, 1				;imprime la bola
	mov rdi, 1
	mov rsi, bola
	mov rdx, bola_tam
	syscall
	call _cursor_pos ;Pongo el cusor de nuevo en el inicio
	mov r13, 0		;reestablece el contador del tiempo
_delay:			;generador del delay 
 	cmp r13, 300000000	;cantidad de tiempo de espera
 	je _posiciones
 	inc r13
 	jmp _delay		;continua con el ciclo hasta que se cumpla el tiempo estipulado

_borrar_bola:
	pop r13
	mov rax, 0
	mov [condicion], rax
	mov rax, 1		;ahora se borra la bola
	mov rdi, 1
	mov rsi, espacio
	mov rdx, espacio_tam
	syscall
	call _cursor_pos ;Pongo el cusor de nuevo en el inicio
	cmp r8, 0x0
	je _ciclo_a
	cmp r8, 0x1
	je _ciclo_b
	cmp r8, 0x2
	je _ciclo_c
	cmp r8, 0x3
	je _ciclo_d
	jmp _cerrar_programa

_ciclo_a:
	mov r8, 0x0
	cmp r15, 109				;limite derecho
	je _ciclo_b
	cmp r14, 7					;limite superior
	je _ciclo_d
	call _mov_arriba
	call _mov_derecha
	push r13
	jmp _posiciones

_ciclo_b:
	mov r8, 0x1
	cmp r12, 7					;limite superior
	je _ciclo_c
	cmp r13, 1					;limite izquierdo
	je _ciclo_a
	call _mov_arriba
	call _mov_izquierda
	push r13
	jmp _posiciones

_ciclo_c:
	mov r8, 0x2
	cmp r13, 1					;limite izquierdo
	je _ciclo_d
	cmp r12, 35					;limite inferior
	je _ciclo_b	
	call _mov_izquierda
	call _mov_abajo
	push r13
	jmp _posiciones

_ciclo_d:
	mov r8, 0x3
	cmp r13, 109				;limite derecho
	je _ciclo_c
	cmp r12, 35					;limite inferior
	je _ciclo_a
	call _mov_abajo
	call _mov_derecha
	push r13
	jmp _posiciones

_mov_arriba:
	dec r12
	ret
_mov_derecha:
	inc r13
	ret
_mov_abajo:
	inc r12
	ret
_mov_izquierda:
	dec r13
	ret

_cerrar_programa:
 	;Para salir
 	mov rax, 1
	mov rdi,1
	mov rsi, espacio_y
	mov rdx, espacio_y_tam
	syscall
 	mov rax,60
 	mov rdi,0
 	syscall

_cursor_pos:
	mov rax, 1			
	mov rdi, 1
	mov rsi, set_cursor
	mov rdx, set_cursor_tam
	syscall
	ret
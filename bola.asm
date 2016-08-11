section .data
	limpiar: db 27, '[2J', 27, '[00;00H', 27 ,'[25m'
	limpiar_tam: equ $-limpiar
	set_cursor: db 27, '[00;00H'
	set_cursor_tam: equ $-set_cursor

	bola: db 27, '[1m', 111
	bola_tam: equ $-bola

	espacio_x: db ' '
	espacio_x_tam: equ $-espacio_x
	espacio_y: db '',0xa
	espacio_y_tam: equ $-espacio_y

	condicion: db 0
	condicion_ciclo: db 0

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
 	push r13
.posiciones:		;reinicia los valores de las posiciones
	mov r15, 1 		;contador para los espacios en x
	mov r14, 1 		;contador para los espacios en y
	pop r13
.pos_y:
	cmp r14, r12
	je .pos_x
	;se mueve en un espacio hacia abajo
	mov rax, 1
	mov rdi,1
	mov rsi, espacio_y
	mov rdx, espacio_y_tam
	syscall
	inc r14
	jmp .pos_y

.pos_x:
	cmp r15,r13
	je .imprimir_bola
	mov rax, 1
	mov rdi, 1
	mov rsi, espacio_x
	mov rdx, espacio_x_tam
	syscall
	inc r15
	jmp .pos_x

.imprimir_bola:
	push r13
	mov rax, [condicion]
	cmp rax,1			;esta condicion es para poder generalizar las rutinas de posicion
	je .borrar_bola
	mov rax, 1
	mov [condicion], rax
	mov rax, 1				;imprime la bola
	mov rdi, 1
	mov rsi, bola
	mov rdx, bola_tam
	syscall
	call .cursor_pos ;Pongo el cusor de nuevo en el inicio
	mov r13, 0		;reestablece el contador del tiempo
.delay:			;generador del delay 
 	cmp r13, 500000000	;cantidad de tiempo de espera
 	je .posiciones
 	inc r13
 	jmp .delay		;continua con el ciclo hasta que se cumpla el tiempo estipulado

.borrar_bola:
	pop r13
	mov rax, 0
	mov [condicion], rax
	mov rax, 1		;ahora se borra la bola
	mov rdi, 1
	mov rsi, espacio_x
	mov rdx, espacio_x_tam
	syscall
	call .cursor_pos ;Pongo el cusor de nuevo en el inicio
	mov rax, [condicion_ciclo]
	cmp rax, 0
	je .ciclo_a
	jmp .cerrar_programa
	mov rax, [condicion_ciclo]
	cmp rax, 1
	je .ciclo_b
	mov rax, [condicion_ciclo]
	cmp rax, 2
	je .ciclo_c
	mov rax, [condicion_ciclo]
	cmp rax, 3
	je .ciclo_d
	jmp .cerrar_programa


.ciclo_a:
	mov rax, 0
	mov [condicion_ciclo], rax
	cmp r15, 109				;limite derecho
	je .ciclo_b
	cmp r14, 7					;limite superior
	je .ciclo_d
	call .mov_arriba
	call .mov_derecha
	push r13
	jmp .posiciones

.ciclo_b:
	mov rax, 1
	mov [condicion_ciclo], rax
	cmp r14, 7					;limite superior
	je .ciclo_c
	cmp r15, 1					;limite izquierdo
	je .ciclo_a
	call .mov_arriba
	call .mov_izquierda
	push r13
	jmp .posiciones

.ciclo_c:
	mov rax, 2
	mov [condicion_ciclo], rax
	cmp r15, 1					;limite izquierdo
	je .ciclo_d
	cmp r14, 35					;limite inferior
	je .ciclo_b	
	call .mov_izquierda
	call .mov_abajo
	push r13
	jmp .posiciones

.ciclo_d:
	mov rax, 3
	mov [condicion_ciclo], rax
	cmp r15, 109				;limite derecho
	je .ciclo_c
	cmp r14, 35					;limite inferior
	je .ciclo_a
	call .mov_abajo
	call .mov_derecha
	push r13
	jmp .posiciones

.mov_arriba:
	dec r12
	;mov r12, r14
	;jmp .cerrar_programa
	ret
.mov_derecha:
	inc r13
	;mov r13, r15
	ret
.mov_abajo:
	inc r12
	;mov r12, r14
	ret
.mov_izquierda:
	dec r13
	;mov r13, r15
	ret

.cerrar_programa:
 	;Para salir
 	mov rax, 1
	mov rdi,1
	mov rsi, espacio_y
	mov rdx, espacio_y_tam
	syscall
 	mov rax,60
 	mov rdi,0
 	syscall

.cursor_pos:
	mov rax, 1			
	mov rdi, 1
	mov rsi, set_cursor
	mov rdx, set_cursor_tam
	syscall
	ret